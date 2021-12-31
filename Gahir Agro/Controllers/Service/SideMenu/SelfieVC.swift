//
//  SelfieVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 23/11/21.
//

import UIKit

class SelfieVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func btnClick(_ sender: UIButton) {
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
