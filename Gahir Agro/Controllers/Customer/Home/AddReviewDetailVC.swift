//
//  AddReviewDetailVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 14/12/21.
//

import UIKit
import SDWebImage

protocol EditProfileProtocol {
    func editProfile(fromEdit:Bool)
}

class AddReviewDetailVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, ImagePickerDelegate,UITextViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var imgAttach: UIImageView!
    @IBOutlet weak var dwnView: UIView!
    @IBOutlet weak var btnPost: UIButton!
    @IBOutlet weak var btnAttach: UIButton!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var lblProductModel: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var txtReview: UITextView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
//    var imagePicker: ImagePicker!
//    var imagePickers = UIImagePickerController()
    var imagePicker : ImagePicker?
    var productId:String?
    var videoURL: NSURL?

    
    var selectedImage: UIImage? {
        didSet {
            if selectedImage != nil {
                mainImg.image = selectedImage
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        txtReview.delegate = self
//        reviewPostApi()
    }
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true
        )
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if btnAttach.isUserInteractionEnabled == true {
            dwnView.isHidden = true
            btnAttach.isHidden = true
            imgAttach.isHidden = true
            btnPost.layer.backgroundColor = #colorLiteral(red: 0.8294188976, green: 0.1833513379, blue: 0.04939796776, alpha: 1)
            btnPost.titleColor(for: .selected)
            btnPost.tintColor = #colorLiteral(red: 0.9175666571, green: 0.9176985621, blue: 0.9175377488, alpha: 1)
        }else {
            dwnView.isHidden = false
            btnAttach.isHidden = false
            imgAttach.isHidden = false
            btnPost.backgroundColor = #colorLiteral(red: 0.8294188976, green: 0.1833513379, blue: 0.04939796776, alpha: 1)
            btnPost.titleColor(for: .normal)
        }
    }
    func reviewPostApi(){
        DispatchQueue.main.async {
            PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        }
        let url = Constant.shared.baseUrl + Constant.shared.AddCustomerReview
        var deviceID = UserDefaults.standard.value(forKey: "device_token") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
        if deviceID == nil {
            deviceID = "777"
        }
        let param = ["access_token" : accessToken ,"message" : txtReview.text as Any , "product_id" : productId as Any, "image" :mainImg.image! ] as [String:AnyObject]
        print(param)
        PKWrapperClass.requestPOSTWithFormData(url, params: param, imageData: []) { [self](response) in
            print(response)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status =  response.data["status"] as? String ?? ""
            let msg = response.data["message"] as? String ?? ""
            if status == "1" {
                
                let vc = CustomerReviewVC.instantiate(fromAppStoryboard: .Customer)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } failure: {(error) in
            PKWrapperClass.svprogressHudDismiss(view: self)
            showAlertMessage(title: Constant.shared.appTitle, message: error.localizedDescription, okButton: "Ok", controller: self, okHandler: nil)
        }
    }
    

    
    @IBAction func btnPost(_ sender: UIButton) {
        let vc = CustomerReviewVC.instantiate(fromAppStoryboard: .Customer)
        reviewPostApi()
//        vc.postImage = mainImg.image
//        vc.postLabel = txtReview.text
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnAttachement(_ sender: UIButton) {
//
//        let vc = AddReviewVC.instantiate(fromAppStoryboard: .Customer)
//                vc.modalPresentationStyle = .overFullScreen
//        (sideMenuController?.rootViewController as! UINavigationController).present(vc, animated: true, completion: nil)
        imagePicker?.present(from: sender)

    }
    func didSelect(image: UIImage?) {
        self.mainImg.image = image

    }

    
}
