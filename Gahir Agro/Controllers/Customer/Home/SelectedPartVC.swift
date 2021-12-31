//
//  SelectedPartVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 29/11/21.
//

import UIKit

class SelectedPartVC: UIViewController {

    @IBOutlet weak var selectTableView: UITableView!
    var SelectedPartsModel = [SelectedData]()
    
    var SelectArr = [AllCartTableData<AnyHashable>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        selectTableView.delegate = self
        selectTableView.dataSource = self
        selectTableView.separatorStyle = .none

        selectTableView.register(UINib(nibName: "SelectedPartsCell", bundle: nil), forCellReuseIdentifier: "SelectedPartsCell")
        
        self.SelectedPartsModel.append(SelectedData(count: "1", name: "Thrasher", type: "2458"))
        self.SelectedPartsModel.append(SelectedData(count: "3", name: "Nut Bolt", type: "1234"))
        self.SelectedPartsModel.append(SelectedData(count: "4", name: "Washer", type: "245B"))
        self.SelectedPartsModel.append(SelectedData(count: "9", name: "Concave", type: "245B"))
    }
    
    func selectedPartApi(){
            DispatchQueue.main.async {
                PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
            }
            let url = Constant.shared.baseUrl + Constant.shared.GetAllCartItems
            var deviceID = UserDefaults.standard.value(forKey: "device_token") as? String
            let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
            if deviceID == nil {
                deviceID = "777"
            }
        let param = ["access_token" : accessToken] as [String:AnyObject]
        print(param)
        PKWrapperClass.requestPOSTWithFormData(url, params: param, imageData: []) { [self] (response) in
            let selectedResp = CartProductModel(dict: response.data as? [String:AnyHashable] ?? [:])
            print(response)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = selectedResp.status
            let msg = selectedResp.message
            if status == "1"{
                self.SelectArr = selectedResp.cartListingArr
                self.selectTableView.reloadData()
            }else {
                PKWrapperClass.svprogressHudDismiss(view: self)
                alert(Constant.shared.appTitle, message: msg, view: self)
            }
        }
        failure: {(error) in
            print(error)
            PKWrapperClass.svprogressHudDismiss(view: self)
            showAlertMessage(title: Constant.shared.appTitle, message: error as? String ?? "", okButton: "Ok", controller: self, okHandler: nil)
        }
    }
    

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnEnquiry(_ sender: UIButton) {
    }
    
}

struct SelectedParts {
    var count : String
    var name : String
    var type : String
    init(count : String, name : String , type : String ) {
        self.count = count
        self.name = name
        self.type = type
        
    }
}
extension SelectedPartVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SelectArr.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedPartsCell", for: indexPath) as! SelectedPartsCell
//        cell.nameLbl.text = SelectedPartsModel[indexPath.row].name
        cell.nameLbl.text = SelectArr[indexPath.row].psp_detail.psp_name
        cell.serialLbl.text = SelectedPartsModel[indexPath.row].type
        cell.countViewLbl.text = SelectedPartsModel[indexPath.row].count

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

}

struct SelectedData {
    var count : String
    var name : String
    var type : String
    init(count : String, name : String , type : String ) {
        self.count = count
        self.name = name
        self.type = type
        
    }
}
