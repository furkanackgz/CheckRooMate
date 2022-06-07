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
    
    var profileID = UserDefaults.standard.integer(forKey: "UserID")
    var reviews: [UserReview] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // conforming to table view data source
        tableView.dataSource = self
        
        // Fetching user reviews
        fetchUserReviews()
        
        //Setting up UI elements
        setupUI()
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

extension ProfileViewController {
    
    func setupUI() {
        
    }
    
    func fetchUserReviews() {
        WebService.run.getUserReviews(reviewedId: profileID, { [unowned self] reviews in
            self.reviews = reviews
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserReviewTableViewCell") as! UserReviewTableViewCell
        cell.labelTime.text = reviews[indexPath.row].reviewTime
        cell.labelReviewContent.text = reviews[indexPath.row].reviewContent
        cell.userID = reviews[indexPath.row].reviewerId
        return cell
    }
}
