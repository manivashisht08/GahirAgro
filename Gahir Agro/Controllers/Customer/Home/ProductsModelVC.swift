//
//  ProductsModelVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 30/11/21.
//

import UIKit
import Alamofire
import SDWebImage


class ProductsModelVC: UIViewController {
    
    var page = 1
    var lastPage = String()
    var message = String()
    var pageCount = Int()
    var isNavMenu:Bool?

    
    @IBOutlet weak var productModTable: UITableView!
    var productArr = [AllProductsTableData<AnyHashable>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getRegisteredProductDetailApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.productArr.removeAll()
        page = 1
        getRegisteredProductDetailApi()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        productModTable.reloadData()
        
    }
    func configureUI(){
        pageCount = 1
        productModTable.delegate = self
        productModTable.dataSource = self
        productModTable.separatorStyle = .none
        productModTable.register(UINib(nibName: "ProductsCell", bundle: nil), forCellReuseIdentifier: "ProductsCell")
    }
    
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    func getRegisteredProductDetailApi() {
        DispatchQueue.main.async {
            PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        }
        let url = Constant.shared.baseUrl + Constant.shared.GetRegisterProductDetail
        var deviceID = UserDefaults.standard.value(forKey: "device_token") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
        if deviceID == nil {
            deviceID = "777"
        }
        let param = ["access_token": accessToken , "id" : page ] as [String:AnyObject]
        print(param)
        PKWrapperClass.requestPOSTWithFormData(url, params: param, imageData: [])  { [self] (response) in
            let productResp = ProductModel(dict:response.data as? [String : AnyHashable] ?? [:])
            print(response)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = productResp.status
            let msg = productResp.message
            if status == "1" {
                self.productArr = productResp.productListingArr
                self.productModTable.reloadData()
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
    
    @IBAction func btnMenu(_ sender: UIButton) {
        sideMenuController?.showLeftViewAnimated()
    }
    
    @IBAction func btnFilter(_ sender: UIButton) {
    }
    
}
extension  ProductsModelVC : UITableViewDelegate , UITableViewDataSource {
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
        
        sideMenuController?.hideLeftViewAnimated()
    }
    
}

