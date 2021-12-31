//
//  StatesListCell.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 03/12/21.
//

import UIKit

class StatesListCell: UITableViewCell {

    @IBOutlet weak var imgState: UIImageView!
    @IBOutlet weak var lblState: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected{
            imgState.image = UIImage(named: "ch")
               }else{
                imgState.image = UIImage(named: "btnblank")

               }
    }
    
}
