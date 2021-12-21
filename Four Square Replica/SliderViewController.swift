//
//  SliderViewController.swift
//  Four Square Replica
//
//  Created by Sharuk on 02/12/2021.
//  Copyright © 2021 Programmers force. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    // MARK: - Variables
    var objImages: [Image]?
    var selectedIndex: Int?
    
    // MARK: - IBOutlets
    @IBOutlet weak var sliderCV: UICollectionView!
    

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        
        //Set focus on selected image
        sliderCV.scrollToItem(at: IndexPath(item: selectedIndex!, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func onBackTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - CollectionView Config
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objImages == nil ? 0 : objImages!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! SliderCollectionViewCell
        let prefix = self.objImages![indexPath.row].prefix
        let size = "original"
        let suffix = self.objImages![indexPath.row].suffix
        cell.sliderImage.downloaded(from: prefix+size+suffix)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = view.frame.size.height
        let width = view.frame.size.width
        // in case you you want the cell to be 40% of your controllers view
        return CGSize(width: width, height: height)
    }
    
    //MARK: - Helper Methods
}
