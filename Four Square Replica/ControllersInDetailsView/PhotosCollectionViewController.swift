//
//  PhotosCollectionViewController.swift
//  Four Square Replica
//
//  Created by Shahrukh on 05/12/2021.
//  Copyright © 2021 Programmers force. All rights reserved.
//

import UIKit

private let reuseIdentifier = "photoCell"

class PhotosCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Variables
    var place_fsqId: String!
    var objImages: [Image]!
    var apiManager = ApiManager()
    var selectedIndex: Int!
    
    //MARK: - IBOutlets
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var lblNoPhotos: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNoPhotos.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidAppear(_ animated: Bool) {
        let spinner = UIViewController.displaySpinner(onView: self.view)

        apiManager.getImages(fsq_id: place_fsqId!,limit: 50, completed: {
            (imagesReturned) in
            self.objImages = imagesReturned
            
                    
            if(self.objImages.count == 0){
                //show no images label
                self.lblNoPhotos.isHidden = false
            }else{
                self.photosCollectionView.reloadData()
            }
        UIViewController.removeSpinner(spinner: spinner)

        })
    }

    // MARK: - CollectionView Config
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return objImages == nil ? 0 : objImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
    
        // Configure the cell
        let prefix = self.objImages[indexPath.row].prefix
        
        //set image width half of the view
        let widthImg = Int((photosCollectionView.frame.size.width - 4)/3)
        let size = "\(widthImg)x\(widthImg)"
        
        let suffix = self.objImages[indexPath.row].suffix
        
        cell.imgDetails.downloaded(from: prefix+size+suffix)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //set width of the cell half of the view
        let width = (photosCollectionView.frame.size.width - 4)/3
        return CGSize(width: width, height: width)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(objImages[indexPath.row])
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "toSlider", sender: self)
    }
    //prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toSlider") {
            let sliderVC = segue.destination as! SliderViewController
            sliderVC.objImages = objImages
            sliderVC.selectedIndex = selectedIndex
        }

    }
    //MARK: - Helper Methods
    

}
