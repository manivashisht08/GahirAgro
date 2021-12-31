//
//  ReviewPostVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 06/12/21.
//

import UIKit

class ReviewPostVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var imgDetails: UIImageView!
    @IBOutlet weak var textReview: UITextView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    var postImage: AnyObject?
    var postLabel:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        textReview.delegate = self
        self.imgDetails = postImage as? UIImageView
//        self.textReview = postLabel
        
    }
   
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnPost(_ sender: UIButton) {
        let vc = ComplaintVC.instantiate(fromAppStoryboard: .Customer)
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
    }
    
}
