//
//  ViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 25.04.2022.
//

import UIKit

class SignInViewController: UIViewController {


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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                if let isLoginSuccessful = isLoginSuccessful,
                   let isSuccessful = isLoginSuccessful.isLoginSuccessful{
                    // Username and Password are valid
                    if isSuccessful{
                        if let loginResult = isLoginSuccessful.result {
                            // set username to UserDefaults to prevent showing login VC again
                            UserDefaults.standard.set(loginResult.userId!, forKey: "UserID")
                            self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                        }
                    } else {
                        // Show username or password is wrong please check again
                        self.displayAlertMessage("Username or Password is wrong!")
                    }
                }
            }
        }
        
    }
    
    @IBAction func buttonDontHaveAnAccountTapped(_ sender: Any) {
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFieldUsername.resignFirstResponder()
        self.textFieldPassword.resignFirstResponder()
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
}

