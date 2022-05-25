//
//  PostTableViewCell.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 25.05.2022.
//

import UIKit
import Kingfisher

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelPostContent: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            
            collectionView.collectionViewLayout = self.createBasicListLayout()
        }
    }
    @IBOutlet weak var labelCommentCount: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    
    var post: Post? {
        didSet{
            self.updateOutlets()
        }
    }
    
    var postComments = [PostComment]()
    
    var baseUrl = "https://soyisibucket.s3.eu-central-1.amazonaws.com/images/"
    var photosUrls = [String.SubSequence]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension PostTableViewCell {
    
    func updateOutlets() {
        
        if let post = post {
            // After username is set, assign it
            setUsernameToLabel(post)
            
            // After images of post is fetched assign them
            photosUrls.append(contentsOf: post.images!.split(separator: " "))
            
            labelPostContent.text = post.postContent
            labelTime.text = post.postTime
            
            // Fetch comments and assign its count to labelCommentCount
            fetchPostComments(post) { comments in
                if let comments = comments {
                    DispatchQueue.main.async {
                        self.labelCommentCount.text = "\(comments.count) comments"
                    }
                }
            }
        }
        
    }
    
    /**
     Fetch usernameArray which holds Username models
     by using WebService getUsername method. Take the first element
     of array and use its username field for assigning it to
     labelUsername.
     
     - parameter post: Specific post which is used to get userId in it.
     */
    func setUsernameToLabel(_ post: Post) {
        WebService.run.getUsername(post.userId!, { usernameArray in
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

// Collection View Protocol methods
extension PostTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagePostCell", for: indexPath) as? PostCollectionViewCell {
            cell.imageView.kf.setImage(with: URL(string: "\(baseUrl)\(photosUrls[indexPath.row])"))
            return cell
        }
        
        return PostCollectionViewCell()
    }
    
    func createBasicListLayout() -> UICollectionViewLayout {
        let fraction: CGFloat = 1 / 3
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

