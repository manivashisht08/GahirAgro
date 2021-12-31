//
//  ProductsCheckVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 01/12/21.
//

import UIKit

class ProductsCheckVC: UIViewController {
    
    var page = 1
    var lastPage = String()
    var pageCount = Int()
    var indexProductArr = Int()
    
    @IBOutlet weak var tableProductCheck: UITableView!
    var filterArr = [AllFilterTableData<AnyHashable>]()
    var productArray = [ProductDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        filterProductCheckApi()
    }
    
    func configureUI() {
        pageCount = 1
        tableProductCheck.delegate = self
        tableProductCheck.dataSource  = self
        tableProductCheck.separatorStyle = .none
        tableProductCheck.allowsMultipleSelection = true
        tableProductCheck.allowsMultipleSelectionDuringEditing = true
        
        tableProductCheck.register(UINib(nibName: "ProductsCheckCell", bundle: nil), forCellReuseIdentifier: "ProductsCheckCell")
        
        self.productArray.append(ProductDataModel(name: "Laser Leveller"))
        self.productArray.append(ProductDataModel(name: "Spray Pump"))
        self.productArray.append(ProductDataModel(name: "Mud Loader"))
        self.productArray.append(ProductDataModel(name: "HArvester"))
        self.productArray.append(ProductDataModel(name: "Super Seeder"))
        self.productArray.append(ProductDataModel(name: "Straw Reaper"))
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        let vc = CustomerReviewVC.instantiate(fromAppStoryboard: .Customer)
        vc.filter = true
        vc.listDataArr = filterArr.filter ({$0.check == true})
        (sideMenuController?.rootViewController as!
            UINavigationController).pushViewController(vc, animated: false)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func filterProductCheckApi(){
        DispatchQueue.main.async {
            PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        }
        let url = Constant.shared.baseUrl + Constant.shared.ProductCheckFilter
        var deviceID = UserDefaults.standard.value(forKey: "device_token") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
        print(accessToken)
        if deviceID == nil {
            deviceID = "777"
        }
        let param = ["access_token" :accessToken, "page_no" :page] as [String:AnyObject]
        print(param)
        PKWrapperClass.requestPOSTWithFormData(url, params: param, imageData: []) { [self] (response) in
            let filterResp = filterProductModel(dict: response.data as? [String:AnyHashable] ?? [:])
            print(response)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = filterResp.status
            let msg = filterResp.message
            if status == "1"{
                self.filterArr = filterResp.filterListingArr
                self.tableProductCheck.reloadData()
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
    
}
struct ProductDataModel {
    var name : String
    init( name : String  ) {
        self.name = name
    }
}
extension ProductsCheckVC : UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsCheckCell", for: indexPath) as! ProductsCheckCell
        cell.lblProduct.text = filterArr[indexPath.row].prod_name
        cell.imgProduct.image = filterArr[indexPath.row].check ? #imageLiteral(resourceName: "ch") : #imageLiteral(resourceName: "btnblank")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filterArr[indexPath.row].check = !filterArr[indexPath.row].check
        self.tableProductCheck.reloadRows(at: [indexPath], with: .none)
     }
}
