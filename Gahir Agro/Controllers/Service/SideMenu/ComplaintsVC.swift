//
//  ComplaintsVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 23/11/21.
//

import UIKit

class ComplaintsVC: UIViewController {

    @IBOutlet weak var complaintsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        complaintsTable.dataSource = self
        complaintsTable.delegate = self
        complaintsTable.separatorStyle = .none
        
        complaintsTable.register(UINib(nibName: "AttendComplaintCell", bundle: nil), forCellReuseIdentifier: "AttendComplaintCell")
        complaintsTable.register(UINib(nibName: "ComplaintsCell", bundle: nil), forCellReuseIdentifier: "ComplaintsCell")
    }
    

    @IBAction func btnMenu(_ sender: Any) {
        sideMenuController?.showLeftViewAnimated()

    }

}

extension ComplaintsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttendComplaintCell", for: indexPath) as! AttendComplaintCell
            cell.attendBtn.addTarget(self, action:  #selector(showAttend), for: .touchUpInside)
        return cell
    }else {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ComplaintsCell", for: indexPath) as! ComplaintsCell
    return cell
    }
    return UITableViewCell()
    }
    
    @objc func showAttend(sender : UIButton) {
        let story = UIStoryboard(name: "Service", bundle: nil)
        let rootViewController:UIViewController = story.instantiateViewController(withIdentifier: "AttendComplaintVC")
        self.navigationController?.pushViewController(rootViewController, animated: true)
        }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
        return 180
    }else {
    return 140
    }
    }
}
