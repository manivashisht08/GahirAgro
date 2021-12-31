//
//  OperatorManualVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 03/12/21.
//

import UIKit
import SDWebImage
import WebKit

class OperatorManualVC: UIViewController, WKNavigationDelegate {
    
    var operatorPdf = String()
    var productImage:String?
    var operatorDetailArr = [AllProductsTableData<AnyHashable>]()

    @IBOutlet weak var pdfWeb: WKWebView!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgImg.sd_setImage(with: URL(string: productImage ?? String()),
                               placeholderImage: UIImage(named: "placeholder-img-logo (1)"), options: SDWebImageOptions.continueInBackground, completed: nil)
        print(operatorPdf)
        let fPdf = operatorPdf.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
       
        let url = NSURL(string: fPdf)
                let request = NSURLRequest(url: url! as URL)
                pdfWeb.navigationDelegate = self
                pdfWeb.load(request as URLRequest)
    }

    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
