//
//  ProfileVC.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 28/01/1444 AH.
//

import UIKit
import NVActivityIndicatorView
class ProfileVC: UIViewController {
    var user: User!
    
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var gendelLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUpUI()
        loaderView.startAnimating()
        
        
        UserAPI.GetUserInfo(userid: user.id) { userResponse in
            self.user = userResponse
            self.SetUpUI() //to put new values
            self.loaderView.stopAnimating()
            
        }
       
    }
    
    func SetUpUI(){
        usernameLabel.text = user.firstName + " " + user.lastName
        
        if let image = user.picture{
        profileImageView.ConvertStringUrlToImage(stringUrl: image)
        }
        profileImageView.MakeCircleImage()
        gendelLabel.text = user.gender
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        if let location = user.location{
        countryLabel.text = location.country! + "," + location.city!
        }
    }
}
