//
//  PartsCatalogueVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 04/12/21.
//

import UIKit
import SDWebImage

class PartsCatalogueVC: UIViewController {
    
    var productImage:String?
    var partDetailArr = [AllProductsTableData<AnyHashable>]()
    var partsArr = WarrantyProductData<AnyHashable>(dataDict: [:])
    
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.bgImg = partsArr?.prod_image
        self.bgImg.sd_setImage(with: URL(string: productImage ?? String()), placeholderImage: UIImage(named: "placeholder-img-logo (1)"), options: SDWebImageOptions.continueInBackground, completed: nil)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    @IBAction func btnParts(_ sender: UIButton) {
                let vc = ThrasherVC.instantiate(fromAppStoryboard: .Customer)
        
                (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        
    }
    
}
