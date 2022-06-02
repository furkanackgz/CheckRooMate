//
//  CommentTableViewCell.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 2.06.2022.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentContentLabel: UILabel!
    
    var comment: PostComment? = nil {
        didSet{
            // Calling setupUI elements to initialize UI elements
            setupUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}

extension CommentTableViewCell {
    
    // Setting up UI elements
    func setupUI() {
        if let comment = comment {
            
            // Setting username
            setUsername()
            
            // Setting the rest of fields using comment
            usernameLabel.text = "\(comment.userId!)"
            timeLabel.text = comment.commentTime
            commentContentLabel.text = comment.commentContent
        }
    }
    
    func setUsername() {
        WebService.run.getUsername(comment!.userId!, { usernameArray in
            if let usernameArray = usernameArray,
               let usernameObject = usernameArray.first,
               let username = usernameObject.username{
                DispatchQueue.main.async {
                    self.usernameLabel.text = username
                }
            }
        })
    }
}
