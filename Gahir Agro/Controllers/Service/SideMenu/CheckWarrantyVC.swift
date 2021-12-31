//
//  CheckWarrantyVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 22/11/21.
//

import UIKit

class CheckWarrantyVC: UIViewController {

    @IBOutlet weak var txtSerialNumber: UITextField!
    var code = String()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func btnMenu(_ sender: Any) {
        sideMenuController?.showLeftViewAnimated()

    }
    
    @IBAction func btnCheck(_ sender: Any) {
        let story = UIStoryboard(name: "Service", bundle: nil)
        let vc:UIViewController = story.instantiateViewController(withIdentifier: "CheckWarrantyDetailVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
