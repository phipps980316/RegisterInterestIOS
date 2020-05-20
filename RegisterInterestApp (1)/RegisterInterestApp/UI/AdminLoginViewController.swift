//
//  AdminLoginViewController.swift
//  RegisterInterestApp
//
//  Created by Jon Phipps on 28/01/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import UIKit

//Controller for the login view
class AdminLoginViewController: UIViewController {

    //Outlets to link UI elements to the controlling class
    @IBOutlet weak var passwordTextField: UITextField!
    
    //Valid password to allow access to the admin area
    let validPass: String = "abc123"
    
    //Constructor of the login view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dismisses Keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    //Function to decide if the application should perform the segue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //If the segue has the following identifier, check if the entered password is valid and allow the segue to take place if the password is correct. Otherwise dont allow the segue to take place and alert the user if the password is incorrect. If there is a segue with another identifier allow the segue to take place
        if identifier == "AdminLoginSegue" {
            if passwordTextField.text! == validPass {
                return true
            }
            else {
                let alert = UIAlertController(title: "Information", message: "Incorrect Password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return false
            }
        }
        else {
            return true
        }
    }
}
