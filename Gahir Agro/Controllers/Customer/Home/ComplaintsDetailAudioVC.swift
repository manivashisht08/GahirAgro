//
//  ComplaintsDetailAudioVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 07/12/21.
//

import UIKit
import SDWebImage

class ComplaintsDetailAudioVC: UIViewController {
    
    
    var page = 1
    var lastPage = String()
    var pageCount = Int()
    @IBOutlet weak var tblComplaints: UITableView!
    var ComplaintDetailArray =  [ComplaintDetailModel]()
    var ComplainArr = [ComplainTableData<AnyHashable>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        GetAllCustomerComplainApi()

    }
    func configureUI(){
        tblComplaints.delegate = self
        tblComplaints.dataSource = self
        tblComplaints.separatorStyle = .none
        
        tblComplaints.register(UINib(nibName: "ComplaintsDetailCell", bundle: nil), forCellReuseIdentifier: "ComplaintsDetailCell")
        
        self.ComplaintDetailArray.append(ComplaintDetailModel(image: "Reaper", contactNumber: "+16234823698", productName: "Laser Leveller", productSerialNumber: "ABC-12-ASD-001", problem: "Machine not working properly.", other: "Lorem Ipsum, or ipsum as it is knomw as sometimes known is dummy text used in laying out print graphic or web designs."))
        self.ComplaintDetailArray.append(ComplaintDetailModel(image: "Reaper", contactNumber: "+16234823698", productName: "Laser Leveller", productSerialNumber: "ABC-12-ASD-001", problem: "Machine not working properly.", other: "Lorem Ipsum, or ipsum as it is knomw as sometimes known is dummy text used in laying out print graphic or web designs.Lorem Ipsum, or ipsum as it is knomw as sometimes known is dummy text used in laying out print graphic or web designs."))
        self.ComplaintDetailArray.append(ComplaintDetailModel(image: "Reaper", contactNumber: "+16234823698", productName: "Laser Leveller", productSerialNumber: "ABC-12-ASD-001", problem: "Machine not working properly.", other: "Lorem Ipsum, or ipsum as it is knomw as sometimes known is dummy text used in laying out print graphic or web designs."))
        self.ComplaintDetailArray.append(ComplaintDetailModel(image: "Reaper", contactNumber: "+16234823698", productName: "Laser Leveller", productSerialNumber: "ABC-12-ASD-001", problem: "Machine not working properly.", other: "Lorem Ipsum, or ipsum as it is knomw as sometimes known is dummy text used in laying out print graphic or web designs.Lorem Ipsum, or ipsum as it is knomw as sometimes known is dummy text used in laying out print graphic or web designs."))
        
        self.ComplaintDetailArray.append(ComplaintDetailModel(image: "Reaper", contactNumber: "+16234823698", productName: "Laser Leveller", productSerialNumber: "ABC-12-ASD-001", problem: "Machine not working properly.", other: "Lorem Ipsum, or ipsum as it is knomw as sometimes known is dummy text used in laying out print graphic or web designs.Lorem Ipsum, or ipsum as it is knomw as sometimes known is dummy text used in laying out print graphic or web designs.Lorem Ipsum, or ipsum as it is knomw as sometimes known is dummy text used in laying out print graphic or web designs.Lorem Ipsum, or ipsum as it is knomw as sometimes known is dummy text used in laying out print graphic or web designs."))
        self.ComplaintDetailArray.append(ComplaintDetailModel(image: "Reaper", contactNumber: "+16234823698", productName: "Laser Leveller", productSerialNumber: "ABC-12-ASD-001", problem: "Machine not working properly.", other: "Lorem Ipsum, or ipsum as it is knomw as sometimes known is dummy text used in laying out print graphic or web designs."))
        self.ComplaintDetailArray.append(ComplaintDetailModel(image: "Reaper", contactNumber: "+16234823698", productName: "Laser Leveller", productSerialNumber: "ABC-12-ASD-001", problem: "Machine not working properly.", other: "Lorem Ipsum, or ipsum as it is knomw as sometimes known is dummy text used in laying out print graphic or web designs.Lorem Ipsum, or ipsum as it is knomw as sometimes known is dummy text used in laying out print graphic or web designs."))
        
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func GetAllCustomerComplainApi(){
        DispatchQueue.main.async {
            PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        }
        let url = Constant.shared.baseUrl + Constant.shared.GetAllCustomerComplain
        var deviceID = UserDefaults.standard.value(forKey: "device_token") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
        if deviceID == nil {
            deviceID = "777"
        }
        let param = ["access_token" : accessToken ,"page_no" : page] as [String:AnyObject]
        print(param)
        PKWrapperClass.requestPOSTWithFormData(url, params: param, imageData: []) { [self] (response) in
            let complainResp = CustomerComplainModel(dict: response.data as? [String:AnyHashable] ?? [:])
            print(response)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = complainResp.status
            let msg = complainResp.message
            if status == "1" {
                self.ComplainArr = complainResp.complainListingArr
                self.tblComplaints.reloadData()
            }else {
                PKWrapperClass.svprogressHudDismiss(view: self)
                alert(Constant.shared.appTitle, message: msg, view: self)
            }
        } failure:{(error) in
          print(error)
            PKWrapperClass.svprogressHudDismiss(view: self)
            showAlertMessage(title: Constant.shared.appTitle, message: error as? String ?? "", okButton: "Ok", controller: self, okHandler: nil)
        }
        
    }
    
}

extension ComplaintsDetailAudioVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ComplainArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComplaintsDetailCell", for: indexPath) as! ComplaintsDetailCell
        let dArray = ComplainArr[indexPath.row]
       
            cell.imgDetail.image = UIImage(named: ComplaintDetailArray[indexPath.row].image)
        cell.imgDetail.sd_setImage(with: URL(string: (ComplainArr[indexPath.row].product_detail.prod_image)), placeholderImage: UIImage(named: "placeImg"), options: SDWebImageOptions.continueInBackground, completed: nil)
        cell.lblContact.text = dArray.user_detail.phone_no
        cell.lblProductName.text = dArray.product_detail.prod_name
        cell.lblSerialNumber.text = dArray.prod_sr_no
        cell.lblProblem.text = dArray.comp_reason
        cell.lblAnyIssue.text = dArray.reason_detail
//            cell.audioSlider.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        cell.audioSlider.setThumbImage(UIImage(named: "red"), for: .normal)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

struct ComplaintDetailModel {
    var image : String
    var contactNumber : String
    var productName : String
    var productSerialNumber : String
    var problem :String
    var other : String
    init(image : String,contactNumber : String,productName : String,productSerialNumber : String,problem :String,other : String) {
        self.image = image
        self.contactNumber = contactNumber
        self.productName = productName
        self.productSerialNumber = productSerialNumber
        self.problem = problem
        self.other = other
    }
}
