//
//  DetailsViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 1.06.2022.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    var post: Post? = nil
    
    var baseUrl = "https://soyisibucket2.s3.eu-central-1.amazonaws.com/images/"
    var photosUrls = [String.SubSequence]()
    
    var postComments = [PostComment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assigning table view delegate to self
        tableView.dataSource = self
        
        // Assigning collection view delegate to self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = self.createBasicListLayout()
        
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
            
            // After post is received assign them to photosUrls
            photosUrls.append(contentsOf: post.images!.split(separator: " "))
            collectionView.reloadData()
            
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
    
}

// WebService methods
extension DetailsViewController {
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

// Table View Delegation methods
extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
        cell.comment = postComments[indexPath.row]
        return cell
    }
}

// Collection View Protocol methods
extension DetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as! DetailsCollectionViewCell
            
        cell.imageView.kf.setImage(with: URL(string: "\(baseUrl)\(photosUrls[indexPath.row])"))
        return cell
    }
    
    func createBasicListLayout() -> UICollectionViewLayout {
        let fraction: CGFloat = 1 / 2
        let inset: CGFloat = 2.5
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Horizontally Scrolling
        section.orthogonalScrollingBehavior = .continuous
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}
