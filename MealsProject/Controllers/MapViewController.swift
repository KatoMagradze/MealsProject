//
//  MapViewController.swift
//  MealsProject
//
//  Created by Kato on 7/7/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    
    let apiservice = APIService()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var allAreas = [Area]()
    var filteredAreas = [Filter]()
    var filteredArea: Area?
    
    var mealDataArr = [Meal]()
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.showsHorizontalScrollIndicator = false
        
        apiservice.fetchAllAreas { (allAreas) in
            
            for area in allAreas.meals {
                self.allAreas.append(area)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        self.filterFood(areas: "American")
        
    }
    
    func addMapAnnotation(clickedArea: String) {
        let annotation = MKPointAnnotation()
        
        let coordinatesArr = getCoordinates(area: clickedArea)
        let allAnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnotations)
        if coordinatesArr.count == 2 {
            annotation.coordinate = CLLocationCoordinate2D(latitude: coordinatesArr[0], longitude: coordinatesArr[1])
            mapView.addAnnotation(annotation)
        }
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 10_000_000, longitudinalMeters: 10_000_000)
        mapView.setRegion(region, animated: true)
    }
    
    
    func filterFood(areas: String) {
        apiservice.fetchFilteredAreas(completion: { (filteredAreas) in
            
            for area in filteredAreas.meals {
                self.filteredAreas.append(area)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, area: areas)
    }
    
}

extension MapViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allAreas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AreasCell.identifier, for: indexPath) as! AreasCell
        
        cell.areaLabel.text = allAreas[indexPath.row].strArea
        cell.areaBackgroundView.layer.cornerRadius = 96/2
        
        let yellowColor = hexStringToUIColor(hex: "#FFD479")
        cell.areaBackgroundView.layer.borderColor = yellowColor.cgColor
        cell.areaBackgroundView.layer.borderWidth = 5
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.addMapAnnotation(clickedArea: allAreas[indexPath.row].strArea)
        self.filteredAreas.removeAll()
        self.filterFood(areas: allAreas[indexPath.row].strArea)
        
        //tableView.reloadData()
    }
    
}

extension MapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAreas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FilteredAreasCell.identifier, for: indexPath) as! FilteredAreasCell
        
        cell.delegate = self
        
        filteredAreas[indexPath.row].strMealThumb.downloadImage(completion: { (image) in
            DispatchQueue.main.async {
                cell.filteredAreaImageView.image = image
            }
        })
        
        cell.filteredAreaLabel.text = filteredAreas[indexPath.row].strMeal
        cell.id = filteredAreas[indexPath.row].idMeal
        cell.filteredAreaImageView.layer.cornerRadius = 90/2
        
        let yellowColor = hexStringToUIColor(hex: "#FFD479")
        
        cell.detailsButton.layer.cornerRadius = 20
        cell.detailsButton.layer.borderColor = yellowColor.cgColor
        cell.detailsButton.layer.borderWidth = 2
        cell.addToFavsLabel.layer.cornerRadius = 20
        
        //let tempIndex : Int =  indexPath.row
        //cell.detailsButton.setDetailedButtonIndex(buttonIndex: tempIndex)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
    }
}

extension MapViewController: DetailsProtocol {
    
    
    func didTapDetails(mealID: String) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "meal_details_vc")
        if let vc = detailsVC as? MealDetailsViewController {
            vc.id = mealID
        }
        
        present(detailsVC, animated: true, completion: nil)
        //self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func didTapAddToFavs(mealID: String) {
        let alert = UIAlertController(title: "Success!", message: "Meal has been added to favorites", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
        let context = AppDelegate.coreDataContainer.viewContext
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "UserMeal", in: context)
        
        let mealObject = NSManagedObject(entity: entityDescription!, insertInto: context)
        
        let tabbar = self.tabBarController as? TabBarController
        self.mealDataArr.removeAll()
        apiservice.fetchSearchedID(completion: { (filteredIDs) in
            
            for ID in filteredIDs.meals {
                self.mealDataArr.append(ID)
            }
            
            DispatchQueue.main.async {
                
                mealObject.setValue(self.mealDataArr[0].strMeal, forKey: "mealTitle")
                mealObject.setValue(self.mealDataArr[0].idMeal, forKey: "mealID")
                mealObject.setValue(tabbar?.fireBaseUser, forKey: "userID")
                
                self.mealDataArr[0].strMealThumb!.downloadImage { (image) in
                    DispatchQueue.main.async {
                        //self.mealImageView.image = image
                        if let binaryImage = image?.pngData() {
                            mealObject.setValue(binaryImage, forKey: "mealImage")
                            do {
                                try context.save()
                                print("meal saved successfully")
                            }
                            catch {
                                print("failed")
                            }
                        }
                    }
                }
                
            }
            
        }, id: mealID)
        
    }
    
}
