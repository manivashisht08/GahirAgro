//
//  CustomerVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 22/11/21.
//

import UIKit

class CustomerVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var CustomerServiceModel = [CustomerService]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
//        var catImages = ["TMCH","LEVALER SMALL","SPRAY PUMP2","REAPER SMALL","MUD LOADER","SUPER SEEDER","SYS TILE2"]
        
        tableView.register(UINib(nibName: "CustomerCell", bundle: nil), forCellReuseIdentifier: "CustomerCell")
        self.CustomerServiceModel.append(CustomerService(image: "TMCH", name: "Laser Leveller", type: "SUPER-484"))
        self.CustomerServiceModel.append(CustomerService(image: "LEVALER SMALL", name: "Spray Pump", type: "R-30"))
        self.CustomerServiceModel.append(CustomerService(image: "SPRAY PUMP2", name: "Mud Loader", type: "SUPER-555"))
        self.CustomerServiceModel.append(CustomerService(image: "REAPER SMALL", name: "Harvester", type: "SUPER-653"))
        self.CustomerServiceModel.append(CustomerService(image: "SUPER SEEDER", name: "Super Seeder", type: "SUPER-321"))
        self.CustomerServiceModel.append(CustomerService(image: "SYS TILE2", name: "Straw Reaper", type: "SUPER-453"))

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
extension CustomerVC : UITableViewDataSource , UITableViewDelegate {
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            let story = UIStoryboard(name: "Service", bundle: nil)
            let rootViewController:UIViewController = story.instantiateViewController(withIdentifier: "TroubleShootVC")
            self.navigationController?.pushViewController(rootViewController, animated: true)
      
    }
}

struct CustomerService {
    var image : String
    var name : String
    var type : String
    init(image : String, name : String , type : String ) {
        self.image = image
        self.name = name
        self.type = type
        
    }
}

