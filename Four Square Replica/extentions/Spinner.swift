//
//  Spinner.swift
//  Four Square Replica
//
//  Created by Sharuk on 01/12/2021.
//  Copyright © 2021 Programmers force. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    
    class func displaySpinner(onView : UIView) -> UIView {
        
        let spinnerView = UIView.init(frame: onView.bounds)
        
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .white)
        
        ai.startAnimating()
        
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            
            spinnerView.addSubview(ai)
            
            onView.addSubview(spinnerView)
            
        }
        
        return spinnerView
        
    }
    
    class func removeSpinner(spinner :UIView) {
        
        DispatchQueue.main.async {
            
            spinner.removeFromSuperview()
            
        }
        
    }
    
}
