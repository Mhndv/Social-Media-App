//
//  ViewController.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 25/01/1444 AH.
//

import UIKit
import NVActivityIndicatorView
class PostVC: UIViewController{
    var posts:[Post] = []
    var pageNumber = 0
   var totalPosts = 0
    @IBOutlet weak var closeTagButtonAsOutlet: UIButton!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    var tag:String?
  
    @IBOutlet weak var loggedInOrOutButtonOutlet: UIButton!
    
    @IBOutlet weak var hiLabel: UILabel!
    
    @IBOutlet weak var LoaderView: NVActivityIndicatorView!
    @IBOutlet weak var postTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Notification for NEW POST ADDED
        NotificationCenter.default.addObserver(self, selector: #selector(newPostAdded), name: NSNotification.Name("NewPostAdded"), object: nil)
        
        
        
        closeTagButtonAsOutlet.isHidden = true
        
        if let user = UserManager.loggedInUser{
            hiLabel.text = "Hi, \(user.firstName)"
            loggedInOrOutButtonOutlet.setTitle("log Out", for: .normal) //make the button title log out cuz user is signed in
            loggedInOrOutButtonOutlet.tintColor = UIColor.red
            
        }else{
            hiLabel.isHidden = true
        }
        
        
        //Getting the Notification for User Stack View Tapped
        NotificationCenter.default.addObserver(self, selector: #selector(UserprofileTapped), name: NSNotification.Name("UserStackViewTapped"), object: nil)
        
        
        
        postTableView.delegate = self
        postTableView.dataSource = self
        
      
        
        if self.tag != nil{
          headerLabel.text = self.tag
          loggedInOrOutButtonOutlet.isHidden = true
          hiLabel.isHidden = true
          closeTagButtonAsOutlet.isHidden = false
            //hide them if there is tag
        }
        
      getAllPosts()
        
    }
    
    func getAllPosts(){
        LoaderView.startAnimating()
        PostAPI.GetAllPosts(page: pageNumber, tag: tag) { postrespons,total  in
            self.totalPosts = total
            self.posts.append(contentsOf: postrespons)//add the new post to the old posts
            self.postTableView.reloadData()
            self.LoaderView.stopAnimating()
            //here decreled what you want to do as the func is finished
        }
    }
    
    @objc func UserprofileTapped(notification : Notification){
        
        if let cell = notification.userInfo?["cell"] as? PostCell{
        if let indexPath = postTableView.indexPath(for: cell)//method for getting the cell index
            {
                  let post = posts[indexPath.row]//getting the exact cell
        
                 if let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC{
                     vc.user = post.owner
                     present(vc, animated: true)
                  }
             }
         }
    }
    
    
    @objc func newPostAdded(){
        
        self.posts = [] // to restart the posts to get the added one
        self.pageNumber = 0//restart the pages number
        getAllPosts()
        self.postTableView.reloadData()
    }
    
    
    @IBAction func closeButtonForTagClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue"{
            UserManager.loggedInUser = nil
        }// to make the logged in user nil when the segue is pressed
    }
    
    
}

extension PostVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
      
        
        let imageStringUrl = post.image
        if let userpic = post.owner.picture{
        
        cell.userImageView.ConvertStringUrlToImage(stringUrl: userpic)
        }
         
        cell.postImageView.ConvertStringUrlToImage(stringUrl:imageStringUrl )
        
        cell.postTextLabel.text = post.text
        
        cell.userImageView.MakeCircleImage() // to make the circle
        
        //filling the user data
        cell.usernameLabel.text = post.owner.firstName + " " + post.owner.lastName
        cell.likesnumberLabel.text = String(post.likes)
    
        if let tags = post.tags{
        cell.tags = tags
        }else{
            cell.tags = []
        }

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
        
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPost = posts[indexPath.row]
    
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PostDetailsVC") as? PostDetailsVC{
            vc.post = selectedPost
           present(vc, animated: true)
            
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //this func indicate the number of cell the user reach
        
        
        
        if(indexPath.row == posts.count - 1 && posts.count < totalPosts){//if its reached at the end of the posts
        
            pageNumber = pageNumber + 1
            getAllPosts()
        }
        
    }
    
    
}
