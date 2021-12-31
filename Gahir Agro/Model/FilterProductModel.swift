//
//  FilterProductModel.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 17/12/21.
//

import Foundation

struct filterProductModel<T> {
    var status: String
    var message:String
    var allFilterArr:[[String:T]]


    var filterListingArr:[AllFilterTableData<T>]
    init(dict:[String:T]) {
        let status = dict["status"] as? String ?? ""
        let message = dict["message"] as? String ?? ""
        let dataDict = (dict["product_list"] as? [String:T] ?? [:])["all_products"] as? [[String:T]] ?? [[:]]

        
        self.status = status
        self.message = message
        self.allFilterArr = dataDict
        
        var hArray = [AllFilterTableData<T>]()
               for obj in dataDict{
                let childListObj = AllFilterTableData<T>(dataDict:obj)
                   hArray.append(childListObj)
               }
        self.filterListingArr = hArray
        
    }
}

struct AllFilterTableData<T> {
    var id :String
    var prod_name : String
    var prod_model : String
    var prod_cat : String
    var prod_type : String
    var prod_image : String
    var prod_price : String
    var prod_sno : String
    var prod_desc : [T]
    var prod_qty : String
    var prod_video : [T]
    var prod_pdf : [T]
    var prod_acc : String
    var creation_date : String
    var disable : String
    var check : Bool
    
    init(dataDict:[String:T]) {
        let id = dataDict["id"] as? String ?? ""
        let prod_name = dataDict["prod_name"] as? String ?? ""
        let prod_model = dataDict["prod_model"] as? String ?? ""
        let prod_cat = dataDict["prod_cat"] as? String ?? ""
        let prod_type = dataDict["prod_type"] as? String ?? ""
        let prod_image = dataDict["prod_image"] as? String ?? ""
        let prod_price = dataDict["prod_price"] as? String ?? ""
        let prod_sno = dataDict["prod_sno"] as? String ?? ""
        let prod_desc = dataDict["prod_desc"] as? [T] ?? []
        let prod_qty = dataDict["prod_qty"] as? String ?? ""
        let prod_video = dataDict["prod_video"]  as? [T] ?? []
        let prod_pdf = dataDict["prod_pdf"] as? [T] ?? []
        let prod_acc = dataDict["prod_acc"] as? String ?? ""
        let disable = dataDict["disable"] as? String ?? ""
        let creation_date = dataDict["creation_date"] as? String ?? ""
        
        self.id = id
        self.prod_name = prod_name
        self.prod_model = prod_model
        self.prod_cat = prod_cat
        self.prod_type = prod_type
        self.prod_image = prod_image
        self.prod_price = prod_price
        self.prod_sno = prod_sno
        self.prod_desc = prod_desc
        self.prod_qty = prod_qty
        self.prod_video = prod_video
        self.prod_pdf = prod_pdf
        self.prod_acc = prod_acc
        self.creation_date = creation_date
        self.disable = disable
        self.check = false
    }

}
