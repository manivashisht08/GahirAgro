////
////  ImagePicker.swift
////  Nodat
////
////  Created by Vivek Dharmani on 09/12/20.
////  Copyright © 2020 Apple. All rights reserved.
////
//
//import Foundation
//
//import UIKit
//
//public protocol ImagePickerDelegate: class {
//    func didSelect(image: UIImage?)
//}
//
//open class ImagePicker: NSObject {
//
//    private let pickerController: UIImagePickerController
//    private weak var presentationController: UIViewController?
//    private weak var delegate: ImagePickerDelegate?
//
//
//    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
//        self.pickerController = UIImagePickerController()
//
//        super.init()
//
//        self.presentationController = presentationController
//        self.delegate = delegate
//
//        self.pickerController.delegate = self
//        self.pickerController.allowsEditing = true
//        self.pickerController.mediaTypes = ["public.image"]
//    }
//
//    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
//        guard UIImagePickerController.isSourceTypeAvailable(type) else {
//            return nil
//        }
//
//        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
//            self.pickerController.sourceType = type
//            self.presentationController?.present(self.pickerController, animated: true)
//        }
//    }
//
//    public func present(from sourceView: UIView) {
//
//        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//
//        if let action = self.action(for: .camera, title: "Take photo") {
//            alertController.addAction(action)
//        }
//        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
//            alertController.addAction(action)
//        }
//        if let action = self.action(for: .photoLibrary, title: "Photo library") {
//            alertController.addAction(action)
//        }
//
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            alertController.popoverPresentationController?.sourceView = sourceView
//            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
//            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
//        }
//
//        self.presentationController?.present(alertController, animated: true)
//    }
//
//    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
//        controller.dismiss(animated: true, completion: nil)
//
//        self.delegate?.didSelect(image: image)
//    }
//}
//
////extension ImagePicker: UIImagePickerControllerDelegate {
////
////    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
////        self.pickerController(picker, didSelect: nil)
////    }
////
////    public func imagePickerController(_ picker: UIImagePickerController,
////                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
////        guard let image = info[.editedImage] as? UIImage else {
////            return self.pickerController(picker, didSelect: nil)
////        }
////        guard let imgData3 = image.jpegData(compressionQuality: 0.2) else {return}
////        var base64String = String()
////        base64String = imgData3.base64EncodedString(options: .lineLength64Characters)
////        UserDefaults.standard.set(base64String, forKey: "imag")
////        self.pickerController(picker, didSelect: image)
////    }
////}
//
//
//
//extension ImagePicker: UINavigationControllerDelegate {
//
//}
import Foundation
import UIKit
import AVKit
import MobileCoreServices

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
//    func didSetvideo(video : NSURL?)
}

open class ImagePicker: NSObject {
    var video : NSURL?
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
//        self.pickerController.mediaTypes = [video! as? NSURL, UIImage as? String]
//        self.pickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image","public.movie"]
    }
  
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func present(from sourceView: UIView) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
//        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
//            alertController.addAction(action)
//        }
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true) {
            self.delegate?.didSelect(image: image)
        }
    }
    
}

extension ImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let video = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerReferenceURL")] as? NSURL
        do{
            let asset = AVURLAsset(url: video as! URL , options: nil)
                   let imgGenerator = AVAssetImageGenerator(asset: asset)
                   imgGenerator.appliesPreferredTrackTransform = true
                print("Mismatched type: \(video)")
             }
        
        if let image =  info[.editedImage] as? UIImage{
            self.pickerController(picker, didSelect: image)
            return
        }else if let image = info[.originalImage] as? UIImage{
            self.pickerController(picker, didSelect: image)
            return
        }else{
            self.pickerController(picker, didSelect: nil)
        }
       
    }
}

extension ImagePicker: UINavigationControllerDelegate {
    
}
