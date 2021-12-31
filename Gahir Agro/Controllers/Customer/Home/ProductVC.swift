//
//  ProductVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 07/12/21.
//

import UIKit

class ProductVC: UIViewController {

    @IBOutlet weak var tblProduct: UITableView!
    var page = 1
    var lastPage = String()
    var message = String()
    var pageCount = Int()
    var productArr = [AllProductsTableData<AnyHashable>]()
    var ProductListArray = [ProductListtData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getRegisteredProductDetailApi()
    }
    
    func configureUI() {
        tblProduct.delegate = self
        tblProduct.dataSource = self
        tblProduct.separatorStyle = .none
        
        tblProduct.register(UINib(nibName: "ProductListCell", bundle: nil), forCellReuseIdentifier: "ProductListCell")
        
        self.ProductListArray.append(ProductListtData(image: "TMCH", name: "Laser Leveller", type: "SUPER-484"))
        self.ProductListArray.append(ProductListtData(image: "LEVALER SMALL", name: "Spray Pump", type: "R-30"))
        self.ProductListArray.append(ProductListtData(image: "SPRAY PUMP2", name: "Mud Loader", type: "SUPER-555"))
        self.ProductListArray.append(ProductListtData(image: "REAPER SMALL", name: "Harvester", type: "SUPER-653"))
        self.ProductListArray.append(ProductListtData(image: "SUPER SEEDER", name: "Super Seeder", type: "SUPER-321"))
        self.ProductListArray.append(ProductListtData(image: "SYS TILE2", name: "Straw Reaper", type: "SUPER-453"))
    }
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.productArr.removeAll()
        page = 1
        getRegisteredProductDetailApi()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tblProduct.reloadData()
        
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
                self.tblProduct.reloadData()
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

extension ProductVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        cell.bgImg.image = UIImage(named: ProductListArray[indexPath.row].image)
        cell.bgView.backgroundColor = getRandomColor()
        cell.nameLbl.text = productArr[indexPath.row].prod_name
        cell.modelLbl.text = productArr[indexPath.row].prod_model
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddReviewDetailVC.instantiate(fromAppStoryboard: .Customer)
        vc.productId = productArr[indexPath.row].id
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        sideMenuController?.hideLeftViewAnimated()
    }
    
}
struct ProductListtData {
    var image : String
    var name : String
    var type : String
    init(image : String, name : String , type : String ) {
        self.image = image
        self.name = name
        self.type = type
        
    }

}
