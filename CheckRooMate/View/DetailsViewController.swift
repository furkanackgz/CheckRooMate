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
    
    var postComments = [PostComment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Conforming to table view delegate.
        tableView.dataSource = self
        
        // Calling setupUI method to initialize UI elements.
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
            // Setting username by using userId.
            setUsername()
            
            // Setting rest of the proporties with post.
            postTextView.text = post.postContent
            
            // Fetch comments and assign them to postComments.
            fetchPostComments(post) { [unowned self] comments in
                if let comments = comments {
                    self.postComments = comments
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
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
    
    /**
     Fetch comments through WebService getPostComments method and
     then assign them to postComments array in addition to returning
     back with Completion Handler object.
     
     - parameter post: Specific post which is used to get postId in it.
     */
    func fetchPostComments(_ post: Post,
                           _ completionHandler: @escaping ([PostComment]?)->(Void) ){
        
        WebService.run.getPostComments(post.postId!) { comments in
            if let comments = comments {
                self.postComments = comments
                completionHandler(comments)
            }
        }
    }
}

extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = postComments[indexPath.row].commentContent
        return cell
    }
}
