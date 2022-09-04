//
//  SignUpVC.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 29/01/1444 AH.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)//tap any where to remove the keyboard
    }
    
    
    
    
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    

    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        UserAPI.SignUpNewUser(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email:emailTextField.text!)  { user, errorMassage in
            if errorMassage != nil{
                let alert = UIAlertController(title: "Error", message: errorMassage, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel)
                alert.addAction(okAction)
                self.present(alert, animated: true)
                
            }
            else{
                let alert = UIAlertController(title: "Success", message: "User Created Successfully", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel) { action in
                    self.dismiss(animated: true)
                    }
                    
                
                
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        }
    }
}
