//
//  ApiManager.swift
//  Four Square Replica
//
//  Created by Sharuk on 26/11/2021.
//  Copyright © 2021 Programmers force. All rights reserved.
//

import Foundation
import CoreLocation

class ApiManager{
    
    // MARK: - Variables
    let apiKey = "fsq3BK3kcYoJsiKq9DoHfw7dDUNEQmnxwMOZVNf2raFTHow="
    
    //MARK: - Get Places
    func getPlaces(CategorySelected: String, latitute: Double, longitute: Double, completed:@escaping (places)->()) -> Void {
        let headers = [
            "Accept": "application/json",
            "Authorization": apiKey
        ]
        
        //replace spaces with %20
        let res = CategorySelected.replacingOccurrences(of: " ", with: "%20")
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/search?query=\(res)&ll=\(latitute)%2C\(longitute)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 20.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {

                do{
                    
                    let placesReturned = try JSONDecoder().decode(places.self, from: data!)
                    DispatchQueue.main.async {
                        
                        completed(placesReturned)
                    
                    }
                }catch{
                    print("JSON ERROR: Unable to parse the data")
                }
            }
        })
        
        dataTask.resume()
        
        
    }
    
    //MARK: - Get images for given place with id
    func getImages(fsq_id: String,limit: Int, completed: @escaping ([Image])->()) -> Void {
        
        let headers = [
            "Accept": "application/json",
            "Authorization": apiKey
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/\(fsq_id)/photos?limit=\(limit)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                
                do{
                    
                    let imagesReturned = try JSONDecoder().decode([Image].self, from: data!)
                    DispatchQueue.main.async {
                        
                        completed(imagesReturned)
                        
                    }
                }catch{
                    print("JSON ERROR: Unable to parse the data of images")
                }
                
            }
        })
        
        dataTask.resume()
        
    }
    
    //MARK: - Get Near by places
    func getNearByPlaces(latitute: Double, longitute: Double,completed:@escaping (places)->()) -> Void {

        let headers = [
          "Accept": "application/json",
          "Authorization": apiKey
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/nearby?ll=\(latitute)%2C\(longitute)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 20.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error!)
          } else {

            do{
                
                let placesNearBy = try JSONDecoder().decode(places.self, from: data!)
                DispatchQueue.main.async {
                    
                    completed(placesNearBy)
                
                }
            }catch{
                print("JSON ERROR: Unable to parse the data")
            }
            
          }
        })

        dataTask.resume()
    }
    
    // MARK: - Get Tips
    func getTips(place_fsqid: String, completed:@escaping ([tip])->()) -> Void {
        
        let headers = [
          "Accept": "application/json",
          "Authorization": apiKey
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/\(place_fsqid)/tips")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error!)
          } else {
              do{
                
                let TipsReturned = try JSONDecoder().decode([tip].self, from: data!)
                DispatchQueue.main.async {
                    
                    completed(TipsReturned)
                
                }
            }catch{
                print("JSON ERROR: Unable to parse the data\(error)")
            }

          }
        })

        dataTask.resume()
    }
}

