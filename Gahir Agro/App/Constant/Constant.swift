//
//  Constant.swift
//  racinewalker
//
//  Created by Vivek Dharmani on 7/1/20.
//  Copyright © 2020 Vivek Dharmani. All rights reserved.
//

import Foundation

class Constant: NSObject {
    
    static let shared = Constant()
    let appTitle  = "Gahir Agro"
    
    //MARK:-> Dealer Flow Api's
    //MARK:OLD STAGING BASE URL
    //https://www.dharmani.com/gahir/api/
    //MARK:LATEST STAGING BASE URL
    //https://gahiragro.in/Staging/api/
    //MARK:LIVE BASE URL
    //https://gahiragro.in/api/
    
    let baseUrl = "https://gahiragro.in/Staging/api/"
    
    
    
    let VerifyDealer = "VerifyDealer.php"
    let VerifyCustomer = "VerifyCustomer.php"
    let PhoneLogin = "PhoneLogin.php"
    
    
    let SignUp = "DealerSignup.php"
    let SignIn = "EmailLogin.php"
    let ForgotPassword = "ForgotPassword.php"
    let AllProduct = "GetAllProducts.php"
    let ProductDetails = "GetProductDetail.php"
    let contactUS = "ContactUs.php"
    let EditProfile = "UpdateProfile.php"
    let FilterProducts = "FilterProduct.php"
    let SearchData = "SearchProduct.php"
    let ProfileApi = "GetUserProfile.php"
    let RecentSearches = "GetRecentSearch.php"
    let AddEnquiry = "AddEnquiry.php"
    let EnquiryListing = "GetAllEnquiries.php"
    let AllOrders = "GetAllOrders.php"
    let BookOrder = "AddOrder.php"
    let Notification = "GetAllNotifications.php"
    let ChangePassword = "ChangePassword.php"
    let UpdateLocation = "UpdateLocation.php"
    let EnquiryDetails = "GetEnquiryDetail.php"
    let OrderDetails = "GetOrderDetail.php"
    let PrivacyPolicy = "PrivacyPolicy.html"
    let Category = "GetAllCategories.php"
    let FilterdData = "FilterCategory.php"
    
    
    
    //MARK:-> Customer Flow Api's
    
    let CustomerLogin = "CustomerPhoneLogin.php"
    let CustomerSignUp = "VerifyCustomer.php"
    let CustomerNewSignUp = "CustomerSignup.php"
    
    let RegisterProduct = "RegisterProduct.php"
    let RegisterProductDetail = "GetRegisteredProducts.php"
    let CheckWarranty = "CheckWarranty.php"
    let CheckWarrantyProduct = "CheckWarrantyByProduct.php"
    let CustomerReview = "GetAllReviews.php"
    let AddCustomerReview = "AddCustomerReview.php"
    let GetRegisterProductDetail = "GetRegProductDetail.php"
    let GetAllStates = "GetAllStates.php"
    let SearchDealer = "SearchDealer.php"
    let ProductCheckFilter = "GetAllProducts.php"
    let FilterReview = "FilterReview.php"
    let AddCart = "AddToCart.php"
    let GetAllCartItems = "GetAllCartItems.php"
    let AddCustomerComplaint = "AddCustomerComplain.php"
    let GetAllCustomerComplain = "GetAllCustomerComplains.php"
    
    //MARK:-> Admin Flow Api's
    
    let AdminSignIn = "AdminLogin.php"
    let AllDealerEnquries = "GetDealerEnquiries.php"
    let AllDealerOrder = "GetDealerOrders.php"
    
}

class Singleton  {
   static let sharedInstance = Singleton()
    var currentAddress = [String: Any]()
    var lat = Double()
    var long = Double()
    var authToken = String()
    var isComingFromSubDetailsScreen =  false
    var lastSelectedIndex = 0

}

struct LocationData {
    var long : Double
    var lat : Double
    
    init(long : Double,lat : Double ) {
        self.lat = lat
        self.long = long
    }
}
