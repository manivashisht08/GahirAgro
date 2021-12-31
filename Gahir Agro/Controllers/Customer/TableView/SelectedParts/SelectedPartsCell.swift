//
//  SelectedPartsCell.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 29/11/21.
//

import UIKit

class SelectedPartsCell: UITableViewCell {

    @IBOutlet weak var countViewLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var serialLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
