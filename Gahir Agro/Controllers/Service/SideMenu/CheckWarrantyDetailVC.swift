//
//  CheckWarrantyDetailVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 22/11/21.
//

import UIKit

class CheckWarrantyDetailVC: UIViewController {

    @IBOutlet weak var validLbl: UILabel!
    @IBOutlet weak var imgWarranty: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textWarranty: UITextField!
    var serial = String()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
