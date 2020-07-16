//
//  ProfileViewController.swift
//  MealsProject
//
//  Created by Kato on 7/12/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import CoreData
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    let apiservice = APIService()
    var userMealsArr = [UserMeal]()
    
    var selectedIndex = 0

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        profilePicture.layer.cornerRadius = 10
        
        let tabbar = self.tabBarController as? TabBarController
        self.emailLabel.text = tabbar?.userEmail
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.fetch()
    }
    
    @IBAction func logOutTapped(_ sender: UIButton) {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil) 
        }
        catch {
            print("failed")
        }
    }
    
    func deleteMeal(meal: UserMeal) {
        let context = AppDelegate.coreDataContainer.viewContext
        
        context.delete(meal)
        
        do {
            try context.save()
        } catch {}
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userMealsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.identifier, for: indexPath) as! FavoritesCell
        
        cell.favoritesLabel.text = userMealsArr[indexPath.row].mealTitle
        cell.favoriteImageView.image = UIImage(data: userMealsArr[indexPath.row].mealImage!)
        cell.id = userMealsArr[indexPath.row].mealID!
        cell.favoriteImageView.layer.cornerRadius = 80/2
        
//        if userMealsArr[indexPath.row].fileName!.isEmpty {
//            cell.downloadButton.isUserInteractionEnabled = true
//        }
//        else {
//            cell.downloadButton.isUserInteractionEnabled = false
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "profile_details_segue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MealDetailsViewController
        vc.id = userMealsArr[selectedIndex].mealID!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            
            self.deleteMeal(meal: self.userMealsArr[indexPath.row])
            
            self.userMealsArr.remove(at: indexPath.row)
            //tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        
        let config = UISwipeActionsConfiguration(actions: [delete])
        
        return config
    }
    
    func fetch() {
        let container = AppDelegate.coreDataContainer
        
        //context
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserMeal")
        
        self.userMealsArr.removeAll()
        
        do {
            let result = try context.fetch(fetchRequest)
            
            
            guard let data = result as? [NSManagedObject] else {return}
            
            let tabbar = self.tabBarController as? TabBarController
            
            for item in data {
                if let p = item as? UserMeal {
                    if tabbar?.fireBaseUser == p.userID {
                        self.userMealsArr.append(p)
                    }
                }
            }
        }
        catch {}
        self.tableView.reloadData()
    }
}

extension ProfileViewController: DownloadProtocol {
    func didTapDownload(mealID: String) {
//        let fm = FileManager.default
//        let docsUrl = try! fm.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
//
//        let folderName = "Savedmeals"
//        let imageFolderName = "Savedmeals/Image"
//
//        let fileName = ""
//        let imageFileName = ""
//
//        var mealFileUrl = docsUrl.appendingPathComponent(folderName)
//        mealFileUrl = mealFileUrl.appendingPathComponent(fileName)
//        var mealImageUrl = docsUrl.appendingPathComponent(imageFolderName)
//        mealImageUrl = mealImageUrl.appendingPathComponent(imageFileName)
//
//        var localM = idFilter(idMeal: mealID)
//        localM.mealArray[0].strMealThumb = mealImageUrl.absoluteString
//
//        fm.createFile(atPath: mealImageUrl.absoluteString, contents: localM.mealLocalImage?.pngData(), attributes: nil)
//
//        fm.createFile(atPath: mealFileUrl.absoluteString, contents: localM.mealArray.encode(to: Data.Base64EncodingOptions as! Encoder), attributes: nil)


    }
    
//    func idFilter(idMeal: String) -> localMealStruct {
//        var mealArr = [Meal]()
//        var mealLocalImage : UIImage?
//        var localM : localMealStruct?
//
//        apiservice.fetchSearchedID(completion: { (filteredIDs) in
//
//            for ID in filteredIDs.meals {
//                mealArr.append(ID)
//            }
//
//            DispatchQueue.main.async {
//                mealArr[0].strMealThumb!.downloadImage { (image) in
//                    DispatchQueue.main.async {
//                        mealLocalImage = image
//                        localM?.mealLocalImage = mealLocalImage
//                        localM?.mealArray = mealArr
//                    }
//                }
//            }
//
//        }, id: idMeal)
//        return localM!
//    }
//
//    struct localMealStruct {
//        var mealArray : [Meal]
//        var mealLocalImage : UIImage?
//    }
}
