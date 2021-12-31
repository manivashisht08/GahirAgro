//
//  VerificationVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 23/11/21.
//

import UIKit

class VerificationVC: UIViewController,UITextViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var txtFourth: UITextField!
    @IBOutlet weak var txtThird: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var txtFirst: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    func configureUI(){
        txtFirst.delegate = self
        txtSecond.delegate = self
        txtThird.delegate = self
        txtFourth.delegate = self
        
        txtFirst.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtSecond.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtThird.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtFourth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
    }
    
    @objc private func textFieldDidChange(textField: UITextField){
            let text = textField.text
            if  text?.count == 1 {
                switch textField{
                case txtFirst:
                    txtSecond.becomeFirstResponder()
                case txtSecond:
                    txtThird.becomeFirstResponder()
                case txtThird:
                    txtFourth.becomeFirstResponder()
                case txtFourth:
                    txtFourth.resignFirstResponder()
                default:
                    break
                }
            }
            if  text?.count == 0 {
                switch textField{
                case txtFirst:
                    txtFirst.becomeFirstResponder()
                case txtSecond:
                    txtFirst.becomeFirstResponder()
                case txtThird:
                    txtSecond.becomeFirstResponder()
                case txtFourth:
                    txtThird.becomeFirstResponder()
                default:
                    break
                }
            }
            else{

            }
        }
    

    @IBAction func menuBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        let vc = SelfieVC.instantiate(fromAppStoryboard: .Service)
        (sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        sideMenuController?.hideLeftViewAnimated()
    }
    
}
