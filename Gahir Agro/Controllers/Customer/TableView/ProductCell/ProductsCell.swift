//
//  ProductsCell.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 30/11/21.
//

import UIKit

class ProductsCell: UITableViewCell {

    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var bgLbl: UILabel!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
