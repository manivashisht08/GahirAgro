//
//  ProductListVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 30/11/21.
//

import UIKit

class ProductListVC: UIViewController {

    @IBOutlet weak var tableProduct: UITableView!
    var ProductListArray = [ProductListData]()

    override func viewDidLoad() {
        super.viewDidLoad()

       configureUI()
    }
    
    func configureUI() {
        tableProduct.delegate = self
        tableProduct.dataSource = self
        tableProduct.separatorStyle = .none
        
        tableProduct.register(UINib(nibName: "ProductListCell", bundle: nil), forCellReuseIdentifier: "ProductListCell")
        
        self.ProductListArray.append(ProductListData(image: "TMCH", name: "Laser Leveller", type: "SUPER-484"))
        self.ProductListArray.append(ProductListData(image: "LEVALER SMALL", name: "Spray Pump", type: "R-30"))
        self.ProductListArray.append(ProductListData(image: "SPRAY PUMP2", name: "Mud Loader", type: "SUPER-555"))
        self.ProductListArray.append(ProductListData(image: "REAPER SMALL", name: "Harvester", type: "SUPER-653"))
        self.ProductListArray.append(ProductListData(image: "SUPER SEEDER", name: "Super Seeder", type: "SUPER-321"))
        self.ProductListArray.append(ProductListData(image: "SYS TILE2", name: "Straw Reaper", type: "SUPER-453"))
    }
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        sideMenuController?.showLeftViewAnimated()
    }
    

}
struct ProductListData {
    var image : String
    var name : String
    var type : String
    init(image : String, name : String , type : String ) {
        self.image = image
        self.name = name
        self.type = type
        
    }

}
extension ProductListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        cell.bgImg.image = UIImage(named: ProductListArray[indexPath.row].image)
        cell.bgView.backgroundColor = getRandomColor()
        cell.nameLbl.text = ProductListArray[indexPath.row].name
        cell.modelLbl.text = ProductListArray[indexPath.row].type
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = FilterVC.instantiate(fromAppStoryboard: .Customer)
//        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
//        sideMenuController?.hideLeftViewAnimated()
        let vc = RegisterProductVC.instantiate(fromAppStoryboard: .Customer)
               (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
               sideMenuController?.hideLeftViewAnimated()
    }
    
    
}


