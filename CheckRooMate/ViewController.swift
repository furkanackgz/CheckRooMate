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
    }

    
    @IBAction func buttonSignInTapped(_ sender: Any) {
        
    }
    
    @IBAction func buttonDontHaveAnAccountTapped(_ sender: Any) {
        
    }
    
    
}

