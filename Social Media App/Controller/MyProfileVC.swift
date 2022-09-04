//
//  MyProfileVC.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 07/02/1444 AH.
//

import UIKit
import NVActivityIndicatorView

class MyProfileVC: UIViewController {

    
    // MARK: Outlets:
    
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var imageUrlTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)//tap any where to remove the keyboard
          setUpUI()
        
    }

    
    func setUpUI(){
        userImageView.MakeCircleImage()
        if let user = UserManager.loggedInUser{
            if let image = user.picture{
                userImageView.ConvertStringUrlToImage(stringUrl: image)
               
            }
            userNameLabel.text = user.firstName + " " + user.lastName
            firstNameTextField.text = user.firstName
            phoneNumberTextField.text = user.phone
            imageUrlTextField.text = user.picture
        }else{
            var alert = UIAlertController(title: "Error", message: "You have to be logged in", preferredStyle: UIAlertController.Style.alert)
            var action = UIAlertAction(title: "OK", style: .cancel) { action in
                self.tabBarController?.selectedIndex = 0
            }
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        guard let user = UserManager.loggedInUser else {return}
        loaderView.startAnimating()
        UserAPI.UpdateUser(userId: user.id, firstName: firstNameTextField.text!, phone: phoneNumberTextField.text!, image: imageUrlTextField.text!) { userupdated, message in
            //update for the new information
            self.loaderView.stopAnimating()
            if let responseUser = userupdated{
                if let image = userupdated?.picture{
                self.userImageView.ConvertStringUrlToImage(stringUrl: image)
                }
                self.userNameLabel.text = responseUser.firstName + " " + responseUser.lastName
                
                
            }
        }
    }
    
    
}
