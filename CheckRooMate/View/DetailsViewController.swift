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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func messageBttnTapped(_ sender: Any) {
    }
    @IBAction func shareCommentTapped(_ sender: Any) {
    }
    
}

