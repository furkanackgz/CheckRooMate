//
//  ViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 25.04.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldUsername.delegate = self
        textFieldPassword.delegate = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }

    
    @IBAction func buttonSignInTapped(_ sender: Any) {
        
        guard let username = textFieldUsername.text,
              let password = textFieldPassword.text else {
            return
        }
        
        WebService.run.signInUser(username, password) { isLoginSuccessful in
            DispatchQueue.main.async {
                if let isLoginSuccessfulResult = isLoginSuccessful.isLoginSuccessful {
                    if isLoginSuccessfulResult {
                        self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                    }
                    else {
                        // show allert and looks like you dont have an account ask would you like to sign up
                    }
                    
                }
            }
        }
        
    }
    
    @IBAction func buttonDontHaveAnAccountTapped(_ sender: Any) {
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFieldUsername.resignFirstResponder()
        self.textFieldPassword.resignFirstResponder()
        return true
    }
    
}

