//
//  HomeViewController.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 26.04.2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var labelTapToAddPhoto: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Furkan"
        return cell
    }
    
    
    @IBAction func buttonPostTapped(_ sender: Any) {
    }
    
}
