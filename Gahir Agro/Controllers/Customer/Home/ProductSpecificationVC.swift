//
//  ProductSpecificationVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 01/12/21.
//

import UIKit
import SDWebImage

class ProductSpecificationVC: UIViewController {
    var productDetailArr = [AllProductsTableData<AnyHashable>]()
    
    var productID:String?
    var productImg:String?
    var productModel:String?
    var productSno:String?
    var productSystm:String?
    var productPdf = String()
    
    var productWDArr = WarrantyProductData<AnyHashable>(dataDict: [:])
    
    @IBOutlet weak var lblSystem: UILabel!
    @IBOutlet weak var lblSerail: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //        productDetailApi()
        updateData()
    }
    
    func updateData(){
        lblModel.text = productModel
        bgImg.sd_setImage(with: URL(string: productImg ?? String()), placeholderImage: UIImage(named: "placeholder-img-logo (1)"), options: SDWebImageOptions.continueInBackground, completed: nil)
        lblSerail.text = productSno
        lblSystem.text = productSystm
        bgView.backgroundColor = getRandomColor()
    }
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    func productDetailApi(){
        DispatchQueue.main.async {
            PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        }
        let url = Constant.shared.baseUrl + Constant.shared.CheckWarrantyProduct
        var deviceID = UserDefaults.standard.value(forKey: "device_token") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
        if deviceID == nil {
            deviceID = "777"
        }
        let param = ["access_token": accessToken,"product_id": productID] as? [String :AnyObject]
        print(param)
        PKWrapperClass.requestPOSTWithFormData(url, params: param, imageData: []) { [self] (response) in
            let productResponse = WarrantyProductModel(dict: response.data as? [String:AnyHashable] ?? [:])
            print(response)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = productResponse.status
            let msg = productResponse.message
            if status == "1"{
                self.productWDArr = productResponse.warrantyListingDict
                let vc = WarrantyVC.instantiate(fromAppStoryboard: .Customer)
                vc.productWDArr = productWDArr
                vc.warranty = productResponse.warranty
                (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
            }else {
                PKWrapperClass.svprogressHudDismiss(view: self)
                alert(Constant.shared.appTitle, message: msg, view: self)
            }
        } failure: {(error) in
            print(error)
            PKWrapperClass.svprogressHudDismiss(view: self)
            showAlertMessage(title: Constant.shared.appTitle, message: error as? String ?? "", okButton: "Ok", controller: self, okHandler: nil)
        }
    }
    @IBAction func btnComplaint(_ sender: UIButton) {
        let vc = ComplaintVC.instantiate(fromAppStoryboard: .Customer)
        vc.complaintSno = productSno
        vc.complaintName = productSystm
        vc.complaintId = productID
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnOperator(_ sender: UIButton) {
        let vc = OperatorManualVC.instantiate(fromAppStoryboard: .Customer)
        vc.operatorPdf = productPdf
        vc.productImage = productImg
        vc.operatorDetailArr = productDetailArr
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
    }
    @IBAction func btnParts(_ sender: UIButton) {
        let vc = PartsCatalogueVC.instantiate(fromAppStoryboard: .Customer)
        vc.partDetailArr = productDetailArr
        vc.productImage = productImg
        
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
    }
    @IBAction func btnCheck(_ sender: UIButton) {
        productDetailApi()
    }
    
}

