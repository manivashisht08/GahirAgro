//
//  CartModel.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 23/12/21.
//

import Foundation

struct CartProductModel<T> {
    var status: String
    var message:String
    var cartFilterArr:[[String:T]]
    
    var cartListingArr:[AllCartTableData<T>]
    
    init(dict:[String:T]) {
        let status = dict["status"] as? String ?? ""
        let message = dict["message"] as? String ?? ""
        let dataDict = (dict["cart_items"] as? [String:T] ?? [:])["psp_detail"] as? [[String:T]] ??  [[:]]
        
        self.status = status
        self.message = message
        self.cartFilterArr = dataDict
        
        var hArray = [AllCartTableData<T>]()
               for obj in dataDict{
                let childListObj = AllCartTableData(dataDict:obj)
                   hArray.append(childListObj)
               }
               self.cartListingArr = hArray
        
    }
}
struct AllCartTableData<T> {
    var cart_id:String
    var user_id:String
    var psp_id:String
    var qty:String
    var enq_add:String
    var creation_date:String
    var psp_detail:CartDetailData<T>

    
    init(dataDict:[String:T]) {
        let cart_id = dataDict["cart_id"] as? String ?? ""
        let user_id = dataDict["user_id"] as? String ?? ""
        let psp_id = dataDict["psp_id"] as? String ?? ""
        let qty = dataDict["qty"] as? String ?? ""
        let enq_add = dataDict["enq_add"] as? String ?? ""
        let creation_date = dataDict["creation_date"] as? String ?? ""
        let psp_detail = dataDict["psp_detail"] as? [String:T] ?? [:]
        
        self.cart_id = cart_id
        self.user_id = user_id
        self.psp_id = psp_id
        self.qty = qty
        self.enq_add = enq_add
        self.creation_date = creation_date
        
//        var hArray = [CartDetailData<T>]()
//               for obj in psp_detail{
//                let childListObj = CartDetailData<Any>(dataDict:obj)
//                   hArray.append(childListObj)
//    }
        self.psp_detail = CartDetailData(dataDict: psp_detail)

    }

struct CartDetailData<T> {
    var psp_id:String
    var pp_id:String
    var prod_id:String
    var psp_name:String
    var psp_key:String
    var creation_date:String
    var disable:String
    
    init(dataDict:[String:T]) {
        let psp_id = dataDict["psp_id"] as? String ?? ""
        let pp_id = dataDict["pp_id"] as? String ?? ""
        let prod_id = dataDict["prod_id"] as? String ?? ""
        let psp_name = dataDict["psp_name"] as? String ?? ""
        let psp_key = dataDict["psp_key"] as? String ?? ""
        let creation_date = dataDict["creation_date"] as? String ?? ""
        let disable = dataDict["disable"] as? String ?? ""
        
        self.psp_id = psp_id
        self.pp_id = pp_id
        self.prod_id = prod_id
        self.psp_name = psp_name
        self.psp_key = psp_key
        self.creation_date = creation_date
        self.disable = disable
    }

}
}
