//
//  ViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 25.04.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }

    
    @IBAction func buttonSignInTapped(_ sender: Any) {
        
    }
    
    @IBAction func buttonDontHaveAnAccountTapped(_ sender: Any) {
        
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFieldEmail.resignFirstResponder()
        self.textFieldPassword.resignFirstResponder()
        return true
    }
    
}

