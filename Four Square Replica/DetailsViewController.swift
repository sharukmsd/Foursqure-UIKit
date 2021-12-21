//
//  DetailsViewController.swift
//  Four Square Replica
//
//  Created by Sharuk on 29/11/2021.
//  Copyright © 2021 Programmers force. All rights reserved.
//

import UIKit
import AVKit

class DetailsViewController: UIViewController {

    //MARK: - Variables
    var place: place?
    var objImages: [Image]!
    var apiManager = ApiManager()

    //MARK: - IBOutlets
    @IBOutlet weak var lblPlaceName: UILabel!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var photosContainer: UIView!
    @IBOutlet weak var relatedPlacesContainer: UIView!
    @IBOutlet weak var tipsContanier: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    //    @IBOutlet weak var detailsCollectionView: UICollectionView!
    
    // MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        lblPlaceName.text = place?.name
        lblCategoryName.text = place?.categories![0].name
        
        setContainerVisibility(photosAlpha: 1, relatedPlacesAlpha: 0, tipsAlpha: 0)

        
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {

        apiManager.getImages(fsq_id: (place?.fsq_id)!, limit: 1, completed: {
            (imagesReturned) in
            self.objImages = imagesReturned
            
            if(self.objImages.count > 0){
                let prefix = self.objImages[0].prefix
                let size = "800x400"
                let suffix = self.objImages[0].suffix
                self.imgMain.downloaded(from: prefix+size+suffix)

            }

        })
    }
    
    // MARK: - IBActions
    @IBAction func onBackTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onPlayTapped(_ sender: Any) {
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video", ofType: "mp4")!))
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true)
        
    }
    
    
    @IBAction func onSliding(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            setContainerVisibility(photosAlpha: 1, relatedPlacesAlpha: 0, tipsAlpha: 0)
//            performSegue(withIdentifier: "unwindDetails", sender: self)
        case 1:
            setContainerVisibility(photosAlpha: 0, relatedPlacesAlpha: 1, tipsAlpha: 0)
        case 2:
            setContainerVisibility(photosAlpha: 0, relatedPlacesAlpha: 0, tipsAlpha: 1)

        default: break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "embedPhotosCollectionView"){
            let photoCV = segue.destination as! PhotosCollectionViewController
            photoCV.place_fsqId = place?.fsq_id
        }
        if(segue.identifier == "embedTipsView"){
            let tipsVC = segue.destination as! TipsViewController
            tipsVC.place_fsqid = place?.fsq_id
        }
        if(segue.identifier == "embedRelatedPlaces"){
            let relatedVC = segue.destination as! RelatedPlacesViewController
            relatedVC.place_lat = place?.geocodes.main.latitude
            relatedVC.place_long = place?.geocodes.main.longitude
        }
    }
    //MARK: - Helper Methods
    fileprivate func setContainerVisibility(photosAlpha: CGFloat, relatedPlacesAlpha: CGFloat, tipsAlpha: CGFloat) {
        photosContainer.alpha = photosAlpha
        relatedPlacesContainer.alpha = relatedPlacesAlpha
        tipsContanier.alpha = tipsAlpha
    }

}
