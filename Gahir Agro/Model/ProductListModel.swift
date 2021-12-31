//
//  ProductListModel.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 13/12/21.
//
struct ProductModel<T>{
    var status : String
    var message: String
    var allProductArr:[[String:T]]
    
    var productListingArr:[AllProductsTableData<T>]
    
    init(dict:[String:T]) {
        
        let status  = dict["status"] as? String ?? ""
        let message = dict["message"] as? String ?? ""
        let dataArr = (dict["product_list"] as? [String:T] ?? [:])["all_products"] as? [[String:T]] ?? [[:]]
        
        self.status = status
        self.message = message
        self.allProductArr = dataArr
        
        
        var hArray = [AllProductsTableData<T>]()
               for obj in dataArr{
                   let childListObj = AllProductsTableData(dataDict:obj)!
                   hArray.append(childListObj)
               }
               self.productListingArr = hArray
        
        }
    }
struct AllProductsTableData<T>{
    var id : String
    var prod_name : String
    var prod_model : String
    var prod_cat : String
    var prod_type : String
    var prod_image : String
    var prod_price : String
    var prod_sno : String
    var prod_desc : String
    var prod_qty : String
    var prod_video : String
    var prod_pdf : String
    var prod_acc : String
    var creation_date : String
    var disable : String
    var part_list : String
    var doc_list : String
    var op_manual :String

    
    init?(dataDict:[String:T]) {
        
        let id = dataDict["id"] as? String ?? ""
        let prod_name = dataDict["prod_name"] as? String ?? ""
        let prod_model = dataDict["prod_model"] as? String ?? ""
        let prod_cat = dataDict["prod_cat"] as? String ?? ""
        let prod_type = dataDict["prod_type"] as? String ?? ""
        let prod_image = dataDict["prod_image"] as? String ?? ""
        let prod_price = dataDict["prod_price"] as? String ?? ""
        let prod_sno = dataDict["prod_sno"] as? String ?? ""
        let prod_desc = dataDict["prod_desc"] as? String ?? ""
        let prod_qty = dataDict["prod_qty"] as? String ?? ""
        let prod_video = dataDict["prod_video"] as? String ?? ""
        let prod_pdf = dataDict["prod_pdf"] as? String ?? ""
        let prod_acc = dataDict["prod_acc"] as? String ?? ""
        let disable = dataDict["disable"] as? String ?? ""
        let creation_date = dataDict["creation_date"] as? String ?? ""
        let part_list = dataDict["part_list"] as? String ?? ""
        let doc_list = dataDict["doc_list"] as? String ?? ""
        let op_manual = dataDict["op_manual"] as? String ?? ""
        
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
        self.part_list = part_list
        self.doc_list = doc_list
        self.op_manual = op_manual
        }
}

//struct WarrantyModel<T> {
//    var status : String
//    var message : String
//    var accessTokn : String
//    var warrantyArr : [[String:T]]
//
//    var warrantyListingArr:[AllWarrantyTableData<T>]
//
//    init(dict:[String:T]) {
//
//        let status  = dict["status"] as? String ?? ""
//        let message = dict["message"] as? String ?? ""
//        let dataArr = (dict["product_list"] as? [String:T] ?? [:])["all_products"] as? [[String:T]] ?? [[:]]
//
//        self.status = status
//        self.message = message
//        self.warrantyArr = dataArr
//        self.accessTokn = accessTokn
//
//        var hArray = [AllWarrantyTableData<T>]()
//               for obj in dataArr{
//                   let childListObj = AllWarrantyTableData(dataDict:obj)!
//                   hArray.append(childListObj)
//               }
//               self.warrantyListingArr = hArray
//
//        }
//}
//
//struct AllWarrantyTableData<T>{
//    var id : String
//    var prod_name : String
//    var prod_model : String
//    var prod_cat : String
//    var prod_type : String
//    var prod_image : String
//    var prod_price : String
//    var prod_sno : String
//    var prod_desc : String
//    var prod_qty : String
//    var prod_video : String
//    var prod_pdf : String
//    var prod_acc : String
//    var creation_date : String
//    var disable : String
//    var accessories : String
//    var systems : String
//    var price : String
//    var part_list : String
//    var doc_list : String
//
//
//    init?(dataDict:[String:T]) {
//
//        let id = dataDict["id"] as? String ?? ""
//        let prod_name = dataDict["prod_name"] as? String ?? ""
//        let prod_model = dataDict["prod_model"] as? String ?? ""
//        let prod_cat = dataDict["prod_cat"] as? String ?? ""
//        let prod_type = dataDict["prod_type"] as? String ?? ""
//        let prod_image = dataDict["prod_image"] as? String ?? ""
//        let prod_price = dataDict["prod_price"] as? String ?? ""
//        let prod_sno = dataDict["prod_sno"] as? String ?? ""
//        let prod_desc = dataDict["prod_desc"] as? String ?? ""
//        let prod_qty = dataDict["prod_qty"] as? String ?? ""
//        let prod_video = dataDict["prod_video"] as? String ?? ""
//        let prod_pdf = dataDict["prod_pdf"] as? String ?? ""
//        let prod_acc = dataDict["prod_acc"] as? String ?? ""
//        let disable = dataDict["disable"] as? String ?? ""
//        let creation_date = dataDict["creation_date"] as? String ?? ""
//        let accessories = dataDict["accessories"] as? String ?? ""
//        let systems = dataDict["systems"] as? String ?? ""
//        let price = dataDict["price"] as? String ?? ""
//        let part_list = dataDict["part_list"] as? String ?? ""
//        let doc_list = dataDict["doc_list"] as? String ?? ""
//
//        self.id = id
//        self.prod_name = prod_name
//        self.prod_model = prod_model
//        self.prod_cat = prod_cat
//        self.prod_type = prod_type
//        self.prod_image = prod_image
//        self.prod_price = prod_price
//        self.prod_sno = prod_sno
//        self.prod_desc = prod_desc
//        self.prod_qty = prod_qty
//        self.prod_video = prod_video
//        self.prod_pdf = prod_pdf
//        self.prod_acc = prod_acc
//        self.creation_date = creation_date
//        self.disable = disable
//        self.part_list = part_list
//        self.doc_list = doc_list
//        self.accessories = accessories
//        self.systems = systems
//        self.price = price
//        }
//}

struct WarrantyProductModel<T> {
    var status : String
    var message : String
    var access_token : String
    var warranty : String

    var warrantyListingDict:WarrantyProductData<T>
    init(dict:[String:T]) {
        
        let status  = dict["status"] as? String ?? ""
        let message = dict["message"] as? String ?? ""
        let access_token = dict["access_token"] as? String ?? ""
        let dataDict = (dict["warranty"] as? [String:T] ?? [:])["product_detail"] as? [String:T] ?? [:]
        let warranty = (dict["warranty"] as? [String:T] ?? [:])["warranty"] as? String ?? ""
        let warrantyDict = WarrantyProductData(dataDict:dataDict)

        self.status = status
        self.message = message
        self.access_token = access_token
        self.warranty = warranty
        self.warrantyListingDict = warrantyDict!
         
        }
}

struct WarrantyProductData<T>{
    var id : String
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
    var accessories : [[String:T]]
    var systems : [[String:T]]
    var price : String
    var part_list : [T]
    var doc_list : [T]
    
    init?(dataDict:[String:T]) {
        
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
        let accessories = dataDict["accessories"] as? [[String : T]] ?? [[:]]
        let systems = dataDict["systems"] as? [[String : T]] ?? [[:]]
        let price = dataDict["price"] as? String ?? ""
        let part_list = dataDict["part_list"] as? [T] ?? []
        let doc_list = dataDict["doc_list"] as? [T] ?? []
        
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
        self.part_list = part_list
        self.doc_list = doc_list
        self.accessories = accessories
        self.systems = systems
        self.price = price
        }
}

//--------------------------------------------------------------
//MARK:- ReviewModel

struct ReviewModel<T>{
    var status : String
    var message: String
    var last_page :String
    var allReviewArr:[[String:T]]
    
    var reviewListingArr:[ReviewTableData<T>]
    
    init(dict:[String:T]) {
        
        let status  = dict["status"] as? String ?? ""
        let message = dict["message"] as? String ?? ""
        let last_page = (dict["review_list"] as? [String:T] ?? [:])["last_page"] as? String ?? ""
        let dataArr = (dict["review_list"] as? [String:T] ?? [:])["all_reviews"] as? [[String:T]] ?? [[:]]
        
        self.status = status
        self.message = message
        self.last_page = last_page
        self.allReviewArr = dataArr
        
        var hArray = [ReviewTableData<T>]()
               for obj in dataArr{
                   let childListObj = ReviewTableData(dataDict:obj)!
                   hArray.append(childListObj)
               }
               self.reviewListingArr = hArray
        }
    }
struct ReviewTableData<T>{
    var review_id : String
    var user_id : String
    var product_id : String
    var review_text : String
    var review_img : String
    var approval_status : String
    var creation_date : String
    var user_detail : UserDetailData<T>
    var product_detail : ProductDetailData<T>
  
    
    init?(dataDict:[String:T]) {
        
        let review_id = dataDict["review_id"] as? String ?? ""
        let user_id = dataDict["user_id"] as? String ?? ""
        let product_id = dataDict["product_id"] as? String ?? ""
        let review_text = dataDict["review_text"] as? String ?? ""
        let review_img = dataDict["review_img"] as? String ?? ""
        let approval_status = dataDict["approval_status"] as? String ?? ""
        let creation_date = dataDict["creation_date"] as? String ?? ""
        let user_detail = dataDict["user_detail"] as? [String:T] ?? [:]
        let product_detail = dataDict["product_detail"] as? [String:T] ?? [:]
      
        
        self.review_id = review_id
        self.user_id = user_id
        self.product_id = product_id
        self.review_text = review_text
        self.review_img = review_img
        self.approval_status = approval_status
        self.creation_date = creation_date
        self.user_detail = UserDetailData(dataDict: user_detail)!
        self.product_detail = ProductDetailData(dataDict: product_detail)!
       
        }
}

struct UserDetailData<T> {
       var id : String
       var first_name : String
       var last_name : String
       var username:String
       var firm_name : String
       var phone_no :String
       var image:String
       var role:String
       var password:String
       var auth_key :String
       var device_type :String
       var device_token: String
       var user_lat:String
       var app_signup:String
       var admin_signup :String
       var user_long :String
       var bio:String
       var dealer_code: String
       var serial_no : String
       var address :String
       var created_on : String
       var disable :String
                 
    init?(dataDict:[String:T]) {

        let id = dataDict["id"] as? String ?? ""
        let first_name = dataDict["first_name"] as? String ?? ""
        let last_name = dataDict["last_name"] as? String ?? ""
        let username = dataDict["username"] as? String ?? ""
        let firm_name = dataDict["firm_name"] as? String ?? ""
        let phone_no = dataDict["phone_no"] as? String ?? ""
        let image = dataDict["image"] as? String ?? ""
        let role = dataDict["role"] as? String ?? ""
        let password = dataDict["password"] as? String ?? ""
        let auth_key = dataDict["auth_key"] as? String ?? ""
        let device_type = dataDict["device_type"] as? String ?? ""
        let device_token = dataDict["device_token"] as? String ?? ""
        let user_lat = dataDict["user_lat"] as? String ?? ""
        let app_signup = dataDict["app_signup"] as? String ?? ""
        let admin_signup = dataDict["admin_signup"] as? String ?? ""
        let user_long = dataDict["user_long"] as? String ?? ""
        let bio = dataDict["bio"] as? String ?? ""
        let dealer_code = dataDict["dealer_code"] as? String ?? ""
        let serial_no = dataDict["serial_no"] as? String ?? ""
        let address = dataDict["address"] as? String ?? ""
        let created_on = dataDict["created_on"] as? String ?? ""
        let disable = dataDict["disable"] as? String ?? ""
        
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.username = username
        self.firm_name = firm_name
        self.phone_no = phone_no
        self.image = image
        self.role = role
        self.password = password
        self.auth_key = auth_key
        self.device_type = device_type
        self.device_token = device_token
        self.user_lat = user_lat
        self.app_signup = app_signup
        self.admin_signup = admin_signup
        self.user_long = user_long
        self.bio = bio
        self.dealer_code = dealer_code
        self.serial_no = serial_no
        self.address = address
        self.created_on = created_on
        self.disable = disable
}

}

struct ProductDetailData<T> {
       var id : String
       var prod_name : String
       var prod_model : String
       var prod_cat :String
       var prod_type : String
       var prod_image :String
       var prod_price:String
       var prod_sno:String
       var prod_desc:[T]
       var prod_qty :String
       var prod_video : [T]
       var prod_pdf: [T]
       var prod_acc:String
       var creation_date:String
       var disable :String
       var accessories :[[String:T]]
       var systems: [[String:T]]
       var price :String
       var part_list: [T]
       var doc_list : [T]
       
                 
    init?(dataDict:[String:T]) {

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
        let prod_video = dataDict["prod_video"] as? [T] ?? []
        let prod_pdf = dataDict["prod_pdf"] as? [T] ?? []
        let prod_acc = dataDict["prod_acc"] as? String ?? ""
        let creation_date = dataDict["creation_date"] as? String ?? ""
        let disable = dataDict["disable"] as? String ?? ""
        let accessories = dataDict["accessories"] as? [[String:T]] ?? [[:]]
        let systems = dataDict["systems"] as? [[String:T]] ?? [[:]]
        let price = dataDict["price"] as? String ?? ""

        let part_list = dataDict["part_list"] as? [T] ?? []
        let doc_list = dataDict["doc_list"] as? [T] ?? []
       
        
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
        self.accessories = accessories
        self.systems = systems
        self.part_list = part_list
        self.doc_list = doc_list
        self.price = price
      
    }
}

