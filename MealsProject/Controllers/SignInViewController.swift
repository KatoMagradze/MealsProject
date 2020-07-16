//
//  SignInViewController.swift
//  MealsProject
//
//  Created by Kato on 7/12/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    var tasks = [Task]()
    var tasksLoaded = false

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    var userID: String?
    var useremail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInButton.layer.cornerRadius = 15
        createAccountButton.layer.cornerRadius = 15
        
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            
            if granted {
                print("granted")
                if !self.tasksLoaded {
                    DispatchQueue.main.async {
                        self.firstLoadViewData()
                    }
                }
            }
            else {
                print("not granted")
            }
        }
        

        center.getNotificationSettings { settings in
        guard (settings.authorizationStatus == .authorized) else { return }

            if settings.alertSetting == .enabled {
                if !self.tasksLoaded {
                    DispatchQueue.main.async {
                        self.firstLoadViewData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.permissionDeniedLetter()
                }
            }
        }
    }
    
    func permissionDeniedLetter() {
        let alert = UIAlertController(title: "Attention", message: "To get notifications from the app, please go to settings and turn the notifications on", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action) in
            self.openAppSettings()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func openAppSettings() {
        if let url = URL(string:UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    private func firstLoadViewData() {
        self.tasks.removeAll()
        let task1 = Task(title: "Check out our meal of the day!", hour: 09, minute: 00)
      
        self.tasks.append(task1)
        //self.tableView.reloadData()
        self.tasksLoaded = true
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "MealsApp"
        content.body = tasks[0].title
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = tasks[0].hour
        dateComponents.minute = tasks[0].minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let req = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(req)
    }

    @IBAction func signInTapped(_ sender: UIButton) {
        
        guard let email = usernameTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                print("missing field data")
                return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                //show account creation
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            
            self!.userID = result?.user.uid
            self!.useremail = result?.user.email
            self?.performSegue(withIdentifier: "tab_bar_segue", sender: nil)

        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TabBarController
        vc.fireBaseUser = userID!
        vc.userEmail = useremail!
    }
    
    func showCreateAccount(email: String, password: String) {
        
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in
            self.performSegue(withIdentifier: "create_account_segue", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
        }))
        
        present(alert, animated: true)

    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "create_account_vc")
        present(vc, animated: true, completion: nil)
    }
}

class Task {
    var title: String
    var hour: Int
    var minute: Int
    
    init(title: String, hour: Int, minute: Int) {
        self.title = title
        self.hour = hour
        self.minute = minute
    }
}
