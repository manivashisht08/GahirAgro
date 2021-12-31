//
//  SearchDealerVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 07/12/21.
//

import UIKit
import IQKeyboardManagerSwift

class SearchDealerVC: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    @IBOutlet weak var txtDistrict: UITextField!
    @IBOutlet weak var txtState: UITextField!
    
    var searchArr = [SearchTableData<AnyHashable>]()
    var districtCount = Int()
    var categoryArray : [String] = ["Not to Answer", "Lorem", "Ipsum","New"]
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        pickerview()
        searchDealerApi()
    }
    
    func searchDealerApi(){
        DispatchQueue.main.async {
            PKWrapperClass.svprogressHudShow(title: Constant.shared.appTitle, view: self)
        }
        let url = Constant.shared.baseUrl + Constant.shared.GetAllStates
        var deviceID = UserDefaults.standard.value(forKey: "device_token") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
        print(accessToken)
        if deviceID == nil {
            deviceID = "777"
        }
        PKWrapperClass.requestGETURL(url) {[self] (response) in
            let searchResp = searchModel(dict: response as? [String:AnyHashable] ?? [:])
            print(response)
            PKWrapperClass.svprogressHudDismiss(view: self)
            let status = searchResp.status
            let message = searchResp.message
            if status == "1" {
                self.searchArr = searchResp.searchListingArr
              
//                self.districtArr = searchResp.
        }
//
        } failure: { (error) in
            print(error)
            PKWrapperClass.svprogressHudDismiss(view: self)
            showAlertMessage(title: Constant.shared.appTitle, message: error as? String ?? "", okButton: "Ok", controller: self, okHandler: nil)
        }

    }
    
    func setUp(){
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler?.delegate = self
        txtState.delegate = self
        txtDistrict.delegate = self
        
        txtState.resignFirstResponder()
        txtDistrict.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if IQKeyboardManager.shared.canGoNext {
            IQKeyboardManager.shared.goNext()
        } else {
            self.view.endEditing(true)
        }
        return true
    }
    
    
    @IBAction func btnMenu(_ sender: UIButton) {
        sideMenuController?.showLeftViewAnimated()
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        let vc = DealerVC.instantiate(fromAppStoryboard: .Customer)
        vc.SearchState = txtState.text
        vc.searchDistt = txtDistrict.text
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
    }
    
}

extension SearchDealerVC : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //        return categoryArray.count
        if txtState.isFirstResponder {
            return searchArr.count
        }else if txtDistrict.isFirstResponder {
            return searchArr[districtCount].all_districts.count
        }
        return Int()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if txtState.isFirstResponder {
            return searchArr[row].state_title
        }else if txtDistrict.isFirstResponder {
            return searchArr[districtCount].all_districts[row].district_title
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if txtState.isFirstResponder {
            let itemSelected = searchArr[row].state_title
            districtCount = row
            txtState.text = itemSelected
            self.view.endEditing(false)
        }else  if txtDistrict.isFirstResponder {
            let itemSelected = searchArr[districtCount].all_districts[row].district_title
            txtDistrict.text = itemSelected
            self.view.endEditing(false)
            
        }
    }
}

extension SearchDealerVC{
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
        txtState.inputView = picker
        txtDistrict.inputView = picker
        txtState.tintColor = .clear
        txtDistrict.tintColor = .clear
        txtState.inputAccessoryView = toolBar
        txtDistrict.inputAccessoryView = toolBar
    
    }
    
    @objc func onDoneButtonTapped(sender:UIButton) {
        let row = picker.selectedRow(inComponent: 0)
        pickerView(picker, didSelectRow: row, inComponent:0)
        if (txtState.text == nil) == true {
            txtState.text = searchArr[row].state_title
        }else if  (txtDistrict.text == "") == true {
            txtDistrict.text = searchArr[row].all_districts[row].district_title
        } else{}
        
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        self.view.endEditing(true)
    }
}

