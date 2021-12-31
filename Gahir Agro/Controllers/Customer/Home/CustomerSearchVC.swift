//
//  CustomerSearchVC.swift
//  Gahir Agro
//
//  Created by Apple on 15/03/21.
//

import UIKit
import SDWebImage

class CustomerSearchVC: UIViewController ,UITextFieldDelegate{

    var page = 1
    var lastPage = 1
    var messgae = String()
    var searchArray = [String]()
    var comesFrom = Bool()
    var tableViewDataArray = [SearchTableViewData]()
    var currentIndex = String()
    
    @IBOutlet weak var searchTxtFld: UITextField!
    @IBOutlet weak var recentSearchTBView: UITableView!
    @IBOutlet weak var showSearchedDataTBView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        recentSearch()
        showSearchedDataTBView.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if comesFrom == true{
            if searchTxtFld.text?.isEmpty == true{
                self.showSearchedDataTBView.isHidden = true
                self.recentSearchTBView.isHidden = false
            } else {
                self.searchData()
                self.showSearchedDataTBView.reloadData()
                textField.resignFirstResponder()
            }
            return true
        }else{
            if searchTxtFld.text?.isEmpty == true{
                recentSearchTBView.reloadData()
                self.searchData()
            } else {
                showSearchedDataTBView.reloadData()
                textField.resignFirstResponder()
            }
            return true
        }
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if comesFrom == true{
            if searchTxtFld.text?.isEmpty == true{
                self.showSearchedDataTBView.isHidden = true
                self.recentSearchTBView.isHidden = false
                recentSearchTBView.reloadData()
            } else {
                self.searchData()
                self.showSearchedDataTBView.reloadData()
                textField.resignFirstResponder()
            }
        }else{
            if searchTxtFld.text?.isEmpty == true{
                recentSearchTBView.reloadData()
                
            } else {
                self.searchData()
                self.showSearchedDataTBView.reloadData()
                textField.resignFirstResponder()
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == searchTxtFld {
            tableViewDataArray.removeAll()
            showSearchedDataTBView.reloadData()
        }
    }
    
    
    func textFieldDidChange(textField: UITextField){
        tableViewDataArray.removeAll()
        recentSearchTBView.reloadData()
        print("Text changed: " + textField.text!)

    }

    
    func recentSearch() {
        PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        let url = Constant.shared.baseUrl + Constant.shared.RecentSearches
        var deviceID = UserDefaults.standard.value(forKey: "deviceToken") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken")
        print(deviceID ?? "")
        if deviceID == nil  {
            deviceID = "777"
        }
        let params = ["access_token": accessToken]  as? [String : AnyObject] ?? [:]
        print(params)
        PKWrapperClass.requestPOSTWithFormData(url, params: params, imageData: []) { (response) in
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = response.data["status"] as? String ?? ""
            self.messgae = response.data["message"] as? String ?? ""
            if status == "1"{
                self.searchArray.removeAll()
                let allData = response.data["search_list"] as? [String:Any] ?? [:]
                print(allData)
                let searchArrayData = allData["search_list"] as? [String]
                print(searchArrayData)
                searchArrayData?.forEach({ (n) in
                    self.searchArray.append(n)
                    print(n)
                })
                self.recentSearchTBView.reloadData()
            }else{
                PKWrapperClass.svprogressHudDismiss(view: self)
                alert(Constant.shared.appTitle, message: self.messgae, view: self)
            }
        } failure: { (error) in
            print(error)
            showAlertMessage(title: Constant.shared.appTitle, message: error as? String ?? "", okButton: "Ok", controller: self, okHandler: nil)
        }
    }

    func searchData() {
        PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        let url = Constant.shared.baseUrl + Constant.shared.SearchData
        var deviceID = UserDefaults.standard.value(forKey: "deviceToken") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken")
        print(deviceID ?? "")
        if deviceID == nil  {
            deviceID = "777"
        }
        let params = ["page_no": page,"access_token": accessToken,"search" : searchTxtFld.text ?? ""]  as? [String : AnyObject] ?? [:]
        print(params)
        PKWrapperClass.requestPOSTWithFormData(url, params: params, imageData: []) { (response) in
            print(response.data)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = response.data["status"] as? String ?? ""
            self.messgae = response.data["message"] as? String ?? ""
            self.tableViewDataArray.removeAll()
            if status == "1"{
                var newArr = [SearchTableViewData]()
                let allData = response.data["product_list"] as? [String:Any] ?? [:]
                for obj in allData["all_products"] as? [[String:Any]] ?? [[:]] {
                    print(obj)
                    newArr.append(SearchTableViewData(image: obj["prod_image"] as? String ?? "", name: obj["prod_name"] as? String ?? "", modelName: obj["prod_desc"] as? String ?? "", details: obj["prod_desc"] as? String ?? "", price: obj["prod_price"] as? String ?? "", prod_sno: obj["GAIC2K213000"] as? String ?? "", prod_type: obj["prod_type"] as? String ?? "", id: obj["id"] as? String ?? "", prod_video: obj["prod_video"] as? String ?? "", prod_qty: obj["prod_qty"] as? String ?? "", prod_pdf: obj["prod_pdf"] as? String ?? "", prod_desc: obj["prod_desc"] as? String ?? ""))
                }
                for i in 0..<newArr.count{
                    self.tableViewDataArray.append(newArr[i])
                }
                DispatchQueue.main.async {
                    self.showSearchedDataTBView.isHidden = false
                    self.recentSearchTBView.isHidden = true
                    print(self.tableViewDataArray)
                    self.showSearchedDataTBView.reloadData()
                }
            }else{
                PKWrapperClass.svprogressHudDismiss(view: self)
                alert(Constant.shared.appTitle, message: self.messgae, view: self)
            }
        } failure: { (error) in
            print(error)
            showAlertMessage(title: Constant.shared.appTitle, message: error as? String ?? "", okButton: "Ok", controller: self, okHandler: nil)
        }
    }

    
    
    
    func filterdData() {
        PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        let url = Constant.shared.baseUrl + Constant.shared.SearchData
        var deviceID = UserDefaults.standard.value(forKey: "deviceToken") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken")
        print(deviceID ?? "")
        if deviceID == nil  {
            deviceID = "777"
        }
        let params = ["page_no": page,"access_token": accessToken,"search" : searchTxtFld.text ?? ""]  as? [String : AnyObject] ?? [:]
        print(params)
        PKWrapperClass.requestPOSTWithFormData(url, params: params, imageData: []) { (response) in
            print(response.data)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = response.data["status"] as? String ?? ""
            self.tableViewDataArray.removeAll()
            self.messgae = response.data["message"] as? String ?? ""
            if status == "1"{
                var newArr = [SearchTableViewData]()
                let allData = response.data["product_list"] as? [String:Any] ?? [:]
                for obj in allData["all_products"] as? [[String:Any]] ?? [[:]] {
                    print(obj)
                    newArr.append(SearchTableViewData(image: obj["prod_image"] as? String ?? "", name: obj["prod_name"] as? String ?? "", modelName: obj["prod_desc"] as? String ?? "", details: obj["prod_desc"] as? String ?? "", price: obj["prod_price"] as? String ?? "", prod_sno: obj["GAIC2K213000"] as? String ?? "", prod_type: obj["prod_type"] as? String ?? "", id: obj["id"] as? String ?? "", prod_video: obj["prod_video"] as? String ?? "", prod_qty: obj["prod_qty"] as? String ?? "", prod_pdf: obj["prod_pdf"] as? String ?? "", prod_desc: obj["prod_desc"] as? String ?? ""))
                }
                for i in 0..<newArr.count{
                    self.tableViewDataArray.append(newArr[i])
                }
                DispatchQueue.main.async {
                    self.showSearchedDataTBView.isHidden = false
                    self.recentSearchTBView.isHidden = true
                    print(self.tableViewDataArray)
                    self.showSearchedDataTBView.reloadData()
                }
            }else{
                PKWrapperClass.svprogressHudDismiss(view: self)
                alert(Constant.shared.appTitle, message: self.messgae, view: self)
            }
        } failure: { (error) in
            print(error)
            showAlertMessage(title: Constant.shared.appTitle, message: error as? String ?? "", okButton: "Ok", controller: self, okHandler: nil)
        }
    }
}

class CustomerShowSearchedDataTBViewCell: UITableViewCell {
    
    @IBOutlet weak var moreDetails: UIButton!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var modelNameLbl: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

class RecentSearchTBViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var searchImage: UIImageView!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}


extension CustomerSearchVC : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == recentSearchTBView{
            
            if searchArray.count == 0 {
                self.recentSearchTBView.setEmptyMessage("No data")
            } else {
                self.recentSearchTBView.restore()
            }
            return searchArray.count
            
        }else{
            if tableViewDataArray.count == 0 {
                self.showSearchedDataTBView.setEmptyMessage("No data")
            } else {
                self.showSearchedDataTBView.restore()
            }
            return tableViewDataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == recentSearchTBView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchTBViewCell", for: indexPath) as! RecentSearchTBViewCell
            cell.nameLbl.text = searchArray[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerShowSearchedDataTBViewCell", for: indexPath) as! CustomerShowSearchedDataTBViewCell
            cell.modelNameLbl.text = tableViewDataArray[indexPath.row].name
            currentIndex = tableViewDataArray[indexPath.row].id
            cell.productNameLbl.text = tableViewDataArray[indexPath.row].price
            cell.priceLbl.text = tableViewDataArray[indexPath.row].prod_desc
            cell.showImage.sd_setImage(with: URL(string:tableViewDataArray[indexPath.row].image), placeholderImage: UIImage(named: "placeholder-img-logo (1)"), options: SDWebImageOptions.continueInBackground, completed: nil)
            cell.showImage.roundTop()
            cell.moreDetails.addTarget(self, action: #selector(goto), for: .touchUpInside)
            return cell
        }
    }

    
    @objc func goto() {
        let vc = CustomerProductDetailsVC.instantiate(fromAppStoryboard: .Customer)
        vc.id = currentIndex
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == recentSearchTBView{
            return 45
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == recentSearchTBView{
            return 45
        }else{
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == recentSearchTBView{
            self.comesFrom = true
            self.searchTxtFld.text = searchArray[indexPath.row]
//            self.tableViewDataArray.removeAll()
            searchData()
        }else{
            
        }
    }
}
