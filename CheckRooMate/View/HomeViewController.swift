//
//  HomeViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 26.04.2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var labelAreYouLookingFor: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        labelAreYouLookingFor.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(toPostVC))
        //tap.cancelsTouchesInView = false
        labelAreYouLookingFor.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func toPostVC() {
        performSegue(withIdentifier: "toPostVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Furkan"
        return cell
    }
    
    
    @IBAction func buttonCameraTapped(_ sender: Any) {
        
    }
    
}
