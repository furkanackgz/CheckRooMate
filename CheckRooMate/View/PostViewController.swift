//
//  PostViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 4.05.2022.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(doneBttnTapped))
        
    }
    
    @objc func doneBttnTapped() {
        navigationController?.popViewController(animated: true)
    }
}
