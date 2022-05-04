//
//  SignUpViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 26.04.2022.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldSurname: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldUsername.delegate = self
        textFieldPassword.delegate = self
        textFieldName.delegate = self
        textFieldSurname.delegate = self
        textFieldEmail.delegate = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFieldUsername.resignFirstResponder()
        self.textFieldPassword.resignFirstResponder()
        self.textFieldName.resignFirstResponder()
        self.textFieldSurname.resignFirstResponder()
        self.textFieldEmail.resignFirstResponder()
        return true
    }
    
    @IBAction func buttonSignUpTapped(_ sender: Any) {
        
    }
    
}
