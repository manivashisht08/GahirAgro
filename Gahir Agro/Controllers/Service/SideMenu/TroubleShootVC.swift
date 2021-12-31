//
//  TroubleShootVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 23/11/21.
//

import UIKit

class TroubleShootVC: UIViewController {

    @IBOutlet weak var textTrouble: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
