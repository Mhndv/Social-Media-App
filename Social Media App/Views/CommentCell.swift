//
//  CommentCell.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 26/01/1444 AH.
//

import UIKit

class CommentCell: UITableViewCell {


    @IBOutlet weak var commentuserLabel: UILabel!
    @IBOutlet weak var commentuserImage: UIImageView!
    @IBOutlet weak var commentMassageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
