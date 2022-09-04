//
//  SignInVC.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 01/02/1444 AH.
//

import UIKit
import Spring

class SignInVC: UIViewController {

    
    @IBOutlet weak var signInLabel: SpringLabel!
    
    @IBOutlet weak var signUpButton: SpringButton!
   
    @IBOutlet weak var guestButton: SpringButton!
   
    @IBOutlet weak var signInButton: SpringButton!
    
    @IBOutlet weak var lastNameTextField: SpringTextField!
    
    @IBOutlet weak var firstNameTextField: SpringTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)//tap any where to remove the keyboard.
        
        animateIn()
        
        
    }
    
    func animateIn(){
        //animation from spring
        firstNameTextField.animation = "squeezeDown"
        firstNameTextField.delay = 0.5
        firstNameTextField.duration = 1
        firstNameTextField.animate()
        lastNameTextField.animate()
        
        lastNameTextField.animation = "squeezeDown"
        lastNameTextField.delay = 0.9
        lastNameTextField.duration = 1
        lastNameTextField.animate()
        signInButton.animation = "squeezeDown"
        signInButton.delay = 1.2
        signInButton.duration = 1
        signInButton.animate()
        
        signUpButton.animation = "fadeInUp"
        signUpButton.delay = 1.2
        signUpButton.duration = 1
        signUpButton.animate()
        
        guestButton.animation = "fadeInUp"
        guestButton.delay = 1.2
        guestButton.duration = 1
        guestButton.animate()
        
        signInLabel.animation = "fadeInRight"
        signInLabel.delay = 2
        signInLabel.duration = 1
        signInLabel.animate()
      
        
       
    }
    
    
    func animateOut(user:User?){
        //animation from spring
        firstNameTextField.animation = "squeezeDown"
        firstNameTextField.delay = 0.2
        firstNameTextField.duration = 1
        firstNameTextField.animateTo()
      
        
        lastNameTextField.animation = "squeezeDown"
        lastNameTextField.delay = 0.4
        lastNameTextField.duration = 1
        lastNameTextField.animateTo()
        
        signInButton.animation = "squeezeDown"
        signInButton.delay = 0.6
        signInButton.duration = 1
        signInButton.animateTo()
        
        signUpButton.animation = "fadeInUp"
        signUpButton.delay = 0.6
        signUpButton.duration = 1
        signUpButton.animateTo()
        
        guestButton.animation = "fadeInUp"
        guestButton.delay = 0.6
        guestButton.duration = 1
        guestButton.animateTo()
        
        signInLabel.animation = "fadeInRight"
        signInLabel.delay = 1
        signInLabel.duration = 1
        signInLabel.animateToNext { // when the animation finshed it will go to the next page
            if let loggedUser = user{
              
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") {
                    UserManager.loggedInUser = loggedUser //put the user who logged in
                    self.present(vc, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    
   
    

    @IBAction func SignInButtonClicked(_ sender: Any) {
        
        UserAPI.SignInUser(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!) { user, errorMessage in
            if let message = errorMessage{
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }else{
                self.animateOut(user: user)
            
            }
        }
    }
    

}
