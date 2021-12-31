//
//  ComplaintVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 06/12/21.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire
import SDWebImage

class ComplaintVC: UIViewController,UITextViewDelegate, UITextFieldDelegate,UIImagePickerControllerDelegate,ImagePickerDelegate,UINavigationControllerDelegate {
   
    
    @IBOutlet weak var txtPhoto: UITextField!
    @IBOutlet weak var txtComplaint: UITextView!
    @IBOutlet weak var btnBrkdown: UIButton!
    @IBOutlet weak var btnMachine: UIButton!
    @IBOutlet weak var txtSerial: UITextField!
    @IBOutlet weak var txtProduct: UITextField!
    @IBOutlet weak var txtContact: UITextField!
    var categoryArray : [String] = ["Not to Answer", "Lorem", "Ipsum","New"]
    var imagePicker : ImagePicker?
    var imgArr = [Data]()
    var complaintSno:String?
    var complaintName:String?
    var complaintId:String?
    var complaintReason:String?
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    
    
    var selectedImage: String? {
        didSet {
            if selectedImage != nil {
                txtPhoto.text = selectedImage
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        pickerview()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    
    func didSelect(image: UIImage?) {
        let compressedData = (image?.jpegData(compressionQuality: 0.2))!!
        self.imgArr.append(compressedData)
    }
    
    func setUp(){
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler?.delegate = self
        txtProduct.delegate = self
        txtContact.delegate = self
        txtSerial.delegate = self

        txtSerial.resignFirstResponder()
        txtContact.resignFirstResponder()
        txtProduct.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if IQKeyboardManager.shared.canGoNext {
            IQKeyboardManager.shared.goNext()
        } else {
            self.view.endEditing(true)
        }
        return true
    }
    
    @IBAction func btnnBrkdown(_ sender: UIButton) {
        if (sender.isSelected == true)
           {
            sender.setBackgroundImage(UIImage(named: "boxxx"), for: .normal)
            complaintReason = "Breakdown in Machine"
            sender.isSelected = false
           }
           else
           {
            sender.setBackgroundImage(UIImage(named: "bx"), for: .normal)
            complaintReason = ""
            sender.isSelected = true
           }
    }
    @IBAction func btnnMachine(_ sender: UIButton) {
        if (sender.isSelected == true)
           {
            sender.setBackgroundImage(UIImage(named: "boxxx"), for: .normal)
            complaintReason = "Machine not working properly"

            sender.isSelected = false
           }
           else
           {
            sender.setBackgroundImage(UIImage(named: "bx"), for: .normal)
            complaintReason = ""
            sender.isSelected = true
           }
    }
    
    @IBAction func btnAudio(_ sender: UIButton) {
       
        
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        complainApi()

       
        
    }
    @IBAction func btnCamera(_ sender: UIButton) {
        imagePicker?.present(from: sender)

    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func complainApi(){
        DispatchQueue.main.async {
            PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        }
        let url = Constant.shared.baseUrl + Constant.shared.AddCustomerComplaint
        var deviceID = UserDefaults.standard.value(forKey: "device_token") as? String
        var access_token = UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""

        if deviceID == nil {
            deviceID = "777"
        }
        let param = ["contact_no" :txtContact.text! , "product_id" : complaintId ?? "" ,"sr_no" : txtSerial.text! , "comp_reason" : complaintReason ?? "", "reason_detail" :txtComplaint.text!,"access_token":access_token]
        print(param)
        requestWith(endUrl: url, parameters: param as [AnyHashable : Any])
    }
    func requestWith(endUrl: String, parameters: [AnyHashable : Any]){
            
            let url = endUrl // your API url /
        
            //        let headers: HTTPHeaders = [
            //            .authorization(bearerToken: authToken)]
            let headers : HTTPHeaders = ["Content-Type":"application/json"]
            //        let headers: HTTPHeaders = [
            //            / "Authorization": "your_access_token",  in case you need authorization header /
            //            "Content-type": "multipart/form-data",
            //            "Authorization": "Bearer " + authToken,
            //        ]
            DispatchQueue.main.async {
                
                PKWrapperClass.svprogressHudDismiss(view: self)
            }
            
            AF.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as! String)
                }
                
                for i in 0..<self.imgArr.count{
                    let imageData1 = self.imgArr[i]
                    debugPrint("mime type is\(imageData1.mimeType)")
                    let ranStr = String.random(length: 7)
                    //mp3 audio check
                    if imageData1.mimeType == "application/pdf" ||
                        imageData1.mimeType == "application/vnd" ||
                        imageData1.mimeType == "text/plain"{
                        multipartFormData.append(imageData1, withName: "support_audio[\(i + 1)]" , fileName: ranStr + String(i + 1) + ".pdf", mimeType: imageData1.mimeType)
                    }
                    else if imageData1.mimeType == "image/jpeg" || imageData1.mimeType == "image/png"{
                        multipartFormData.append(imageData1, withName: "support_img" , fileName: ranStr + String(i + 1) + ".jpg", mimeType: imageData1.mimeType)
                    }
                }
                
            }, to: url, usingThreshold: UInt64.init(), method: .post, headers: headers, interceptor: nil, fileManager: .default)
            
            .uploadProgress(closure: { (progress) in
                Swift.print("Upload Progress: \(progress.fractionCompleted)")
                
            })
            .responseJSON { (response) in
                DispatchQueue.main.async {
                    
                    PKWrapperClass.svprogressHudDismiss(view: self)
                }
                
                print("Succesfully uploaded\(response)")
                let respDict =  response.value as? [String : AnyObject] ?? [:]
                if respDict.count != 0{
//                    let signUpStepData =  ForgotPasswordData(dict: respDict)
                    if respDict["status"] as? String ?? "" == "1"{
                        showAlertMessage(title:"GahirAgro", message:respDict["message"] as? String ?? "", okButton: "OK", controller: self) {
                            let vc = ComplaintsDetailAudioVC.instantiate(fromAppStoryboard: .Customer)
                            (self.sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
                        }
                    }else{
                        
                    }
                }else{
                    
                }
            }
     
        }
    
}
extension ComplaintVC : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //        return categoryArray.count
        if txtProduct.isFirstResponder {
            return categoryArray.count
        }else{}
        return Int()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if txtProduct.isFirstResponder {
            return categoryArray[row]
        }else {}
        return nil
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if txtProduct.isFirstResponder {
            let itemSelected = categoryArray[row]
            txtProduct.text = itemSelected
            self.view.endEditing(false)
        }else {}
    }
}



extension ComplaintVC{
    func pickerview(){
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.reloadAllComponents()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(title: "Done", style:.plain, target: self, action: #selector(onDoneButtonTapped))
        doneBtn.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton,doneBtn], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtProduct.inputView = picker
        txtProduct.tintColor = .clear
        txtProduct.inputAccessoryView = toolBar
    
    }
    
    @objc func onDoneButtonTapped(sender:UIButton) {
        let row = picker.selectedRow(inComponent: 0)
        pickerView(picker, didSelectRow: row, inComponent:0)
        
        
        if (txtProduct.text == nil) == true {
            txtProduct.text = categoryArray[row]
        } else{}
        
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        self.view.endEditing(true)
    }
}
