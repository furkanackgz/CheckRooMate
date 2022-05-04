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
        performSegue(withIdentifier: "toHomeVC", sender: nil)
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

