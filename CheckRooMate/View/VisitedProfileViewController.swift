//
//  VisitedProfileViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 7.06.2022.
//

import UIKit

class VisitedProfileViewController: UIViewController {
    
    
    @IBOutlet weak var labelProfile: UILabel!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSurname: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var profileID: Int? {
        didSet{
            fetchUserReviews(profileID!)
        }
    }
    var reviews: [UserReview] = []
    var username: String? {
        didSet{
            setUserInformationsByUsername(username!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // conforming to table view data source
        tableView.dataSource = self
        
    }
    
    @IBAction func addBttnTapped(_ sender: Any) {
        
    }

}

extension VisitedProfileViewController {
    
    func fetchUserReviews(_ profileID: Int) {
        WebService.run.getUserReviews(reviewedId: profileID, { [unowned self] reviews in
            self.reviews = reviews
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
}

extension VisitedProfileViewController {
    
    func setUserInformationsByUsername(_ username: String) {
        
        WebService.run.getUserInformation(username: username) { [unowned self] userInformation in
            DispatchQueue.main.async {
                self.labelUsername.text = "  " + username
                self.labelName.text = "  " + (userInformation[0].name ?? "Name")
                self.labelSurname.text = "  " + (userInformation[0].surname ?? "Surname")
                self.labelEmail.text = "  " + (userInformation[0].email ?? "E-mail")
                self.labelPhone.text = "  " + (userInformation[0].phone ?? "Phone")
            }
        }
        
    }
    
}

// Table View Delegatin methods
extension VisitedProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitedUserReviewTableViewCell") as! VisitedUserReviewTableViewCell
        cell.labelTime.text = reviews[indexPath.row].reviewTime
        cell.labelReviewContent.text = reviews[indexPath.row].reviewContent
        cell.userID = reviews[indexPath.row].reviewerId
        return cell
    }
}


