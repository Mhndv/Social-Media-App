//
//  AddNewPostVC.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 06/02/1444 AH.
//

import UIKit

class AddNewPostVC: UIViewController {

    @IBOutlet weak var postImageTextField: UITextField!
    @IBOutlet weak var posttextTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func AddNewPostButtonClicked(_ sender: Any) {
        
        if let user = UserManager.loggedInUser{
            PostAPI.AddNewPost(text: posttextTextField.text!, userId: user.id) {
                NotificationCenter.default.post(name: NSNotification.Name("NewPostAdded"), object: nil, userInfo: nil)
                self.tabBarController?.selectedIndex = 0
                self.posttextTextField.text = ""
                self.postImageTextField.text = ""
            }
        }else{
            var alert = UIAlertController(title: "Error", message: "You have to be logged in to add new post", preferredStyle: UIAlertController.Style.alert)
            var action = UIAlertAction(title: "OK", style: .cancel) { action in
                self.tabBarController?.selectedIndex = 0
            }
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
}
