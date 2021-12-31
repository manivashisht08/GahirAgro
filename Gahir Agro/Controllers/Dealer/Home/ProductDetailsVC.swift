//
//  ProductDetailsVC.swift
//  Gahir Agro
//
//  Created by Apple on 23/02/21.
//

import UIKit
import SDWebImage
import Alamofire

class ProductDetailsVC: UIViewController ,NetworkSpeedProviderDelegate{
    
    
    func callWhileSpeedChange(networkStatus: NetworkStatus) {
        switch networkStatus {
        case .poor:
            break
        case .good:
            break
        case .disConnected:
            break
        }
    }
    
    let test = NetworkSpeedTestVC()
    var buttonTitle = String()
    var pdfArray = [String]()
    var videoArray = [String]()
    var detailsDataArray = [DetailsData]()
    var mediaArray = [Media]()
    var messgae = String()
    var id = String()
    var img = String()
    
    @IBOutlet weak var enquiryButtonn: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var productDetailsTBView: UITableView!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productDetails()
        
//        test.delegate = self
        //        test.networkSpeedTestStop()
//        test.networkSpeedTestStart(UrlForTestSpeed: "https://www.dharmani.com/gahir/api/GetProductDetail.php")
        
        self.productDetailsTBView.separatorStyle = .none
        buttonTitle = UserDefaults.standard.value(forKey: "checkRole") as? String ?? ""
        if buttonTitle == "Customer"{
            enquiryButtonn.setTitle("All Video's & PDF", for: .normal)
        }else{
            enquiryButtonn.setTitle("Enquiry", for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    //    MARK:- Button Actions
    
    @IBAction func showImgBtn(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController!.view.layer.add(transition, forKey: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowImageVC") as! ShowImageVC
        vc.imgString = img
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func enquiryButtonVc(_ sender: Any) {
        
        
        let credentials = UserDefaults.standard.value(forKey: "tokenFString") as? Int ?? 0
        
        if credentials == 0{
            
            AppAlert.shared.simpleAlert(view: self, title: Constant.shared.appTitle, message: "You need to login to access this feature", buttonOneTitle: "Cancel", buttonTwoTitle: "OK")
            AppAlert.shared.onTapAction = { [weak self] tag in
                guard let self = self else {
                    return
                }
                if tag == 0 {
                    
                }else if tag == 1 {
                    UserDefaults.standard.set(true, forKey: "fromguestLogin")
                    let story = UIStoryboard(name: "Auth", bundle: nil)
                    let rootViewController:UIViewController = story.instantiateViewController(withIdentifier: "SignInWithVC")
                    self.navigationController?.pushViewController(rootViewController, animated: true)
                }
            }
            
        }else{
            
            buttonTitle = UserDefaults.standard.value(forKey: "checkRole") as? String ?? ""
            if buttonTitle == "Customer"{
                
                let vc = AllVideosAndPDFListingVC.instantiate(fromAppStoryboard: .Main)
                vc.allDataArray = mediaArray
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else{
                
                let vc = EnquiryVC.instantiate(fromAppStoryboard: .Main)
                vc.id = self.id
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }
    }
    
    //    MARK:- Service Call
    
    func productDetails() {
        PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        let url = Constant.shared.baseUrl + Constant.shared.ProductDetails
        var deviceID = UserDefaults.standard.value(forKey: "deviceToken") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken")
        print(deviceID ?? "")
        if deviceID == nil  {
            deviceID = "777"
        }
        let params = ["id": id,"access_token": accessToken]  as? [String : AnyObject] ?? [:]
        print(params)        
        PKWrapperClass.requestPOSTWithFormDataWithoutImages(url, params: params) { (response) in
            DispatchQueue.main.async {
                PKWrapperClass.svprogressHudDismiss(view: self)
            }
            let status = response.data["status"] as? String ?? ""
            self.messgae = response.data["message"] as? String ?? ""
            self.detailsDataArray.removeAll()
            if status == "1"{
                let allData = response.data["product_detail"] as? [String:Any] ?? [:]
                let pdfData = allData["prod_pdf"] as? [String] ?? [""]
                for i in pdfData {
                    self.mediaArray.append(Media(type: .pdf, url: i))
                }
                let videoData = allData["prod_video"] as? [String] ?? [""]
                for i in videoData {
                    self.mediaArray.append(Media(type: .video, url: i))
                }
                self.namelbl.text = allData["prod_name"] as? String ?? ""
                self.modelLbl.text = allData["prod_model"] as? String ?? ""
                self.img = allData["prod_image"] as? String ?? ""
                self.showImage.sd_setImage(with: URL(string: allData["prod_image"] as? String ?? ""), placeholderImage: UIImage(named: "placeholder-img-logo (1)"), options: SDWebImageOptions.continueInBackground, completed: nil)
                let productDetails = allData["prod_desc"] as? [String] ?? [""]
                for product in productDetails{
                    if product.contains(":") == true{
                        let splittedProducts = product.split(separator: ":")
                        //                        if splittedProducts.contains(":"){
                        if splittedProducts.indices.contains(0) && splittedProducts.indices.contains(1){
                            self.detailsDataArray.append(DetailsData( fieldName: String(splittedProducts[1]), fieldData: splittedProducts[0]))
                            //                            }
                        }
                    }else{
                        self.detailsDataArray.append(DetailsData(fieldName: "", fieldData: product))
                    }
                }
                self.productDetailsTBView.reloadData()
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

//MARK:- Tableview Cell Class

class ProductDetailsTBViewCell: UITableViewCell {
    
    @IBOutlet weak var dataLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

//MARK:- TableView Delegate Datasource

extension ProductDetailsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsTBViewCell", for: indexPath) as! ProductDetailsTBViewCell
        cell.nameLbl.text = "\(detailsDataArray[indexPath.row].fieldData):"
        cell.dataLbl.text = "\(detailsDataArray[indexPath.row].fieldName)"
        DispatchQueue.main.async {
            if self.detailsDataArray.count == 0{
                self.heightConstraint.constant = 50
            }else{
                self.heightConstraint.constant = self.productDetailsTBView.contentSize.height
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
    
}

//MARK:- Structure

struct DetailsData {
    init(fieldName: String, fieldData: Any) {
        self.fieldName = fieldName
        self.fieldData = fieldData
    }
    var fieldName : String
    var fieldData : Any
    
}

struct Media {
    var type:MediaType
    var url: String
    
    enum MediaType {
        
        case video
        case pdf
    }
}
