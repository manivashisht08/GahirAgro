//
//  SearchhVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 06/12/21.
//

import UIKit

class SearchhVC: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblSearch: UITableView!
    var SearchArray =  [SearchModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        tblSearch.delegate = self
        tblSearch.dataSource = self
        tblSearch.separatorStyle = .none
        
        tblSearch.register(UINib(nibName: "CustomerReviewCell", bundle: nil), forCellReuseIdentifier: "CustomerReviewCell")
        
        self.SearchArray.append(SearchModel(proImage: "dimg", name: "Allen Kahir", time: "Sep22,2020", detailImg: "img-2", title: "Lorem Ipsum", detail: "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from  Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."))
        self.SearchArray.append(SearchModel(proImage: "dimg1", name: "Sam Sain", time: "Just Now", detailImg: "im", title: "Lorem Ipsum", detail: "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from  Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from  Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."))
        self.SearchArray.append(SearchModel(proImage: "dimg2", name: "Sam Sain", time: "Sep12,2020", detailImg: "img-3", title: "Lorem Ipsum", detail: "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from  Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from  Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."))
        
        self.SearchArray.append(SearchModel(proImage: "dimg3", name: "Sam Curran", time: "Sep12,2020", detailImg: "imgg", title: "Lorem Ipsum", detail: "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from  Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from  Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."))
    }
    

    @IBAction func btnCancel(_ sender: UIButton) {
        self.txtSearch.text = ""
        self.navigationController?.popViewController(animated: false)

    }
    

}

extension SearchhVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerReviewCell", for: indexPath) as! CustomerReviewCell
        cell.imgProfile.image = UIImage(named: SearchArray[indexPath.row].proImage)
        cell.imgProfile.setRounded()
        cell.lblName.text = SearchArray[indexPath.row].name
        cell.lbltime.text = SearchArray[indexPath.row].time
        cell.imgDetail.image = UIImage(named: SearchArray[indexPath.row].detailImg)
        cell.lblTitle.text = SearchArray[indexPath.row].title
        cell.lblDetail.text  = SearchArray[indexPath.row].detail
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

struct SearchModel {
    var proImage : String
    var name : String
    var time : String
    var detailImg : String
    var title :String
    var detail : String
    init(proImage : String,name : String,time : String,detailImg : String,title :String,detail : String) {
        self.proImage = proImage
        self.name = name
        self.time = time
        self.detailImg = detailImg
        self.title = title
        self.detail = detail
    }
}

