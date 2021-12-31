//
//  RegisterProductVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 29/11/21.
//

import UIKit

class RegisterProductVC: UIViewController {
    var serialNumber = "KHUS002"

    @IBOutlet weak var txtSerialNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSerialNumber.text = serialNumber
    }
    
    @IBAction func menuBtn(_ sender: UIButton) {
        sideMenuController?.showLeftViewAnimated()

    }
    
    @IBAction func registerBtn(_ sender: UIButton) {
        txtSerialNumber.text == "" ? showAlertMessage(title: Constant.shared.appTitle, message: "Please enter serial number", okButton: "Ok", controller: self, okHandler: nil)  : registerProductApi()

       
    }
    func navigateToRegisterPage(){
    let vc = RegisterProductDetailVC.instantiate(fromAppStoryboard: .Customer)
    (self.sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
    }
    
    func registerProductApi(){
        PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        let url = Constant.shared.baseUrl + Constant.shared.RegisterProduct
        var deviceID = UserDefaults.standard.value(forKey: "device_token") as? String

        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String
        print(deviceID ?? "")
        if deviceID == nil {
            deviceID = "777"
        }
        let param = ["access_token" : accessToken, "sr_no" : txtSerialNumber.text ?? ""] as? [String:AnyObject] ?? [:]
        PKWrapperClass.requestPOSTWithFormData(url, params: param, imageData: [])
            {(response) in
            print(response)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status =  response.data["status"] as? String ?? ""
            let msg = response.data["message"] as? String ?? ""
            if status == "1"{
//                var newArr = [RegData]()
//                newArr.append(RegData(name: response.data["sr_no"] as? String ?? ""))
                self.txtSerialNumber.text = response.data["sr_no"] as? String ?? ""
                
                let vc = RegisterProductDetailVC.instantiate(fromAppStoryboard: .Customer)
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                if msg == "Already registered."{
                    showAlertMessage(title: Constant.shared.appTitle, message: msg, okButton: "Ok", controller: self) {
                        self.navigateToRegisterPage()
                    }
                }else{
                    showAlertMessage(title: Constant.shared.appTitle, message: msg, okButton: "Ok", controller: self, okHandler: nil)
                }
                
            }
            
        } failure: {(error) in
            PKWrapperClass.svprogressHudDismiss(view: self)
            showAlertMessage(title: Constant.shared.appTitle, message: error.localizedDescription, okButton: "Ok", controller: self, okHandler: nil)

        }
    }
    

}

struct RegData {
    var name : String

    init(name: String) {
        self.name = name
      
    }
}
