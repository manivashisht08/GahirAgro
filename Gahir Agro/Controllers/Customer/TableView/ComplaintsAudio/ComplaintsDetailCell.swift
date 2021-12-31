//
//  ComplaintsDetailCell.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 06/12/21.
//

import UIKit

class ComplaintsDetailCell: UITableViewCell {

    @IBOutlet weak var lblAudio: UILabel!
    @IBOutlet weak var audioSlider: UISlider!
    @IBOutlet weak var btnAudio: UIButton!
    @IBOutlet weak var viewAudio: UIView!
    @IBOutlet weak var lblAnyIssue: UILabel!
    @IBOutlet weak var lblProblem: UILabel!
    @IBOutlet weak var lblSerialNumber: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var btnClosed: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
