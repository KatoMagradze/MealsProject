//
//  Regions.swift
//  MealsProject
//
//  Created by Kato on 7/11/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation

extension MapViewController {
    

    func getCoordinates(area: String) -> Array<Double> {
        let regionsDictionary = [
            "American" : "39.8283#-98.5795",
            "British" : "52.3555#-1.1743",
            "Canadian" : "56.1304#-106.3468",
            "Chinese" : "35.8617#104.1954",
            "Dutch" : "56.2639#9.5018",
            "Egyptian" : "26.8206#30.8025",
            "French" : "46.2276#2.2137",
            "Greek" : "39.0742#21.8243",
            "Indian" : "20.5937#78.9629",
            "Irish" : "53.1424#-7.6921",
            "Italian" : "41.8719#12.5674",
            "Jamaican" : "40.7027#-73.7890",
            "Japanese" : "36.2048#138.2529",
            "Kenyan" : "-0.0236#37.9062",  //???????????????
            "Malaysian" : "4.2105#101.9758",
            "Mexican" : "23.6345#-102.5528",
            "Moroccan" : "31.7917#-7.0926",
            "Polish" : "51.9194#19.1451",
            "Russian" : "61.5240#105.3188",
            "Spanish" : "40.4637#-3.7492",
            "Thai" : "15.8700#100.9925",
            "Tunisian" : "33.8869#9.5375",
            "Turkish" : "38.9637#35.2433",
            "Unknown" : "35.2433#35.2433",
            "Vietnamese" : "14.0583#108.2772"
        ]
        
        var returnArrStr = [String]()
        var returnArray = [Double]()
        let returnCoordinates = regionsDictionary[area]
        if (returnCoordinates != nil) {
            returnArrStr = (returnCoordinates?.components(separatedBy: "#"))!
            
            for i in 0..<returnArrStr.count {
                returnArray.append(Double(returnArrStr[i]) ?? 0.0)
            }
        }
        return returnArray
    }

}
