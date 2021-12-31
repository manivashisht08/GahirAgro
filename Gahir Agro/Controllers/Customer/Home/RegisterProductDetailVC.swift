//
//  RegisterProductDetailVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 29/11/21.
//

import UIKit

class RegisterProductDetailVC: UIViewController {

  
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    @IBAction func btnImg(_ sender: UIButton) {
        
        let vc = MyProductsListVC.instantiate(fromAppStoryboard: .Customer)
        
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
    }
    
}
