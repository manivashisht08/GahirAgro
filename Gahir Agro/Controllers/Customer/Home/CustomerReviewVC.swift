//
//  CustomerReviewVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 03/12/21.
//

import UIKit
import SDWebImage

class CustomerReviewVC: UIViewController {
    
    var page = 1
    var lastPage = String()
    var pageCount = Int()
    var listDataArr:[AllFilterTableData<AnyHashable>]?
    var typeId:String?
    var filter:Bool?
    
    @IBOutlet weak var tableCustomer: UITableView!
    var ReviewArr = [ReviewTableData<AnyHashable>]()
    
    var CustomerArray =  [CustomerModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        CustomerReviewApi()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print(listDataArr)
        if filter == true{
//            FilterReviewApi()
        }else{
            CustomerReviewApi()
        }
    }
    func configureUI(){
        pageCount = 1
        tableCustomer.delegate = self
        tableCustomer.dataSource = self
        tableCustomer.separatorStyle = .none
        tableCustomer.register(UINib(nibName: "CustomerReviewCell", bundle: nil), forCellReuseIdentifier: "CustomerReviewCell")
    
    }
    
    func CustomerReviewApi(){
        DispatchQueue.main.async {
            PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        }
        let url = Constant.shared.baseUrl + Constant.shared.CustomerReview
        var deviceID = UserDefaults.standard.value(forKey: "device_token") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
        if deviceID == nil {
            deviceID = "777"
        }
        let param = ["access_token" : accessToken , "page_no" : page] as [String:AnyObject]
        print(param)
        PKWrapperClass.requestPOSTWithFormData(url, params: param, imageData: []) { [self] (response) in
            let reviewResp = ReviewModel(dict: response.data as? [String:AnyHashable] ?? [:])
            print(response)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = reviewResp.status
            let msg = reviewResp.message
            if status == "1"{
                self.ReviewArr = reviewResp.reviewListingArr
                self.tableCustomer.reloadData()
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
    
    func FilterReviewApi(){
        DispatchQueue.main.async {
            PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        }
        let url = Constant.shared.baseUrl + Constant.shared.FilterReview
        var deviceID = UserDefaults.standard.value(forKey: "device_token") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
        if deviceID == nil {
            deviceID = "777"
        }
        let typeID = listDataArr?[0].id ?? ""
        print(typeID)
        let prodType = listDataArr?[0].prod_type ?? ""
        print(prodType)
        let param = ["access_token":accessToken,"page_no":page,"type_id":typeID,"type":prodType] as [String : AnyObject]
        print(param)
        PKWrapperClass.requestPOSTWithFormData(url, params: param, imageData: []) {[self] (response) in
            let filterResp = ReviewModel(dict: response.data as? [String:AnyHashable] ?? [:])
            print(response)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = filterResp.status
            let msg = filterResp.message
            if status == "1" {
                self.ReviewArr = filterResp.reviewListingArr
                self.tableCustomer.reloadData()
            }else {
                PKWrapperClass.svprogressHudDismiss(view: self)
                alert(Constant.shared.appTitle, message: msg, view: self)
            }
        } failure: {(error) in
            
        }
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        let vc = ProductVC.instantiate(fromAppStoryboard: .Customer)
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
    }
    
    @IBAction func btnFilter(_ sender: UIButton) {
        let vc = FilterVC.instantiate(fromAppStoryboard: .Customer)
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        sideMenuController?.showLeftViewAnimated()
        
    }
    
}
extension CustomerReviewVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filter == true{
            return listDataArr?.count ?? 0
        }else{
            return ReviewArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if filter == true{
            let cell = tableCustomer.dequeueReusableCell(withIdentifier: "CustomerReviewCell", for: indexPath) as! CustomerReviewCell
            cell.imgProfile.sd_setImage(with: URL(string: (listDataArr?[indexPath.row].prod_image)!), placeholderImage: UIImage(named: "placeImg"), options: SDWebImageOptions.continueInBackground, completed: nil)

            cell.imgProfile.setRounded()
            cell.imgDetail.sd_setImage(with: URL(string: (listDataArr?[indexPath.row].prod_image)!), placeholderImage: UIImage(named: "placeholder-img-logo (1)"), options: SDWebImageOptions.continueInBackground, completed: nil)
            cell.lblTitle.text = listDataArr?[indexPath.row].prod_name
            cell.lbltime.text = listDataArr?[indexPath.row].creation_date

            return cell
        }else{
            let cell = tableCustomer.dequeueReusableCell(withIdentifier: "CustomerReviewCell", for: indexPath) as! CustomerReviewCell
            //        cell.imgProfile.image = UIImage(named: CustomerArray[indexPath.row].proImage)
            cell.imgProfile.sd_setImage(with: URL(string: ReviewArr[indexPath.row].user_detail.image), placeholderImage: UIImage(named: "placeImg"), options: SDWebImageOptions.continueInBackground, completed: nil)
            cell.imgDetail.sd_setImage(with: URL(string: ReviewArr[indexPath.row].product_detail.prod_image), placeholderImage: UIImage(named: "placeholder-img-logo (1)"), options: SDWebImageOptions.continueInBackground, completed: nil)
            cell.imgProfile.setRounded()
            
            cell.lblName.text = ReviewArr[indexPath.row].user_detail.first_name
            cell.lbltime.text = ReviewArr[indexPath.row].user_detail.created_on
            //        cell.imgDetail.image = UIImage(named: CustomerArray[indexPath.row].detailImg)
            cell.lblTitle.text = ReviewArr[indexPath.row].product_detail.prod_name
            cell.lblDetail.text  = ReviewArr[indexPath.row].review_text
            return cell
        }
      return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

struct CustomerModel {
    var proImage : String
    var name : String
    var time : String
    var detailImg : String
    var title :String
    var detail : String
    init(proImage : String,name : String,time : String,detailImg : String,title :String,detail : String) {
        self.proImage = proImage
        self.name = name
        self.time = time
        self.detailImg = detailImg
        self.title = title
        self.detail = detail
    }
}
