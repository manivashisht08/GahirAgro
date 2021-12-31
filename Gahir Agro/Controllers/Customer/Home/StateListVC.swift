//
//  StateListVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 03/12/21.
//

import UIKit

class StateListVC: UIViewController {
    
    var page = 1
    var lastPage = String()
    var pageCount = Int()
    var indexProductArr = Int()

    @IBOutlet weak var tblState: UITableView!
    var filterArr = [AllFilterTableData<AnyHashable>]()
    var StateArray = [StateDataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
//        filterStateApi()
    }
    
    func configureUI() {
        pageCount = 1
        tblState.delegate = self
        tblState.dataSource  = self
        tblState.separatorStyle = .none
        tblState.allowsMultipleSelection = true
        tblState.allowsMultipleSelectionDuringEditing = true
        
        tblState.register(UINib(nibName: "StatesListCell", bundle: nil), forCellReuseIdentifier: "StatesListCell")
        
        self.StateArray.append(StateDataModel(name: "Chandigarh"))
        self.StateArray.append(StateDataModel(name: "Andhra Pradesh"))
        self.StateArray.append(StateDataModel(name: "Assam"))
        self.StateArray.append(StateDataModel(name: "Bihar"))
        self.StateArray.append(StateDataModel(name: "Chhattisgarh"))
        self.StateArray.append(StateDataModel(name: "Goa"))
        self.StateArray.append(StateDataModel(name: "Gujarat"))
        self.StateArray.append(StateDataModel(name: "Haryana"))
        self.StateArray.append(StateDataModel(name: "Himachal Pradesh"))
        self.StateArray.append(StateDataModel(name: "Jharkhand"))
        self.StateArray.append(StateDataModel(name: "Karnataka"))
        self.StateArray.append(StateDataModel(name: "Kerala"))
        self.StateArray.append(StateDataModel(name: "Madhya Pradesh"))
        self.StateArray.append(StateDataModel(name: "Maharashtra"))
        self.StateArray.append(StateDataModel(name: "Manipur"))
        self.StateArray.append(StateDataModel(name: "Meghalaya"))
        self.StateArray.append(StateDataModel(name: "Mizoram"))
        self.StateArray.append(StateDataModel(name: "Nagaland"))
        self.StateArray.append(StateDataModel(name: "Odhisha"))
        self.StateArray.append(StateDataModel(name: "Punjab"))
        self.StateArray.append(StateDataModel(name: "Rajasthan"))
        self.StateArray.append(StateDataModel(name: "Sikkim"))
        self.StateArray.append(StateDataModel(name: "Tamil Nadu"))
        self.StateArray.append(StateDataModel(name: "Telangana"))
        self.StateArray.append(StateDataModel(name: "Tripura"))
        self.StateArray.append(StateDataModel(name: "Uttar Pradesh"))
        self.StateArray.append(StateDataModel(name: "Uttarakhand"))
        self.StateArray.append(StateDataModel(name: "West Bengal"))
        self.StateArray.append(StateDataModel(name: "Andaman and Nicobar Islands"))
        self.StateArray.append(StateDataModel(name: "Dadra and Nagar Haveli"))
        self.StateArray.append(StateDataModel(name: "Daman and Diu"))
        self.StateArray.append(StateDataModel(name: "Delhi"))
        self.StateArray.append(StateDataModel(name: "Jammu and Kashmir"))
        self.StateArray.append(StateDataModel(name: "Ladakh"))
        self.StateArray.append(StateDataModel(name: "Lakshadweep"))
        self.StateArray.append(StateDataModel(name: "Puducherry"))
    
    }
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        let vc = CustomerReviewVC.instantiate(fromAppStoryboard: .Customer)
//        vc.filter = true
//        vc.listDataArr = filterArr.filter ({$0.check == true})
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: false)
    }
    
    func filterStateApi(){
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
        let param = ["access_token" :accessToken, "page_no":page] as [String:AnyObject]
        print(param)
        PKWrapperClass.requestPOSTWithFormData(url, params: param, imageData: []) { [self] (response) in
            let filterResp = filterProductModel(dict: response.data as? [String:AnyHashable] ?? [:])
            print(response)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = filterResp.status
            let msg = filterResp.message
            if status == "1"{
                self.filterArr = filterResp.filterListingArr
                self.tblState.reloadData()
            }else {
                PKWrapperClass.svprogressHudDismiss(view: self)
                alert(Constant.shared.appTitle, message: msg, view: self)
    }
        }failure: {(error) in
            print(error)
            PKWrapperClass.svprogressHudDismiss(view: self)
            showAlertMessage(title: Constant.shared.appTitle, message: error as? String ?? "", okButton: "Ok", controller: self, okHandler: nil)
        }
}
}
extension StateListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StateArray.count
//        return filterArr.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatesListCell", for: indexPath) as! StatesListCell
        cell.lblState.text = StateArray[indexPath.row].name
//        cell.imgState.image = filterArr[indexPath.row].check ? #imageLiteral(resourceName: "ch") : #imageLiteral(resourceName: "btnblank")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tblState.cellForRow(at: indexPath) as? StatesListCell  {

            let selectredRows = tableView.indexPathsForSelectedRows
            DispatchQueue.main.async {
                selectredRows?.forEach({ (selectedRow) in
                    tableView.selectRow(at: selectedRow, animated: false, scrollPosition: .none)
                })
            }
            cell.imgState.image = UIImage(named: "ch")

        }
//        filterArr[indexPath.row].check = !filterArr[indexPath.row].check
//        self.tblState.reloadRows(at: [indexPath], with: .none)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tblState.cellForRow(at: indexPath) as? StatesListCell  {
            cell.imgState.image = UIImage(named: "btnblank")

        }
        
    }
    
}
struct StateDataModel {
    var name : String
    init( name : String  ) {
        self.name = name
    }
}
