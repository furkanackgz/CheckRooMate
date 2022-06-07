//
//  ProfileViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 24.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSurname: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func logoutBttnTapped(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "UserID")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
        
        // Change Root View Controller back to Login Navigation Controller
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)

    }
    
    @IBAction func editProfileBttnTapped(_ sender: Any) {
        
    }
    
}
