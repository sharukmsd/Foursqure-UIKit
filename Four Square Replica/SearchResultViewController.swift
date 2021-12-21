//
//  SearchResultViewController.swift
//  Four Square Replica
//
//  Created by Sharuk on 26/11/2021.
//  Copyright © 2021 Programmers force. All rights reserved.
//

import UIKit
import CoreLocation

class SearchResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CLLocationManagerDelegate{
    
    //MARK: - Variables
    var searhBarText: String?
    let apiManager = ApiManager()
    var myPlaces: places?
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?

    var selectedPlace: place?
    var searchPlaces = [place]()
    var searching = false
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    
    // MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        lblNoData.isHidden = true
        
        //register for cell
        resultsTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        locationManager.delegate = self
        
        //gets current location with location manager
        DispatchQueue.main.async {
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.requestAlwaysAuthorization()
            
        }
        if(CLLocationManager.authorizationStatus() == .denied){
            print("Location Access Denined")
        }
        //Check if location permission is given
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){

            locationManager.startUpdatingLocation()
            currentLocation = locationManager.location
        }else{
//            dismissAlert(title: "Location disabled!", message: "App needs permission to use your location")
//            self.dismiss(animated: true, completion: nil)
        }
        
        let lat = currentLocation?.coordinate.latitude
        let long = currentLocation?.coordinate.longitude
        
        //Start the spinner
        let spinner = UIViewController.displaySpinner(onView: self.view)

        //if current location is accessable
        //get Data from api
        apiManager.getPlaces(CategorySelected: searhBarText!, latitute: lat ?? 31.463299, longitute: long ?? 74.28895, completed: {
            (placesReturned) in
            
            if placesReturned.results.count > 0 {

                self.myPlaces = placesReturned
                
                UIViewController.removeSpinner(spinner: spinner)
                self.resultsTableView.reloadData()
                
            }else{
                //tell no places nearby
                UIViewController.removeSpinner(spinner: spinner)
//                self.dismissAlert(title: "No Places", message: "No places found nearby")
                self.lblNoData.isHidden = false
                self.resultsTableView.isHidden = true
            }
        })

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func btnBackTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK! : TableView Config
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchPlaces.count < 0 ? 0 : searchPlaces.count
        }else{
            return myPlaces == nil ? 0: (myPlaces?.results.count)!
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Cell Config
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        if searching{
            cell.lblNameCC.text = searchPlaces[indexPath.row].name
            let distance = Float(searchPlaces[indexPath.row].distance)/1000
            cell.lblDistanceCC.text = "<\(String(format: "%.2f", distance))km"
            
            let prefix = (searchPlaces[indexPath.row].categories![0].icon?.prefix)!
            let suffix = (searchPlaces[indexPath.row].categories![0].icon?.suffix)!
            let size = "bg_120"
            cell.imgCustomCell.downloaded(from: prefix+size+suffix)
            cell.lblCityCC.text = searchPlaces[indexPath.row].location.locality ?? ""
        }else{
            cell.lblNameCC.text = myPlaces?.results[indexPath.row].name
            let distance = Float((myPlaces?.results[indexPath.row].distance)!)/1000
            cell.lblDistanceCC.text = "<\(String(format: "%.2f", distance))km"
            
            let prefix = (myPlaces?.results[indexPath.row].categories![0].icon?.prefix)!
            let suffix = (myPlaces?.results[indexPath.row].categories![0].icon?.suffix)!
            let size = "bg_120"
            cell.imgCustomCell.downloaded(from: prefix+size+suffix)
            cell.lblCityCC.text = myPlaces?.results[indexPath.row].location.locality ?? ""
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching{
            selectedPlace = searchPlaces[indexPath.row]
        }else{
            selectedPlace = myPlaces?.results[indexPath.row]
        }
        
        //Perform segue on selection of cell
        performSegue(withIdentifier: "toDetailsView", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetailsView") {
            let detailsVC = segue.destination as! DetailsViewController
            
            //Pass object of seleted place to DetailsViewController
            detailsVC.place = selectedPlace
        }
    }
    
    // MARK! : SearchBar config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchPlaces = (myPlaces?.results.filter({$0.name.lowercased().contains(searchText.lowercased())}))!
        
        searching = true
        
        lblNoData.isHidden = searchPlaces.count != 0
        
        if searchText == ""{
            searching = false
            lblNoData.isHidden = true
        }
        
        resultsTableView.reloadData()
    }
    
    // MARK: - Helper Methods
    func dismissAlert(title: String, message: String) -> Void {
        let showErr = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        showErr.addAction(dismiss)
        present(showErr, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //set current location
        currentLocation = manager.location
        //print(currentLocation?.coordinate.latitude)
    }
}
