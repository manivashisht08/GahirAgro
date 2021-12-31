//
//  MyProductsListVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 15/12/21.
//

import UIKit
import  Alamofire
import  SDWebImage
import WebKit

class MyProductsListVC: UIViewController {
    
    var page = 1
    var lastPage = String()
    var message = String()
    var pageCount = Int()
    var isNavFrom:Bool?
    
    
    @IBOutlet weak var productListTable: UITableView!
    var productArr = [AllProductsTableData<AnyHashable>]()
    
    //    var listArray = [ListModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getRegisteredProductDetailApi()
        if isNavFrom == true{
            getRegisteredProductDetailApi()
        }else{
            getRegisteredProductDetailApi()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.productArr.removeAll()
        page = 1
        getRegisteredProductDetailApi()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        productListTable.reloadData()
        
    }
    
    func configureUI(){
        pageCount = 1
        productListTable.delegate = self
        productListTable.dataSource = self
        productListTable.separatorStyle = .none
        productListTable.register(UINib(nibName: "ProductsCell", bundle: nil), forCellReuseIdentifier: "ProductsCell")
        //        self.listArray.append(ListModel(name: "Laser Leveller", image: "TMCH", model: "SUPER-484"))
        //        self.listArray.append(ListModel(name: "Spray Pump", image: "LEVALER SMALL", model: "R-34"))
        //        self.listArray.append(ListModel(name: "Mud Loader", image: "SPRAY PUMP2", model: "SUPER-555"))
        //        self.listArray.append(ListModel(name: "Laser Leveller", image: "TMCH", model: "SUPER-484"))
        //        self.listArray.append(ListModel(name: "Spray Pump", image: "REAPER SMALL", model: "R-34"))
        //        self.listArray.append(ListModel(name: "Mud Loader", image: "SUPER SEEDER", model: "SUPER-555"))
    }
    
    
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    @IBAction func btnFilter(_ sender: UIButton) {
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func getRegisteredProductDetailApi() {
        DispatchQueue.main.async {
            PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        }
        let url = Constant.shared.baseUrl + Constant.shared.RegisterProductDetail
        var deviceID = UserDefaults.standard.value(forKey: "device_token") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
        if deviceID == nil {
            deviceID = "777"
        }
        let param = ["access_token": accessToken , "page_no" : page ] as [String:AnyObject]
        print(param)
        PKWrapperClass.requestPOSTWithFormData(url, params: param, imageData: [])  { [self] (response) in
            let productResp = ProductModel(dict:response.data as? [String : AnyHashable] ?? [:])
            print(response)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = productResp.status
            let msg = productResp.message
            if status == "1" {
                self.productArr = productResp.productListingArr
                self.productListTable.reloadData()
            } else {
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
extension MyProductsListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsCell", for: indexPath) as! ProductsCell
        cell.bgImg.sd_setImage(with: URL(string: productArr[indexPath.row].prod_image), placeholderImage: UIImage(named: "placeholder-img-logo (1)"), options: SDWebImageOptions.continueInBackground, completed: nil)
        cell.bgLbl.text = productArr[indexPath.row].prod_name
        cell.bgView.backgroundColor = getRandomColor()
        cell.modelLbl.text = productArr[indexPath.row].prod_model
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductSpecificationVC.instantiate(fromAppStoryboard: .Customer)
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        vc.productID = productArr[indexPath.row].id
        vc.productModel = productArr[indexPath.row].prod_model
        vc.productImg = productArr[indexPath.row].prod_image
        vc.productSno = productArr[indexPath.row].prod_sno
        vc.productSystm = productArr[indexPath.row].prod_name
        vc.productPdf = productArr[indexPath.row].op_manual
        sideMenuController?.hideLeftViewAnimated()
    }
    
    
}
//struct ListModel {
//    var name :String
//    var image :String
//    var model : String
//
//    init(name:String , image:String , model:String) {
//        self.name = name
//        self.image = image
//        self.model = model
//    }
//}
