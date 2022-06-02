//
//  DetailsViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 1.06.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    var post: Post? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calling setupUI method to initialize UI elements
        setupUI()
    }
    
    @IBAction func messageBttnTapped(_ sender: Any) {
    }
    @IBAction func shareCommentTapped(_ sender: Any) {
    }
    
}

extension DetailsViewController {
    
    func setupUI() {
        if let post = post {
            // Setting username by using userId
            setUsername()
            
            // Setting rest of the proporties with post
            postTextView.text = post.postContent
        }
    }
    
    func setUsername() {
        WebService.run.getUsername(post!.userId!, { usernameArray in
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
