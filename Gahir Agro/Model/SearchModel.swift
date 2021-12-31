//
//  SearchModel.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 16/12/21.
//

import Foundation

struct searchModel<T> {
    var status :String
    var message : String
    var searchListingArr:[SearchTableData<T>]

    
    init(dict:[String:T]) {
        let status = dict["status"] as? String ?? ""
        let message = dict["message"] as? String ?? ""
        let dataArr =  dict["state_list"] as? [[String:T]] ?? [[:]]
        self.status = status
        self.message = message
        
        var hArray = [SearchTableData<T>]()
               for obj in dataArr{
                let childListObj = SearchTableData(dataDict:obj)
                   hArray.append(childListObj)
               }
        self.searchListingArr = hArray
    }
}
struct SearchTableData<T> {
    var state_id:String
    var state_title:String
    var state_description:String
    var status:String
    var all_districts:[DistrictDetailData<T>]
    
    init(dataDict:[String:T]) {
        let state_id = dataDict["state_id"] as? String ?? ""
        let state_title = dataDict["state_title"] as? String ?? ""
        let state_description = dataDict["state_description"] as? String ?? ""
        let status = dataDict["status"] as? String ?? ""
        let all_districts = dataDict["all_districts"] as? [[String:T]] ?? [[:]]
        
        self.state_id = state_id
        self.state_title = state_title
        self.state_description = state_description
        self.status = status
        var hArray = [DistrictDetailData<T>]()
               for obj in all_districts{
                let childListObj = DistrictDetailData(dataDict:obj)
                   hArray.append(childListObj)
               }
        self.all_districts = hArray
        
    }
}

struct DistrictDetailData<T> {
    var districtid : String
    var district_title : String
    var state_id : String
    var district_description :String
    var district_status : String
    
    init(dataDict:[String:T]) {
        let districtid = dataDict["districtid"] as? String ?? ""
        let district_title = dataDict["district_title"] as? String ?? ""
        let state_id = dataDict["state_id"] as? String ?? ""
        let district_description = dataDict["district_description"] as? String ?? ""
        let district_status = dataDict["district_status"] as? String ?? ""
        
        self.districtid = districtid
        self.district_title = district_title
        self.state_id = state_id
        self.district_description = district_description
        self.district_status = district_status
        
    }
}
//-------------------------------------------------------------------------------------------------------------
//Mark :- Dealer Model
struct dealerModel<T> {
    var status:String
    var message:String
    var helpline:String
    var userListArr:[[String:T]]
    var dealerListingArr:[dealerTableData<T>]


    init(dict:[String:T]) {
        let status = dict["status"] as? String ?? ""
        let message = dict["message"] as? String ?? ""
        let helpline = dict["helpline"] as? String ?? ""
        let dataArr =  (dict["user_list"] as? [String:T] ?? [:])["all_users"] as? [[String:T]] ?? [[:]]
        self.status = status
        self.message = message
        self.helpline = helpline
        self.userListArr = dataArr
        
        var hArray = [dealerTableData<T>]()
               for obj in dataArr{
                let childListObj = dealerTableData(dataDict:obj)
                   hArray.append(childListObj)
               }
        self.dealerListingArr = hArray
}
}
struct dealerTableData<T>{
    var first_name:String
    var image:String
    var phone_no:String
    var district:String
    var state:String
    
    init(dataDict:[String:T]) {
        let first_name = dataDict["first_name"] as? String ?? ""
        let image = dataDict["image"] as? String ?? ""
        let phone_no = dataDict["phone_no"] as? String ?? ""
        let district = dataDict["district"] as? String ?? ""
        let state = dataDict["state"] as? String ?? ""

        
        self.first_name = first_name
        self.image = image
        self.phone_no = phone_no
        self.district = district
        self.state = state
    }
}
