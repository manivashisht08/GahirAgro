//
//  RewardsVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 22/11/21.
//

import UIKit

class RewardsVC: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        sideMenuController?.showLeftViewAnimated()
    }
    
    @IBAction func btnCheckRewards(_ sender: UIButton) {
        let story = UIStoryboard(name: "Service", bundle: nil)
        let rootViewController:UIViewController = story.instantiateViewController(withIdentifier: "RewardsDetailVC")
        self.navigationController?.pushViewController(rootViewController, animated: true)
    }
}


