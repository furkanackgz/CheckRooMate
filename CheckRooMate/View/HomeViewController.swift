//
//  HomeViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 26.04.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var labelAreYouLookingFor: UILabel! {
        didSet{
            labelAreYouLookingFor.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(toPostVC))
            labelAreYouLookingFor.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Furkan"
        return cell
    }
    
}
