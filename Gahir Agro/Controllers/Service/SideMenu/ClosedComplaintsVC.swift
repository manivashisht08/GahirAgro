//
//  ClosedComplaintsVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 22/11/21.
//

import UIKit

class ClosedComplaintsVC: UIViewController {

    @IBOutlet weak var complaintsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        complaintsTableView.dataSource = self
        complaintsTableView.delegate = self
        complaintsTableView.separatorStyle = .none
        complaintsTableView.register(UINib(nibName: "ComplaintsCell", bundle: nil), forCellReuseIdentifier: "ComplaintsCell")
    }
    

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
extension ClosedComplaintsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComplaintsCell", for: indexPath) as! ComplaintsCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let story = UIStoryboard(name: "Service", bundle: nil)
                let rootViewController:UIViewController = story.instantiateViewController(withIdentifier: "RewardsVC")
                self.navigationController?.pushViewController(rootViewController, animated: true)
    }

}
