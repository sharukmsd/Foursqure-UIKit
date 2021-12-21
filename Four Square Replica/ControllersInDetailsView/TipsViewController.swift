//
//  TipsViewController.swift
//  Four Square Replica
//
//  Created by Shahrukh on 07/12/2021.
//  Copyright © 2021 Programmers force. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables
    var apiManager = ApiManager()
    var place_fsqid: String!
    var tips: [tip]!
    
    //MARK: - IBOutlets
    @IBOutlet weak var tipsTableView: UITableView!
    @IBOutlet weak var lblNoTips: UILabel!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        lblNoTips.isHidden = true
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        apiManager.getTips(place_fsqid: self.place_fsqid, completed: {
            (TipsReturned) in
            self.tips = TipsReturned
            if self.tips.count == 0{
                self.lblNoTips.isHidden = false
                self.tipsTableView.isHidden = true
            }else{
                self.tipsTableView.reloadData()
            }
        })
    }
    
    // MARK: - TableView Config
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tips == nil ? 0 : tips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tipsTVCell", for: indexPath) as! TipsTableViewCell
        
        cell.textLabel?.text = tips[indexPath.row].text
        
        
        cell.detailTextLabel?.text = tips[indexPath.row].created_at
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //show full tip
        let showFullTip = UIAlertController(title: "Tip", message: tips[indexPath.row].text, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        showFullTip.addAction(dismiss)
        present(showFullTip, animated: true)
    }
}
