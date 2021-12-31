//
//  WarrantyDetailVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 04/12/21.
//

import UIKit
import SDWebImage

class WarrantyDetailVC: UIViewController {
    
    var productWDArr = WarrantyProductData<AnyHashable>(dataDict: [:])
    var warranty:String?

    @IBOutlet weak var txtWarranty: UITextField!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtWarranty.text = productWDArr?.prod_name
        timeLbl.text = warranty
        bgView.backgroundColor = getRandomColor()
        
        bgImg.sd_setImage(with: URL(string: productWDArr?.prod_image ?? String()), placeholderImage: UIImage(named: "placeholder-img-logo (1)"), options: SDWebImageOptions.continueInBackground, completed: nil)
    }
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    

    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
