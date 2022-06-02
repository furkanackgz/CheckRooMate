//
//  HomeViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 26.04.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var labelAreYouLookingFor: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View
        tableView.delegate = self
        tableView.dataSource = self
        
        // Adding Gesture to Label
        labelAreYouLookingFor.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(toPostVC))
        labelAreYouLookingFor.addGestureRecognizer(tap)
        
        // Fetching Posts using getAllPosts in WebService
        fetchPosts { posts in
            self.posts = posts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        exposeNavigationBar(animated)
    }
    
    
    @IBAction func buttonCameraTapped(_ sender: Any) {
        
    }
    
}

// UI accessors implementations
extension HomeViewController {
    /**
     Hides navigation bar before the view controller is presented.
     */
    func hideNavigationBar(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    /**
     Exposes navigation bar back after the view controller is dismissed.
     */
    func exposeNavigationBar(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func toPostVC() {
        performSegue(withIdentifier: "toPostVC", sender: nil)
    }
}

// Table View Protocol methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            
            // Sending post corresponding to the row at table.
            vc.post = posts![indexPath.row]
            // Navigating to DetailsVC
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let posts = posts else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell
        cell.post = posts[indexPath.row]
        return cell
    }
    
}

// Connecting to WebService
extension HomeViewController {
    
    func fetchPosts(_ completionHandler: @escaping ([Post]) -> ()) {
        WebService.run.getAllPosts { posts in
            guard let posts = posts else {
                return
            }
            completionHandler(posts)
        }
    }
    
}
