//
//  RelatedPlacesViewController.swift
//  Four Square Replica
//
//  Created by Shahrukh on 06/12/2021.
//  Copyright © 2021 Programmers force. All rights reserved.
//

import UIKit

class RelatedPlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables
    var place_lat: Double!
    var place_long: Double!
    var place: place!
    var apiManager = ApiManager()
    var relatedPlaces: places!
    var selectedPlace: place?

    // MARK: - IBOutlets
    @IBOutlet weak var rPlacesTableView: UITableView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rPlacesTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {

        let spinner = UIViewController.displaySpinner(onView: self.view)

        //get places from api
        apiManager.getNearByPlaces(latitute: place_lat!, longitute: place_long!,completed: {
            (placesNearBy) in
            
            if placesNearBy.results.count > 0 {

                self.relatedPlaces = placesNearBy
                
                UIViewController.removeSpinner(spinner: spinner)
                self.rPlacesTableView.reloadData()
                
            }else{
                //tell no places nearby
                UIViewController.removeSpinner(spinner: spinner)
//                self.dismissAlert(title: "No Places", message: "No places found nearby")
            }
        })
        
    }
    
    // MARK: - TableView Config
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return relatedPlaces == nil ? 0 : relatedPlaces.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        // Config cell
        cell.lblNameCC.text = relatedPlaces.results[indexPath.row].name
        let distance = Float(relatedPlaces.results[indexPath.row].distance)/1000
        cell.lblDistanceCC.text = "<\(String(format: "%.2f", distance))km"
        
        if let prefix = (relatedPlaces.results[indexPath.row].categories!.first?.icon?.prefix), let suffix = (relatedPlaces.results[indexPath.row].categories!.first?.icon?.suffix){
            let size = "bg_120"
            cell.imgCustomCell.downloaded(from: prefix+size+suffix)
        }
        
        
        cell.lblCityCC.text = relatedPlaces.results[indexPath.row].location.locality ?? ""
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlace = relatedPlaces.results[indexPath.row]
        performSegue(withIdentifier: "toDetailsViewForRP", sender: self)
    }
    //prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetailsViewForRP") {
            let detailsVC = segue.destination as! DetailsViewController
            
            //Pass object of seleted place to DetailsViewController
            detailsVC.place = selectedPlace
        }
    }
}
