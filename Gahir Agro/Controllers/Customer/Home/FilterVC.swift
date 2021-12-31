//
//  FilterVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 30/11/21.
//

import UIKit

class FilterVC: UIViewController {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterTable: UITableView!
    
    var FilterArray = [FilterData]()

    override func viewDidLoad() {
        super.viewDidLoad()
      configureUI()
    }
    
    func configureUI(){
        filterTable.delegate = self
        filterTable.dataSource = self
        filterTable.separatorStyle = .none
        
        filterTable.register(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: "FilterCell")
        
        self.FilterArray.append(FilterData(image: "icon", name: "State"))
        self.FilterArray.append(FilterData(image: "box", name: "Product"))

    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FilterVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FilterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! FilterCell
        cell.imgFilter.image = UIImage(named: FilterArray[indexPath.row].image)
        cell.lblFilter.text = FilterArray[indexPath.row].name
        DispatchQueue.main.async {
                        self.heightConstraint.constant = self.filterTable.contentSize.height
                    }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        let vc = StateListVC.instantiate(fromAppStoryboard: .Customer)
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        sideMenuController?.hideLeftViewAnimated()
        }else {
            let vc = ProductsCheckVC.instantiate(fromAppStoryboard: .Customer)
            (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
            sideMenuController?.hideLeftViewAnimated()
        }
    }
    
}

struct FilterData {
    var image : String
    var name : String
   
    init(image : String, name : String  ) {
        self.image = image
        self.name = name
   
    }
}
