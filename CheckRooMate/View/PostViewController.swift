//
//  PostViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 4.05.2022.
//

import UIKit

class PostViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    
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
}
