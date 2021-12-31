//
//  AddReviewVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 07/12/21.
//

import UIKit

class AddReviewVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var dataView: UIView!
    
    var imgPicker = UIImagePickerController()
    var centerFrame : CGRect!
    var pickImageCallback : ((UIImage) -> ())?;

    
    func presentPopUp()  {
        self.view.backgroundColor = .none
        dataView.frame = CGRect(x: centerFrame.origin.x, y: view.frame.size.height, width: centerFrame.width, height: centerFrame.height)
        dataView.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.90, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.dataView.frame = self.centerFrame
        }, completion: nil)
    }
    
    func dismissPopUp(_ dismissed:@escaping ()->())  {
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.90, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            
            self.dataView.frame = CGRect(x: self.centerFrame.origin.x, y: self.view.frame.size.height, width: self.centerFrame.width, height: self.centerFrame.height)
            
        },completion:{ (completion) in
            self.dismiss(animated: false, completion: {
            })
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imgPicker.delegate = self
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//    if let pickedImage = info[.originalImage] as? UIImage {
//        // imageViewPic.contentMode = .scaleToFill
//    }
//
//    picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage]
                as? UIImage else {
                    return
                }
        pickImageCallback?(image)
        picker.dismiss(animated: true, completion: nil)
        //    let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
}
    
    @IBAction func btnCancelGal(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)

    }

    @IBAction func btnPhoto(_ sender: UIButton) {
        self.openGallery()
    }
    
    @IBAction func btnCamera(_ sender: UIButton) {
//        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
//            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openCamera()
//            }))
    }
    func openCamera(){
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
            {
                imgPicker.sourceType = UIImagePickerController.SourceType.camera
                imgPicker.allowsEditing = true
                self.present(imgPicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    func openGallery(){
       if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.allowsEditing = true
           imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
           self.present(imagePicker, animated: true, completion: nil)
       }
       else
       {
           let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
   }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
        
    }
}
