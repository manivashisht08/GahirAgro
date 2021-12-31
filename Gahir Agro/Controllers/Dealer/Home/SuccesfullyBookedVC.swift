//
//  SuccesfullyBookedVC.swift
//  Gahir Agro
//
//  Created by Apple on 25/02/21.
//

import UIKit
import SDWebImage

class SuccesfullyBookedVC: UIViewController {
    
    @IBOutlet weak var dispatchDateLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var bookingIDLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var nameLBlb: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    
    var productImage = String()
    var bookingId = String()
    var details = String()
    var messgae = String()
    var orderID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderDetail()
    }
    
//    MARK:- Button Action
    
    @IBAction func backButton(_ sender: Any) {
        
        let comesFrom = UserDefaults.standard.value(forKey: "comesFromPushOrder") as? Bool ?? false
        if comesFrom == true{
            UserDefaults.standard.set(false, forKey: "comesFromPushOrder")
            AppDelegate().redirectToHomeVC()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
//    MARK:- Service Call
    
    func orderDetail() {
        PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        let orderDetails = Constant.shared.baseUrl + Constant.shared.OrderDetails
        var deviceID = UserDefaults.standard.value(forKey: "deviceToken") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken")
        print(deviceID ?? "")
        if deviceID == nil  {
            deviceID = "777"
        }
        let params = ["access_token": accessToken,"id" : orderID]  as? [String : AnyObject] ?? [:]
        print(params)
        PKWrapperClass.requestPOSTWithFormData(orderDetails, params: params, imageData: []) { (response) in
            print(response.data)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = response.data["status"] as? String ?? ""
            self.messgae = response.data["message"] as? String ?? ""
            if status == "1"{
                let enquiryData = response.data["order_detail"] as? [String:Any] ?? [:]
                self.statusLbl.text = enquiryData["order_status"] as? String ?? ""
                let productDetails = enquiryData["enquiry_detail"] as? [String:Any] ?? [:]
                self.dispatchDateLbl.text = productDetails["dispatch_day"] as? String ?? ""
                self.bookingIDLbl.text = enquiryData["booking_id"] as? String ?? ""
                let orderData = productDetails["product_detail"] as? [String:Any] ?? [:]
                self.showImage.sd_setImage(with: URL(string:orderData["prod_image"] as? String ?? ""), placeholderImage: UIImage(named: "placeholder-img-logo (1)"), options: SDWebImageOptions.continueInBackground, completed: nil)
                self.detailsLbl.text = orderData["prod_model"] as? String ?? ""
                self.nameLBlb.text = orderData["prod_name"] as? String ?? ""
            }else if status == "0"{
                PKWrapperClass.svprogressHudDismiss(view: self)
                alert(Constant.shared.appTitle, message: self.messgae, view: self)
            } else if status == "100"{
                showAlertMessage(title: Constant.shared.appTitle, message: self.messgae, okButton: "Ok", controller: self) {
                    UserDefaults.standard.removeObject(forKey: "tokenFString")
                    let appDel = UIApplication.shared.delegate as! AppDelegate
                    appDel.Logout1()
                }
            }
        } failure: { (error) in
            print(error)
            PKWrapperClass.svprogressHudDismiss(view: self)
            showAlertMessage(title: Constant.shared.appTitle, message: error as? String ?? "", okButton: "Ok", controller: self, okHandler: nil)
        }
    }    
}
