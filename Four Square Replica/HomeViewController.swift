//
//  ViewController.swift
//  Four Square Replica
//
//  Created by Sharuk on 25/11/2021.
//  Copyright © 2021 Programmers force. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    //MARK: - Variables
    var currentTappedBtnText = ""
    
    //MARK: - IBOutlets
    @IBOutlet weak var btnBreakfast: UIButton!
    @IBOutlet weak var btnLunch: UIButton!
    @IBOutlet weak var btnDinner: UIButton!
    @IBOutlet weak var btnCoffee: UIButton!
    @IBOutlet weak var btnNightlife: UIButton!
    @IBOutlet weak var btnThingsToDo: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        //Centers the label and image vertically in the UIButton
        btnBreakfast.centerVertically()
        btnLunch.centerVertically()
        btnDinner.centerVertically()
        btnCoffee.centerVertically()
        btnNightlife.centerVertically()
        btnThingsToDo.centerVertically()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func breakfastBtnTapped(_ sender: Any) {

        performSegueWithLabel(label: "Breakfast")
    }
    @IBAction func lunchTapped(_ sender: Any) {
        performSegueWithLabel(label: "Lunch")

    }

    @IBAction func dinnerTapped(_ sender: Any) {
        performSegueWithLabel(label: "Dinner")

    }
    
    @IBAction func coffeeTapped(_ sender: Any) {
        performSegueWithLabel(label: "Coffee & tea")

    }
    @IBAction func nightLifeTapped(_ sender: Any) {
        performSegueWithLabel(label: "Nightlife")

    }
    
    @IBAction func thingsToDoTapped(_ sender: Any) {
        performSegueWithLabel(label: "Things to do")

    }
    // MARK: - SearchBar config
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let keywordEntered = searchBar.text else{ return }
        
        if !keywordEntered.isEmpty{
            performSegueWithLabel(label: keywordEntered)
        }
    }
    
    // MARK: - Helper Methods
    fileprivate func performSegueWithLabel(label: String) {
        currentTappedBtnText = label
        performSegue(withIdentifier: "toSearchResult", sender: self)
    }
    
    //Prepare for the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toSearchResult") {

            let srVC = segue.destination as! SearchResultViewController
            
            //Forwards category selected to SearchResultsViewController
            srVC.searhBarText = currentTappedBtnText
        }
    }
}

