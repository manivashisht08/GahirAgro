//
//  ThrasherListCell.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 03/12/21.
//

import UIKit
protocol reloadData{
    func reload(dt:Bool)
}

class ThrasherListCell: UITableViewCell {

    var count = 0
    var delegate:reloadData?
    
    @IBOutlet weak var btnIncrement: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnDecrement: UIButton!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgThrasher: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblCount.text = "\(count)"
        btnIncrement.addTarget(self, action: #selector(add(sender:)), for: .touchUpInside)
        btnDecrement.addTarget(self, action: #selector(subtract(sender:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        if selected{
            imgThrasher.image = UIImage(named: "ch")
               }else{
                imgThrasher.image = UIImage(named: "btnblank")
               }
    }
    
    @objc func add(sender:UIButton){
        if count != 999{
        count = count + 1
            lblCount.text = "\(count)"
        }
        delegate?.reload(dt: true)
    }
    
    @objc func subtract(sender:UIButton){
        if count > 0{
        count = count - 1
            lblCount.text = "\(count)"
        }
        delegate?.reload(dt: true)
     }
    
    
}
