//
//  PostCell.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 25/01/1444 AH.
//

import UIKit

class PostCell: UITableViewCell {

    var tags:[String] = []
    
    
    @IBOutlet weak var userStackView: UIStackView!{
        didSet{//use when the item is ready
          
            //the logic for bulding gestures for stack view when tapping the userstackview it will do an action
            userStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UserSVTapped)))
            //the action userstvtapped will be called after the tapping the user stack view happened
        }
    }
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!{
        didSet{
            tagsCollectionView.delegate = self
            tagsCollectionView.dataSource = self
        }
        
    }
   
    @IBOutlet weak var userImageView: UIImageView!
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var postImageView: UIImageView!
    
    
    @IBOutlet weak var postTextLabel: UILabel!
    
    @IBOutlet weak var likesnumberLabel: UILabel!
    
    @IBOutlet weak var backView: UIView!{
        didSet{
            //to make the shadow for the view
            backView.layer.shadowColor = UIColor.gray.cgColor
            backView.layer.shadowOpacity = 0.4  //تتحكم ب شفافيه الظل
            backView.layer.shadowOffset = CGSize(width: 5, height: 0)//انزياح الظل
            backView.layer.shadowRadius = 3 //مقدار توزع الظل
            
            backView.layer.cornerRadius = 7 // عشان اخلي الزوايا دائريه 
       
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
                                               
                                               
@objc func UserSVTapped(){
    NotificationCenter.default.post(name: NSNotification.Name("UserStackViewTapped"), object: nil, userInfo: ["cell":self])
      //The user info is the self which is the object of stackview to know the cell index for getting the info 
      
       
        
             }
}


extension PostCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostTagsCell", for: indexPath) as! PostTagsCell
        
        cell.tagNameLabel.text = tags[indexPath.row]
        return cell
    }
    
    
}
