//
//  CustomerProductVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 25/11/21.
//

import UIKit

class CustomerProductVC: UIViewController {

    @IBOutlet weak var customerProductTable: UITableView!
    var CustomerServiceModel = [CustomerProductService]()

    override func viewDidLoad() {
        super.viewDidLoad()
        customerProductTable.dataSource = self
        customerProductTable.delegate = self
        customerProductTable.separatorStyle = .none

        customerProductTable.register(UINib(nibName: "CustomerCell", bundle: nil), forCellReuseIdentifier: "CustomerCell")
        
        self.CustomerServiceModel.append(CustomerProductService(image: "TMCH", name: "Laser Leveller", type: "SUPER-484"))
        self.CustomerServiceModel.append(CustomerProductService(image: "LEVALER SMALL", name: "Spray Pump", type: "R-30"))
        self.CustomerServiceModel.append(CustomerProductService(image: "SPRAY PUMP2", name: "Mud Loader", type: "SUPER-555"))
        self.CustomerServiceModel.append(CustomerProductService(image: "REAPER SMALL", name: "Harvester", type: "SUPER-653"))
        self.CustomerServiceModel.append(CustomerProductService(image: "SUPER SEEDER", name: "Super Seeder", type: "SUPER-321"))
        self.CustomerServiceModel.append(CustomerProductService(image: "SYS TILE2", name: "Straw Reaper", type: "SUPER-453"))
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        sideMenuController?.showLeftViewAnimated()

    }
    
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }

}
extension CustomerProductVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CustomerServiceModel.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCell", for: indexPath) as! CustomerCell
        cell.productImageView.image =  UIImage(named: CustomerServiceModel[indexPath.row].image)
        cell.nameLbl.text = CustomerServiceModel[indexPath.row].name
        cell.typeLbl.text = CustomerServiceModel[indexPath.row].type
        cell.bgView.backgroundColor = getRandomColor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        
            let story = UIStoryboard(name: "Service", bundle: nil)
            let rootViewController:UIViewController = story.instantiateViewController(withIdentifier: "ServiceManualVC")
            self.navigationController?.pushViewController(rootViewController, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
struct CustomerProductService {
    var image : String
    var name : String
    var type : String
    init(image : String, name : String , type : String ) {
        self.image = image
        self.name = name
        self.type = type
        
    }
}
