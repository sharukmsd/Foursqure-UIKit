//
//  CustomTableViewCell.swift
//  Four Square Replica
//
//  Created by Sharuk on 29/11/2021.
//  Copyright © 2021 Programmers force. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCustomCell: UIImageView!
    @IBOutlet weak var lblNameCC: UILabel!
    @IBOutlet weak var lblDistanceCC: UILabel!
    @IBOutlet weak var lblCityCC: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
