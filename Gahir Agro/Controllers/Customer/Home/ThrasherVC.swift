//
//  ThrasherVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 04/12/21.
//

import UIKit

class ThrasherVC: UIViewController {

    @IBOutlet weak var tableThrasher: UITableView!
    @IBOutlet weak var imgAssembly: UIImageView!
    @IBOutlet weak var imgTop: UIImageView!
    var ThrasherDataArray = [ThrasherDataModel]()
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        thrasherApi()
    }
    
    func configureUI(){
        tableThrasher.delegate = self
        tableThrasher.dataSource = self
        tableThrasher.separatorStyle = .none
        tableThrasher.allowsMultipleSelection = true
        tableThrasher.allowsMultipleSelectionDuringEditing = true
        
        tableThrasher.register(UINib(nibName: "ThrasherListCell", bundle: nil), forCellReuseIdentifier: "ThrasherListCell")
        
        self.ThrasherDataArray.append(ThrasherDataModel(name: "THRASHER", model: "2458"))
        self.ThrasherDataArray.append(ThrasherDataModel(name: "SHAFT", model: "1234"))
        self.ThrasherDataArray.append(ThrasherDataModel(name: "BEARING", model: "5678"))
        self.ThrasherDataArray.append(ThrasherDataModel(name: "SPICK", model: "9810"))
        self.ThrasherDataArray.append(ThrasherDataModel(name: "NUT BOLT", model: "1234"))
        self.ThrasherDataArray.append(ThrasherDataModel(name: "PULLY", model: "5678"))
        self.ThrasherDataArray.append(ThrasherDataModel(name: "SUPPORT", model: "9881"))
        self.ThrasherDataArray.append(ThrasherDataModel(name: "PIN", model: "2458"))
        self.ThrasherDataArray.append(ThrasherDataModel(name: "WASHER", model: "1234"))
        self.ThrasherDataArray.append(ThrasherDataModel(name: "STRIPP", model: "5678"))
        self.ThrasherDataArray.append(ThrasherDataModel(name: "CONCAVE", model: "9810"))
        self.ThrasherDataArray.append(ThrasherDataModel(name: "SUPPORT", model: "1234"))
        self.ThrasherDataArray.append(ThrasherDataModel(name: "PIN", model: "1234"))

    }
    
    func thrasherApi(){
        DispatchQueue.main.async {
            PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        }
        let url = Constant.shared.baseUrl + Constant.shared.AddCart
        var deviceID = UserDefaults.standard.value(forKey: "device_token") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
        if deviceID == nil {
            deviceID = "777"
        }
        let param = ["access_token" : accessToken ,"items":[["psp_id":"4","qty":"2"]]] as [String:AnyObject]
        print(param)
        AFWrapperClass.requestPOSTURL(url, params: param) { (response) in
            PKWrapperClass.svprogressHudDismiss(view: self)
            print(response)
        } failure: { (error) in
            PKWrapperClass.svprogressHudDismiss(view: self)
            showAlertMessage(title: Constant.shared.appTitle, message: error as? String ?? "", okButton: "Ok", controller: self, okHandler: nil)
        }


    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddCart(_ sender: UIButton) {
        let vc = SelectedPartVC.instantiate(fromAppStoryboard: .Customer)
        thrasherApi()
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
    }
    
    
}

extension  ThrasherVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ThrasherDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThrasherListCell", for: indexPath) as! ThrasherListCell
        cell.lblName.text = ThrasherDataArray[indexPath.row].name
        cell.lblModel.text = ThrasherDataArray[indexPath.row].model
        cell.btnIncrement.tag = indexPath.row
        cell.btnDecrement.tag = indexPath.row
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableThrasher.cellForRow(at: indexPath) as? ThrasherListCell  {
            
            let selectredRows = tableView.indexPathsForSelectedRows
            DispatchQueue.main.async {
                selectredRows?.forEach({ (selectedRow) in
                    tableView.selectRow(at: selectedRow, animated: false, scrollPosition: .none)
                })
            }
            cell.imgThrasher.image = UIImage(named: "ch")
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableThrasher.cellForRow(at: indexPath) as? ThrasherListCell  {
            cell.imgThrasher.image = UIImage(named: "btnblank")

        }
        
    }

}

struct ThrasherDataModel {
    var name : String
    var model : String
    init( name : String , model:String ) {
        self.name = name
        self.model = model
    }
}
