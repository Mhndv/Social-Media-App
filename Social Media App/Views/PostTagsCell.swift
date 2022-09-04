//
//  PostTagsCell.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 06/02/1444 AH.
//

import UIKit

class PostTagsCell: UICollectionViewCell {
    
  @IBOutlet weak var tagNameLabel: UILabel!

    
    @IBOutlet weak var frontViewForTagCell: UIView!{
        didSet{
            self.layer.cornerRadius = 7
        }
    }
    
    
}
