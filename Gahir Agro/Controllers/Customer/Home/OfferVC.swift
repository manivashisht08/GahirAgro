//
//  OfferVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 01/12/21.
//

import UIKit

class OfferVC: UIViewController {

    @IBOutlet weak var tableOffer: UITableView!
    var OfferArray = [OfferDataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
configureUI()
      
    }
    func configureUI() {
        tableOffer.delegate = self
        tableOffer.dataSource  = self
        tableOffer.separatorStyle = .none
      
        tableOffer.register(UINib(nibName: "OffersCell", bundle: nil), forCellReuseIdentifier: "OffersCell")
        
        self.OfferArray.append(OfferDataModel(img: "offer"))
//        self.OfferArray.append(OfferDataModel(img: "offer1"))
     
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        sideMenuController?.showLeftViewAnimated()

    }

}
struct OfferDataModel {
    var img : String
    init( img : String  ) {
        self.img = img
    }
}
extension OfferVC : UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OfferArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OffersCell", for: indexPath) as! OffersCell
        cell.imgOffer.image = UIImage(named: OfferArray[indexPath.row].img)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = ProductSpecificationVC.instantiate(fromAppStoryboard: .Customer)
//        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
//    }
}
