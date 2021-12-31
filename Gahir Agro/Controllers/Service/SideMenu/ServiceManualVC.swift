//
//  ServiceManualVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 23/11/21.
//

import UIKit

class ServiceManualVC: UIViewController {

    @IBOutlet weak var textService: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

   
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
