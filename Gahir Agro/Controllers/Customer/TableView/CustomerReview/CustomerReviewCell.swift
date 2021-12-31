//
//  CustomerReviewCell.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 01/12/21.
//

import UIKit

class CustomerReviewCell: UITableViewCell {

    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgProfile.layer.cornerRadius = imgProfile.bounds.height / 2
        imgProfile.clipsToBounds = true
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
