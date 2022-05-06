//
//  PostViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 4.05.2022.
//

import UIKit
import PhotosUI

class PostViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    var selectedPhotos = [UIImage]()
    var previousPicker: PHPickerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = "Enter text"
        textView.textColor = UIColor.lightGray
        
        textView.delegate = self
        
        addDoneBttnToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(doneBttnTapped))
        
    }
    
    @objc func doneBttnTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter text"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func addDoneBttnToKeyboard() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBttn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hideKeyboard))
        
        toolBar.setItems([flexibleSpace,doneBttn], animated: true)
        
        self.textView.inputAccessoryView = toolBar
    }
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @IBAction func addImageBttnTapped(_ sender: Any) {
        showActionSheet()
    }
    
}
extension PostViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: "Choose Source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
    }
    
    func openPhotoLibrary() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.livePhotos, .images, .videos])
        configuration.preferredAssetRepresentationMode = .automatic
        configuration.selection = .ordered
        configuration.selectionLimit = 20
        
        let picker = PHPickerViewController(configuration: configuration)
        self.previousPicker = picker
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        self.selectedPhotos.removeAll(keepingCapacity: false)
        
        self.dismiss(animated: true, completion: nil)
        let itemProviders = results.map(\.itemProvider)
        for item in itemProviders {
            if item.canLoadObject(ofClass: UIImage.self) {
                item.loadObject(ofClass: UIImage.self) { (image, error) in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            //self.imageView.image = nil
                            //self.imageView.image = image
                            self.selectedPhotos.append(image)
                        }
                    }
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}
