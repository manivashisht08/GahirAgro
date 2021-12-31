//
//  AttendComplaintCell.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 23/11/21.
//

import UIKit

class AttendComplaintCell: UITableViewCell {

    @IBOutlet weak var attendBtn: UIButton!
    @IBOutlet weak var faultLbl: UILabel!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func openBtn(_ sender: UIButton) {
    }
    
  
    
    
}
