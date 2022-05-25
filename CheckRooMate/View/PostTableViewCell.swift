//
//  PostTableViewCell.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 25.05.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelPostContent: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelCommentCount: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
