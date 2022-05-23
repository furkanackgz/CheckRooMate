//
//  SignUpViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 26.04.2022.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var textFieldUsername: UITextField! {
        didSet{
            textFieldUsername.delegate = self
        }
    }
    @IBOutlet weak var textFieldPassword: UITextField! {
        didSet{
            textFieldPassword.delegate = self
        }
    }
    @IBOutlet weak var textFieldPasswordAgain: UITextField! {
        didSet{
            textFieldPasswordAgain.delegate = self
        }
    }
    @IBOutlet weak var textFieldName: UITextField! {
        didSet{
            textFieldName.delegate = self
        }
    }
    @IBOutlet weak var textFieldSurname: UITextField! {
        didSet{
            textFieldSurname.delegate = self
        }
    }
    @IBOutlet weak var textFieldEmail: UITextField! {
        didSet{
            textFieldEmail.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @IBAction func buttonSignUpTapped(_ sender: Any) {
        
        guard let username = textFieldUsername.text, let password = textFieldPassword.text,
              let passwordAgain = textFieldPasswordAgain.text, let name = textFieldName.text,
              let surname = textFieldSurname.text, let email = textFieldEmail.text else {
                return
        }
        
        if username.isEmpty || password.isEmpty || passwordAgain.isEmpty ||
           name.isEmpty || surname.isEmpty || email.isEmpty {
            displayAlertMessage("You need to fill all the fields!")
            return
        }
        
        if password != passwordAgain {
            displayAlertMessage("Passwords are not matched!")
            return
        }
        
        let userRegistrationRequest = UserRegistrationRequest(username: username,
                                    password: password, name: name, surname: surname, email: email)
        
        WebService.run.signUpUser(userRegistrationRequest) { response in
            if response == nil {
                self.displayAlertMessageWithHandler("Successfully registered user!")
            } else {
                self.displayAlertMessage("Duplicate user info!")
            }
        }
        
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldUsername.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        textFieldPasswordAgain.resignFirstResponder()
        textFieldName.resignFirstResponder()
        textFieldSurname.resignFirstResponder()
        textFieldEmail.resignFirstResponder()
        return true
    }
    
    func displayAlertMessage(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertButton)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func displayAlertMessageWithHandler(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "Ok", style: .default) { UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(alertButton)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
