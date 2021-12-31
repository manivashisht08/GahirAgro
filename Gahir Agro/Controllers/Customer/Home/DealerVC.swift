//
//  DealerVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 30/11/21.
//

import UIKit
import  SDWebImage

class DealerVC: UIViewController {
    
    var page = 1
    var lastPage = String()
    var pageCount = Int()

    @IBOutlet weak var lblHelpcare: UILabel!
    @IBOutlet weak var dealerTable: UITableView!

    var dealerArr = [dealerTableData<AnyHashable>]()
    var DealerModelArray = [DealerModel]()
    var SearchState:String?
    var searchDistt:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addPartApi()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        page = 1
    }
    
    func configureUI(){
        pageCount = 1
        dealerTable.separatorStyle = .none
        dealerTable.delegate = self
        dealerTable.dataSource = self
        dealerTable.reloadData()
        
        dealerTable.register(UINib(nibName: "DealerListCell", bundle: nil), forCellReuseIdentifier: "DealerListCell")
        
        self.DealerModelArray.append(DealerModel(image: "dimg", name: "M/s Ram Enterprises", address: "Julana", mobile: "99858-55471"))
        self.DealerModelArray.append(DealerModel(image: "dimg1", name: "M/s Shyam Enterprises", address: "Jind", mobile: "99858-55471"))
        self.DealerModelArray.append(DealerModel(image: "dimg2", name: "M/s Shri Balaji", address: "Rohtak", mobile: "99858-55471"))
        self.DealerModelArray.append(DealerModel(image: "dimg3", name: "M/s Ram Enterprises", address: "Sangrur", mobile: "99115-56345"))
        
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHelpline(_ sender: UIButton) {
    }
    
    func addPartApi(){
        DispatchQueue.main.async {
            PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        }
        let url = Constant.shared.baseUrl + Constant.shared.SearchDealer
        var deviceID = UserDefaults.standard.value(forKey: "device_token") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
        print(accessToken)
        if deviceID == nil {
            deviceID = "777"
        }
        let param = ["access_token" : accessToken ,"page_no": page , "district": searchDistt , "state" :SearchState] as [String:AnyObject]
        print(param)
        PKWrapperClass.requestPOSTWithFormData(url, params: param, imageData: []) {
            (response) in
            let dealerResp = dealerModel(dict: response.data as? [String:AnyHashable] ?? [:])
            print(response)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = dealerResp.status
            let msg = dealerResp.message
            let helpno = dealerResp.helpline
            
            if status == "1" {
                self.dealerArr = dealerResp.dealerListingArr
                self.lblHelpcare.text = helpno
                self.dealerTable.reloadData()
                
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


extension  DealerVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dealerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DealerListCell") as! DealerListCell
        cell.imgDealer.sd_setImage(with: URL(string: dealerArr[indexPath.row].image), placeholderImage: UIImage(named: "placeImg"), options: SDWebImageOptions.continueInBackground, completed: nil)
        cell.imgDealer.setRounded()
        cell.nameLbl.text =
            dealerArr[indexPath.row].first_name
        print("okk")
        cell.addressLbl.text = dealerArr[indexPath.row].district
        cell.numberLbl.text =  dealerArr[indexPath.row].phone_no
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
}
struct DealerModel {
    var image : String
    var name : String
    var address : String
    var mobile : String
    
    
    
    init(image:String , name:String , address: String,mobile:String) {
        self.image = image
        self.name = name
        self.address = address
        self.mobile = mobile
    }
}
