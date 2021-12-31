//
//  SideMenuServiceVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 22/11/21.
//

import UIKit
import SDWebImage

class SideMenuServiceVC: UIViewController {

    @IBOutlet weak var sideMenuTable: UITableView!
    var sideMenuItemsArray : [SideMenuItem] = []{
        didSet{
            sideMenuTable.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
      
    }
    
    func configureUI(){
        sideMenuTable.dataSource = self
        sideMenuTable.delegate = self
        sideMenuTable.separatorStyle = .none
        
        sideMenuItemsArray.append(SideMenuItem(name: "Home", selectedImage: "home", selected: true, unselected: "home-1"))
        sideMenuItemsArray.append(SideMenuItem(name: "Complaints", selectedImage: "complaints", selected: false, unselected: "complaints-1"))
        sideMenuItemsArray.append(SideMenuItem(name: "Check Warranty", selectedImage: "check", selected: false, unselected: "check-1"))
        sideMenuItemsArray.append(SideMenuItem(name: "Troubleshooting", selectedImage: "trouble", selected: false, unselected: "trouble-1"))
        sideMenuItemsArray.append(SideMenuItem(name: "Service Manual", selectedImage: "service", selected: false, unselected: "service-1"))
        sideMenuItemsArray.append(SideMenuItem(name: "Rewards", selectedImage: "rewards", selected: false, unselected: "rewards-1"))
    }
    
}

struct SideMenuItem {
    var name : String
    var selectedImage : String
    var unselected : String
    var selected : Bool
    
    init(name : String , selectedImage : String,selected : Bool,unselected : String) {
        self.name = name
        self.selectedImage = selectedImage
        self.selected = selected
        self.unselected = unselected
    }
}

extension SideMenuServiceVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
        cell.nameLbl.text = sideMenuItemsArray[indexPath.row].name
        if sideMenuItemsArray[indexPath.row].selected == true {
            cell.nameLbl.textColor = #colorLiteral(red: 0.8638699651, green: 0.1734898686, blue: 0.112617828, alpha: 1)
            cell.showImage.image = UIImage(named: sideMenuItemsArray[indexPath.row].unselected)
        }else {
            cell.nameLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.showImage.image = UIImage(named: sideMenuItemsArray[indexPath.row].selectedImage)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sideMenuItemsArray = sideMenuItemsArray.map({ (obj) -> SideMenuItem in
            var mutableObj = obj
            mutableObj.selected = false
            return mutableObj
        })
        
        sideMenuItemsArray[indexPath.row].selected = true
        sideMenuController?.hideLeftViewAnimated()
        if indexPath.row == 0 {
           

            let vc = SelectCategoryServiceVC.instantiate(fromAppStoryboard: .Service)
            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)

        }
        else if (indexPath.row == 1) {

            let vc = ComplaintsVC.instantiate(fromAppStoryboard: .Service)
            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
            
        }
        else if (indexPath.row == 2) {

            let vc = CheckWarrantyVC.instantiate(fromAppStoryboard: .Service)
            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        }
        else if (indexPath.row == 3) {

            let vc = CustomerVC.instantiate(fromAppStoryboard: .Service)
            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        }
        else if (indexPath.row) == 4 {

            let vc = CustomerProductVC.instantiate(fromAppStoryboard: .Service)
            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        }
        else if (indexPath.row) == 5 {

            let vc = RewardsVC.instantiate(fromAppStoryboard: .Service)
            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)

        }else {}
    }
    
    
}
