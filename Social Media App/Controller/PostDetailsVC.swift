//
//  PostDetailsVC.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 26/01/1444 AH.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
class PostDetailsVC: UIViewController {
    var post:Post!
    
    var comments:[Comment] = []
    //OUTLETS:
    
    @IBOutlet weak var sendCommentButtonAsOutlet: UIButton!
    
    @IBOutlet weak var commentTextField: UITextField!
   
    @IBOutlet weak var Loaderview: NVActivityIndicatorView!
    
    @IBOutlet weak var commentsTableView: UITableView!
   
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
   
    @IBOutlet weak var postTextLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserManager.loggedInUser == nil{
            commentTextField.isHidden = true
            sendCommentButtonAsOutlet.isHidden = true
        }else{
            commentTextField.isHidden = false
            sendCommentButtonAsOutlet.isHidden = false
        }
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        usernameLabel.text = post.owner.firstName + " " + post.owner.lastName
        likesLabel.text = String(post.likes)
        postTextLabel.text = post.text
        let imageStringUrl = post.image
        postImageView.ConvertStringUrlToImage(stringUrl: imageStringUrl)
        if let userpic = post.owner.picture
        {
        userImageView.ConvertStringUrlToImage(stringUrl: userpic)
        }
        userImageView.MakeCircleImage() // making the imgae circle
        
        Loaderview.startAnimating()
        //Getting the comments
        
       getPostComments()//getting all the comment

        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)//tap any where to remove the keyboard
    }
    
    func getPostComments(){
        PostAPI.GetPostComments(postid: post.id) { commentrespone in
            self.comments = commentrespone
            self.commentsTableView.reloadData()
            self.Loaderview.stopAnimating()
        }
    }
    
    @IBAction func GoBackButton(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    @IBAction func SendCommentClicked(_ sender: Any) {
        let message = commentTextField.text!
        
        if let user = UserManager.loggedInUser{
            
        PostAPI.AddNewComment(postId: post.id, userId: user.id, message: message) {
            self.Loaderview.startAnimating()
            self.getPostComments()
            self.commentTextField.text = ""
        }
    }
        
  }
    
    
}

extension PostDetailsVC: UITableViewDelegate,UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        let currentcomment = comments[indexPath.row]
        cell.commentMassageLabel.text = currentcomment.message
        cell.commentuserLabel.text = currentcomment.owner.firstName + " " + currentcomment.owner.lastName
        
        if let commentimageStringUrl = currentcomment.owner.picture
        {
        cell.commentuserImage.ConvertStringUrlToImage(stringUrl: commentimageStringUrl)
        
        }
        cell.commentuserImage.MakeCircleImage()
       
        
        
        
        return cell
    }
    
    
    
    
}
