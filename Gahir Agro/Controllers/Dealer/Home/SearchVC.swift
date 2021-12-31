//
//  SearchVC.swift
//  Gahir Agro
//
//  Created by Apple on 24/02/21.
//

import UIKit
import SDWebImage

class SearchVC: UIViewController,UITextFieldDelegate {
    
    var page = 1
    var lastPage = 1
    var messgae = String()
    var searchArray = [String]()
    var comesFrom = Bool()
    var tableViewDataArray = [SearchTableViewData]()
    var currentIndex = String()
    @IBOutlet weak var recentSearchLbl: UILabel!
    @IBOutlet weak var showSearchedDataTBView: UITableView!
    @IBOutlet weak var searchDataTBView: UITableView!
    @IBOutlet weak var searchTxtFld: UITextField!
    @IBOutlet weak var searchView: UIView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        recentSearch()
        showSearchedDataTBView.delegate = self
        showSearchedDataTBView.dataSource = self
        showSearchedDataTBView.isHidden = true
        
        searchTxtFld.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)

    }
    
//    MARK:- Button Action
    
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
//    MARK:- Text field delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if comesFrom == true{
            if searchTxtFld.text?.isEmpty == true{
                self.showSearchedDataTBView.isHidden = true
                self.searchDataTBView.isHidden = false
            } else {
                self.searchData()
                self.showSearchedDataTBView.reloadData()
                textField.resignFirstResponder()
            }
            return true
        }else{
            if searchTxtFld.text?.isEmpty == true{
                searchDataTBView.reloadData()
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
                self.searchDataTBView.isHidden = false
                searchDataTBView.reloadData()
            } else {
                self.searchData()
                self.showSearchedDataTBView.reloadData()
                textField.resignFirstResponder()
            }
        }else{
            if searchTxtFld.text?.isEmpty == true{
                searchDataTBView.reloadData()
                
            } else {
                self.searchData()
                self.showSearchedDataTBView.reloadData()
                textField.resignFirstResponder()
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == searchTxtFld {
            self.recentSearchLbl.text = "Recent Searches"
            self.showSearchedDataTBView.isHidden = true
            self.searchDataTBView.isHidden = false
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        recentSearched()
    }
    
//    MARK:- Service Call Function
    
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
                
                self.searchDataTBView.reloadData()
                self.recentSearchLbl.text = "Recent Searches"
            }else{
                PKWrapperClass.svprogressHudDismiss(view: self)
//                alert(Constant.shared.appTitle, message: self.messgae, view: self)
            }
        } failure: { (error) in
            print(error)
            PKWrapperClass.svprogressHudDismiss(view: self)
            showAlertMessage(title: Constant.shared.appTitle, message: error as? String ?? "", okButton: "Ok", controller: self, okHandler: nil)
        }
    }
    
    
    func recentSearched() {
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
                
                self.searchDataTBView.reloadData()
                self.recentSearchLbl.text = "Recent Searches"
            }else{
                PKWrapperClass.svprogressHudDismiss(view: self)
            }
        } failure: { (error) in
            print(error)
            PKWrapperClass.svprogressHudDismiss(view: self)
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
                    self.searchDataTBView.isHidden = true
                    print(self.tableViewDataArray)
                    self.recentSearchLbl.text = ""
                    self.showSearchedDataTBView.reloadData()

                }
            }else{
                PKWrapperClass.svprogressHudDismiss(view: self)
                alert(Constant.shared.appTitle, message: self.messgae, view: self)
            }
        } failure: { (error) in
            print(error)
            PKWrapperClass.svprogressHudDismiss(view: self)
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
                    self.searchDataTBView.isHidden = true
                    print(self.tableViewDataArray)
                    self.showSearchedDataTBView.reloadData()

                }
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

//MARK:- Tableview Cell Classes

class SearchDataTBViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

class ShowSearchedDataTBViewCell: UITableViewCell {
    
    @IBOutlet weak var nextbtn: UIButton!
    @IBOutlet weak var checkAvailabiltyButton: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var dataView: UIView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

//MARK:- Table view delegate datasource

extension SearchVC : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchDataTBView{
            return searchArray.count
            
        }else{

            return tableViewDataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == searchDataTBView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchDataTBViewCell", for: indexPath) as! SearchDataTBViewCell
            cell.nameLbl.text = searchArray[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShowSearchedDataTBViewCell", for: indexPath) as! ShowSearchedDataTBViewCell
            cell.nameLbl.text = tableViewDataArray[indexPath.row].name
            cell.showImage.sd_setShowActivityIndicatorView(true)
            if #available(iOS 13.0, *) {
                cell.showImage.sd_setIndicatorStyle(.large)
            } else {
                // Fallback on earlier versions
            }
            cell.showImage.sd_setImage(with: URL(string: tableViewDataArray[indexPath.row].image), placeholderImage: UIImage(named: "placeholder-img-logo (1)"), options: SDWebImageOptions.continueInBackground, completed: nil)
            cell.showImage.roundTop()
            currentIndex = tableViewDataArray[indexPath.row].id
            cell.detailsLbl.text = "₹\(tableViewDataArray[indexPath.row].price)"
            cell.typeLbl.text = tableViewDataArray[indexPath.row].details
//            cell.checkAvailabiltyButton.addTarget(self, action: #selector(goto), for: .touchUpInside)
            cell.nextbtn.addTarget(self, action: #selector(goto), for: .touchUpInside)
            return cell
        }
    }

    
    
    @objc func goto() {
        let vc = ProductDetailsVC.instantiate(fromAppStoryboard: .Main)
        vc.id = currentIndex
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == searchDataTBView{
            return 45
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == searchDataTBView{
            return 45
        }else{
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == searchDataTBView{
            self.comesFrom = true
            self.searchTxtFld.text = searchArray[indexPath.row]
            searchData()
        }else{
            
        }
    }
}

//MARK:- Structurs


struct SearchTableViewData {
    var image : String
    var name : String
    var modelName : String
    var details : String
    var price : String
    var prod_sno : String
    var prod_type : String
    var id : String
    var prod_video : String
    var prod_qty : String
    var prod_pdf : String
    var prod_desc : String

    
    init(image : String,name : String,modelName : String,details : String,price : String,prod_sno : String,prod_type : String,id : String,prod_video : String,prod_qty : String,prod_pdf : String,prod_desc : String) {
        self.image = image
        self.name = name
        self.modelName = modelName
        self.details = details
        self.price = price
        self.prod_sno = prod_sno
        self.prod_type = prod_type
        self.id = id
        self.prod_video = prod_video
        self.prod_qty = prod_qty
        self.prod_pdf = prod_pdf
        self.prod_desc = prod_desc
    }
}

//MARK:- Set empty lable if table view have no data

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 80, y: 200, width: 290, height: 70))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Poppins-SemiBold", size: 20)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
