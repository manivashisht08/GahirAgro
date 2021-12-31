//
//  SideMenuForCustomerVC.swift
//  Gahir Agro
//
//  Created by Apple on 12/03/21.
//

import UIKit
import LGSideMenuController

class SideMenuForCustomerVC: UIViewController {

    
    var sideMenuItemsArrayForCustomer : [SideMenuItemsForCustomer] = []{
        didSet{
            settingTBViewForCustomer.reloadData()
        }
    }
    
    @IBOutlet weak var settingTBViewForCustomer: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuItemsArrayForCustomer.append(SideMenuItemsForCustomer(name: "Home", selectedImage: "shome", selected: true, unselected: "uhome"))
        
        sideMenuItemsArrayForCustomer.append(SideMenuItemsForCustomer(name: "Search Dealer", selectedImage: "ssearch", selected: false, unselected: "usearch"))
        sideMenuItemsArrayForCustomer.append(SideMenuItemsForCustomer(name: "Customer Review", selectedImage: "sreview", selected: false, unselected: "ureview"))
        sideMenuItemsArrayForCustomer.append(SideMenuItemsForCustomer(name: "Register your Product", selectedImage: "sregister", selected: false, unselected: "uregister"))
        sideMenuItemsArrayForCustomer.append(SideMenuItemsForCustomer(name: "My Products", selectedImage: "sproducts", selected: false, unselected: "uproducts"))
        sideMenuItemsArrayForCustomer.append(SideMenuItemsForCustomer(name: "Privacy Policy", selectedImage: "sprivacy", selected: false, unselected: "uprivacy"))
        sideMenuItemsArrayForCustomer.append(SideMenuItemsForCustomer(name: "Offers", selectedImage: "soffers", selected: false, unselected: "uoffer"))
        sideMenuItemsArrayForCustomer.append(SideMenuItemsForCustomer(name: "Convertor", selectedImage: "sconvertor", selected: false, unselected: "uconvertor"))
        sideMenuItemsArrayForCustomer.append(SideMenuItemsForCustomer(name: "Complaints", selectedImage: "scomplaints", selected: false, unselected: "ucomplaints"))
        sideMenuItemsArrayForCustomer.append(SideMenuItemsForCustomer(name: "Contact Us", selectedImage: "scontact", selected: false, unselected: "ucontact"))
        sideMenuItemsArrayForCustomer.append(SideMenuItemsForCustomer(name: "Login", selectedImage: "slogin", selected: false, unselected: "ulogin"))
        
        self.settingTBViewForCustomer.separatorStyle = .none


        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.height/2
    }
    
    func logout()  {
        UserDefaults.standard.removeObject(forKey: "tokenFString")
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.Logout1()
    }
    
    @IBAction func gotoSettingVC(_ sender: Any) {
        sideMenuController?.hideLeftViewAnimated()
        let vc = AdminProfileVC.instantiate(fromAppStoryboard: .AdminMain)
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
    }
    
}

class SettingTBViewCellForCustomer: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension SideMenuForCustomerVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuItemsArrayForCustomer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTBViewCellForCustomer", for: indexPath) as! SettingTBViewCellForCustomer
        cell.nameLbl.text = sideMenuItemsArrayForCustomer[indexPath.row].name
        if sideMenuItemsArrayForCustomer[indexPath.row].selected == true{
            cell.nameLbl.textColor = #colorLiteral(red: 0.8846299052, green: 0.04529493302, blue: 0, alpha: 1)
            cell.iconImage.image = UIImage(named: sideMenuItemsArrayForCustomer[indexPath.row].unselected)
        }else{
            cell.nameLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.iconImage.image = UIImage(named: sideMenuItemsArrayForCustomer[indexPath.row].selectedImage)
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sideMenuItemsArrayForCustomer = sideMenuItemsArrayForCustomer.map({ (obj) -> SideMenuItemsForCustomer in
            var mutableObj = obj
            mutableObj.selected = false
            return mutableObj
        })
        sideMenuItemsArrayForCustomer[indexPath.row].selected = true
        sideMenuController?.hideLeftViewAnimated()
        
        if(indexPath.row == 0) {
            let vc = CustomerHomeVC.instantiate(fromAppStoryboard: .Customer)
            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        }
        
        else if(indexPath.row == 1) {
            let vc = SearchDealerVC.instantiate(fromAppStoryboard: .Customer)
            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
            //            guard let url = URL(string: "https://stackoverflow.com") else { return }
            //            UIApplication.shared.open(url)
            //
        }
        
        else if(indexPath.row == 2) {
            let vc = CustomerReviewVC.instantiate(fromAppStoryboard: .Customer)
            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
            
        }
        
        else if(indexPath.row == 3) {
            let vc = ProductListVC.instantiate(fromAppStoryboard: .Customer)
            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        }
        
        else if(indexPath.row == 4) {
            
            let vc = MyProductsListVC.instantiate(fromAppStoryboard: .Customer)
            vc.isNavFrom == true
            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
            
        }
        else if(indexPath.row == 5) {
            
           
            
        }
        else if(indexPath.row == 6) {
            let vc = OfferVC.instantiate(fromAppStoryboard: .Customer)
            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        }
        else if(indexPath.row == 7) {
           
         
        }
        else if(indexPath.row == 8) {
            let vc = ComplaintsDetailAudioVC.instantiate(fromAppStoryboard: .Customer)
            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        }
        else if(indexPath.row == 9) {
            
        }
        else if(indexPath.row == 10) {
            let dialogMessage = UIAlertController(title: Constant.shared.appTitle, message: "Are you sure you want to Logout?", preferredStyle: .alert)

            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button click...")
                UserDefaults.standard.set(false, forKey: "tokenFString")
                self.logout()
            })

            // Create Cancel button with action handlder
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                print("Cancel button click...")
            }

            //Add OK and Cancel button to dialog message
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)

            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
            
            let story = UIStoryboard(name: "Service", bundle: nil)
                     let rootViewController:UIViewController = story.instantiateViewController(withIdentifier: "SideMenuControllerID")
            
//            let storyboard = UIStoryboard(name: "Service", bundle: nil)
//
//                if let vc = storyboard.instantiateViewController(withIdentifier: "SideMenuControllerID") as? SideMenuControllerr {
////                    present(vc, animated: true, completion: nil)
//                    self.navigationController?.pushViewController(vc, animated: true)

                }
//            
            
//            let vc = SideMenuServiceVC.instantiate(fromAppStoryboard: .Service)
//            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
//        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


struct SideMenuItemsForCustomer {
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
