//
//  SearchResultCell.swift
//  Kokoike
//
//  Created by mosin on 2019/03/06.
//  Copyright © 2019 mosin. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchResultCell: UITableViewCell {
    
    
    @IBOutlet weak var sumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func displayShop(_ shopJSON: JSON) {
        nameLabel.text = shopJSON[Constants.GNAVI_RESPONSE.NAME].stringValue
        nameLabel.fitAndLineBreak()
        addressLabel.text = shopJSON[Constants.GNAVI_RESPONSE.ADDRESS].stringValue
        addressLabel.fitAndLineBreak()
        sumbnailImage.displayFromURL(shopJSON[Constants.GNAVI_RESPONSE.IMAGE_URLS][Constants.GNAVI_RESPONSE.IMAGE_URL1].stringValue)
    }
}
