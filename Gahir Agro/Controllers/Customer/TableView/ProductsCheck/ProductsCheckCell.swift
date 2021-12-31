//
//  ProductsCheckCell.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 01/12/21.
//

import UIKit

class ProductsCheckCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProduct: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
       
              
//              if selected{
//                         imgProduct.image = UIImage(named: "ch")
//                     }else{
//                        imgProduct.image = UIImage(named: "btnblank")
//
//                     }
    }
    
}
