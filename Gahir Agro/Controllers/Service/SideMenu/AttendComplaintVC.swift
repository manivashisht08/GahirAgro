//
//  AttendComplaintVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 25/11/21.
//

import UIKit
import IQKeyboardManagerSwift
import SDWebImage
import Toucan

class AttendComplaintVC: UIViewController,UITextFieldDelegate, UITextViewDelegate, ImagePickerDelegate {
    
    @IBOutlet weak var checkUncheckBtn: UIButton!
    @IBOutlet weak var repairedCollection: UICollectionView!
    @IBOutlet weak var changedCollectionView: UICollectionView!
    @IBOutlet weak var txtHour: UITextField!
    @IBOutlet weak var viewHour: UIView!
    @IBOutlet weak var txtMachine: UITextField!
    @IBOutlet weak var viewMachine: UIView!
    @IBOutlet weak var txtLubrication: UITextField!
    @IBOutlet weak var viewLubrication: UIView!
    @IBOutlet weak var txtComplaint: UITextField!
    @IBOutlet weak var viewComplaint: UIView!
    @IBOutlet weak var viewSerial: UIView!
    @IBOutlet weak var txtSerialNumber: UITextField!
    @IBOutlet weak var txtProduct: UITextField!
    @IBOutlet weak var viewProduct: UIView!
    @IBOutlet weak var viewMobile: UIView!
    @IBOutlet weak var txtMobile: UITextField!
    
    var categoryArray : [String] = ["Not to Answer", "Lorem", "Ipsum","New"]
    
    
    //    var selectedOption: String? {
    //        didSet {
    //            self.txtComplaint = selectedOption
    //        }
    //    }
    var index = 0
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var agreeTerms = Bool()
    var selected = true
    var showImage = ["upload"]
    var photosInTheCellNow = [UIImage?]()
    var photosInTheCellRepaired = [UIImage?]()
    var checkPickerVal = Bool()
    
    var imagePickerVC: ImagePicker?
    var selectedImage: UIImage? {
        didSet {
            if selectedImage != nil {
                photosInTheCellNow.append(selectedImage)
                changedCollectionView.reloadData()
            }
        }
    }
    
    var selectImage : UIImage? {
        didSet{
            if selectImage != nil {
                repairedCollection.reloadData()
                photosInTheCellRepaired.append(selectImage)
                
            }
        }
    }
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        pickerview()
        
    }
    
    func setUp(){
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler?.delegate = self
        txtHour.delegate = self
        txtMachine.delegate = self
        txtComplaint.delegate = self
        txtLubrication.delegate = self
        txtProduct.delegate = self
        txtMobile.delegate = self
        txtSerialNumber.delegate = self
        txtHour.tintColor = .clear
        txtComplaint.tintColor = .clear
        txtLubrication.tintColor = .clear
        txtMachine.tintColor = .clear
        
        txtHour.resignFirstResponder()
        txtMachine.resignFirstResponder()
        txtComplaint.resignFirstResponder()
        txtLubrication.resignFirstResponder()
        txtProduct.resignFirstResponder()
        txtMobile.resignFirstResponder()
        txtSerialNumber.resignFirstResponder()
        
        imagePickerVC = ImagePicker(presentationController: self, delegate: self)
        
        changedCollectionView.delegate = self
        changedCollectionView.dataSource = self
        repairedCollection.delegate = self
        repairedCollection.dataSource = self
    }
    
    func validate()  {
        if txtMobile.text?.isEmpty == true {
            ValidateData(strMessage: "Please enter mobile number")
        }else if txtProduct.text?.isEmpty == true {
            ValidateData(strMessage: "Please enter product")
        }else if txtSerialNumber.text?.isEmpty == true {
            ValidateData(strMessage: "Please enter serial number")
        }else if txtComplaint.text?.isEmpty == true {
            ValidateData(strMessage: "Please select complaint type")
        }else if txtLubrication.text?.isEmpty == true {
            ValidateData(strMessage: "Please select lubrication condition")
        }else if txtMachine.text?.isEmpty == true {
            ValidateData(strMessage: "Please select machine running condition")
        }else if txtHour.text?.isEmpty == true {
            ValidateData(strMessage: "Please select hour")
        }else{}
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMachineChecked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.agreeTerms = sender.isSelected
        self.checkUncheckBtn.setImage(agreeTerms == true ? #imageLiteral(resourceName: "ch") : #imageLiteral(resourceName: "btnblank"), for: .normal)
    }
    
    @IBAction func btnRepairedCncl(_ sender: UIButton) {
    }
    
    @IBAction func btnRepaired(_ sender: UIButton) {
    }
    
    @IBAction func btnPartChngedCncl(_ sender: UIButton) {
        
    }
    @IBAction func btnPartChnged(_ sender: UIButton) {
    }
    
    @IBAction func btnApproval(_ sender: UIButton) {
        let vc = VerificationVC.instantiate(fromAppStoryboard: .Service)
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        sideMenuController?.hideLeftViewAnimated()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if IQKeyboardManager.shared.canGoNext {
            IQKeyboardManager.shared.goNext()
        } else {
            self.view.endEditing(true)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txtMobile {
            viewMobile.borderColor = #colorLiteral(red: 0.8638699651, green: 0.1734898686, blue: 0.112617828, alpha: 1)
        } else if textField == txtProduct {
            viewProduct.borderColor = #colorLiteral(red: 0.8638699651, green: 0.1734898686, blue: 0.112617828, alpha: 1)
        }else if textField == txtSerialNumber{
            viewSerial.borderColor = #colorLiteral(red: 0.8638699651, green: 0.1734898686, blue: 0.112617828, alpha: 1)
        }else if textField == txtComplaint {
            viewComplaint.borderColor = #colorLiteral(red: 0.8638699651, green: 0.1734898686, blue: 0.112617828, alpha: 1)
        }else if textField == txtLubrication {
            viewLubrication.borderColor = #colorLiteral(red: 0.8638699651, green: 0.1734898686, blue: 0.112617828, alpha: 1)
        }else if textField == txtMachine {
            viewMachine.borderColor = #colorLiteral(red: 0.8638699651, green: 0.1734898686, blue: 0.112617828, alpha: 1)
        }else if textField == txtHour {
            viewHour.borderColor = #colorLiteral(red: 0.8638699651, green: 0.1734898686, blue: 0.112617828, alpha: 1)
        }else{}
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtMobile {
            viewMobile.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else if textField == txtProduct {
            viewProduct.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else if textField == txtSerialNumber{
            viewSerial.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else if textField == txtComplaint {
            viewComplaint.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else if textField == txtLubrication {
            viewLubrication.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else if textField == txtMachine {
            viewMachine.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else if textField == txtHour {
            viewHour.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else{}
    }
    
    func didSelect(image: UIImage?) {
        if let imageData = image?.jpegData(compressionQuality: 0), let compressImage = UIImage(data: imageData) {
            
            if (changedCollectionView != nil) == true {
                
                if checkPickerVal == true {
                    self.selectedImage = Toucan.init(image: compressImage).resizeByCropping(CGSize.init(width: 400, height: 400)).maskWithRoundedRect(cornerRadius: 200.0, borderWidth: 4.0 , borderColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).image
                    //                    self.selectImage = Toucan.init(image: compressImage).resizeByCropping(CGSize.init(width: 400, height: 400)).maskWithRoundedRect(cornerRadius: 200.0, borderWidth: 4.0 , borderColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).image
                    //                    profileImg.image = selectedImages
                    
                }else{
                    self.selectedImage = Toucan.init(image: compressImage).image
                    //                    self.selectImage = Toucan.init(image: compressImage).image
                }
            }else {
                if checkPickerVal == false {
                    self.selectImage = Toucan.init(image: compressImage).resizeByCropping(CGSize.init(width: 400, height: 400)).maskWithRoundedRect(cornerRadius: 200.0, borderWidth: 4.0 , borderColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).image
                    //                    self.selectImage = Toucan.init(image: compressImage).resizeByCropping(CGSize.init(width: 400, height: 400)).maskWithRoundedRect(cornerRadius: 200.0, borderWidth: 4.0 , borderColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).image
                    //                    profileImg.image = selectedImages
                    
                }else{
                    self.selectImage = Toucan.init(image: compressImage).image
                    //                    self.selectImage = Toucan.init(image: compressImage).image
                }
                
            }
            
        }
    }
    
}

extension AttendComplaintVC : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == changedCollectionView {
            if photosInTheCellNow.count == 0{
                return showImage.count
            }else{
                return photosInTheCellNow.count+1
            }
        }else {
            if photosInTheCellRepaired.count == 0{
                return showImage.count
            }else{
                return photosInTheCellRepaired.count+1
                print("KKKKKK")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == changedCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attendComplaintCell", for: indexPath) as! attendComplaintCell
            if indexPath.row == 0 {
                cell.uploadImg.image = UIImage(named: showImage[indexPath.row])
            }else {
                cell.uploadImg.image = photosInTheCellNow[indexPath.row - 1]
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "repairedCell", for: indexPath) as! repairedCell
            if indexPath.row == 0 {
                cell.repairedImg.image = UIImage(named: showImage[indexPath.row])
            }else {
                cell.repairedImg.image = photosInTheCellRepaired[indexPath.row - 1]
            }
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == changedCollectionView {
            if photosInTheCellNow.count >= 5 {
                ValidateData(strMessage: "You can add maximum of 5 images.")
            }else {
                checkPickerVal = false
                self.imagePickerVC?.present(from: view)
            }
        }else {
            if photosInTheCellRepaired.count >= 5 {
                ValidateData(strMessage: "You can add maximum of 5 images.")
            }else {
                checkPickerVal = false
                self.imagePickerVC?.present(from: view)
            }
            
        }
    }
}
extension AttendComplaintVC:UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return categoryArray.count
        if txtComplaint.isFirstResponder {
            return categoryArray.count
        }else if txtLubrication.isFirstResponder {
            return categoryArray.count
        }else if txtMachine.isFirstResponder {
            return categoryArray.count
        }else if txtHour.isFirstResponder{
            return categoryArray.count
        }
        return Int()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if txtComplaint.isFirstResponder {
            return categoryArray[row]
        }else if txtLubrication.isFirstResponder {
            return categoryArray[row]
        }else if txtMachine.isFirstResponder {
            return categoryArray[row]
        }else if txtHour.isFirstResponder{
            return categoryArray[row]
        }
        return nil
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if txtComplaint.isFirstResponder {
            let itemSelected = categoryArray[row]
            txtComplaint.text = itemSelected
            self.view.endEditing(false)
        }else  if txtLubrication.isFirstResponder {
            let itemSelected = categoryArray[row]
            txtLubrication.text = itemSelected
            self.view.endEditing(false)

        }else  if txtMachine.isFirstResponder {
            let itemSelected = categoryArray[row]
            txtMachine.text = itemSelected
            self.view.endEditing(false)

        }else  if txtHour.isFirstResponder {
            let itemSelected = categoryArray[row]
            txtHour.text = itemSelected
            self.view.endEditing(false)

        }
    }
}
extension AttendComplaintVC{
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
        txtComplaint.inputView = picker
        txtHour.inputView = picker
        txtMachine.inputView = picker
        txtLubrication.inputView = picker
        
        txtComplaint.inputAccessoryView = toolBar
        txtHour.inputAccessoryView = toolBar
        txtMachine.inputAccessoryView = toolBar
        txtLubrication.inputAccessoryView = toolBar
    }
    
    @objc func onDoneButtonTapped(sender:UIButton) {
        let row = picker.selectedRow(inComponent: 0)
        pickerView(picker, didSelectRow: row, inComponent:0)

        
        if (txtComplaint.text == nil) == true {
        txtComplaint.text = categoryArray[row]
        }else if  (txtLubrication.text == "") == true {
        txtLubrication.text = categoryArray[row]
        } else if (txtMachine.text == "" ) == true {
        txtMachine.text = categoryArray[row]
        }else if (txtHour.text == "") == true {
        txtHour.text = categoryArray[row]
        }else{}
        

        
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        self.view.endEditing(true)
    }
}
