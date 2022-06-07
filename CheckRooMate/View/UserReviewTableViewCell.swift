//
//  UserReviewTableViewCell.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 7.06.2022.
//

import UIKit

class UserReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelReviewContent: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    
    var userID: Int? {
        didSet{
            setUsernameToLabel(userID!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UserReviewTableViewCell {
    
    /**
     Fetch usernameArray which holds Username models
     by using WebService getUsername method. Take the first element
     of array and use its username field for assigning it to
     labelUsername.
     
     - parameter post: Specific post which is used to get userId in it.
     */
    func setUsernameToLabel(_ userId: Int) {
        WebService.run.getUsername(userId, { usernameArray in
            if let usernameArray = usernameArray,
               let usernameObject = usernameArray.first,
               let username = usernameObject.username{
                DispatchQueue.main.async {
                    self.labelUsername.text = username
                }
            }
        })
    }
}
