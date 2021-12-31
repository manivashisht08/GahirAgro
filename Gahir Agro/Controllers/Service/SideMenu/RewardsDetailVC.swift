//
//  RewardsDetailVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 23/11/21.
//

import UIKit

class RewardsDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var moneyLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
