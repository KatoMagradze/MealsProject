//
//  CreateAccountController.swift
//  MealsProject
//
//  Created by Kato on 7/12/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateAccountController: UIViewController {
    
    var userID: String?

    @IBOutlet weak var newEmailTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createAccountButton.layer.cornerRadius = 15
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        
        guard let newEmail = newEmailTextField.text, !newEmail.isEmpty,
            let newPassword = newPasswordTextField.text, !newPassword.isEmpty else {
                print("missing field data")
                return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: newEmail, password: newPassword, completion: { [weak self] result, error in
            
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                //show account creation
                print(error?.localizedDescription)
                return
            }
            
            self!.userID = result?.user.uid
            self?.performSegue(withIdentifier: "tab_bar_segue_2", sender: nil)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TabBarController
        vc.fireBaseUser = userID!
    }
}
