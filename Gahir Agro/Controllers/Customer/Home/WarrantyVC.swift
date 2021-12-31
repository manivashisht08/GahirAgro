//
//  WarrantyVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 04/12/21.
//

import UIKit

class WarrantyVC: UIViewController {

    var productWDArr = WarrantyProductData<AnyHashable>(dataDict: [:])
    var warranty:String?
    
    @IBOutlet weak var productText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        productText.text = productWDArr?.prod_name
    }

    
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnCheck(_ sender: UIButton) {
        let vc = WarrantyDetailVC.instantiate(fromAppStoryboard: .Customer)
        vc.productWDArr = productWDArr
        vc.warranty = warranty
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
    }
    

}
