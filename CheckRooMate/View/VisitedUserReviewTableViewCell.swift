//
//  VisitedUserReviewTableViewCell.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 7.06.2022.
//

import UIKit

class VisitedUserReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelReviewContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
