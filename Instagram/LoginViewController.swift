//
//  LoginViewController.swift
//  Instagram
//
//  Created by Arnav Jain on 3/19/17.
//  Copyright © 2017 Arnav Jain. All rights reserved.
//

import UIKit
import Parse

extension Error {
    var code: Int {
        return (self as NSError).code
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

class LoginViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.barTintColor = UIColor(red:83/255, green: 127/255 , blue: 164/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            
            if user != nil {
                print("You're logged in!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                print("Couldn't log in..")
            }
            
        }
    }
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            
            if success {
                print("Yay! User Created!")
            }
            else {
                print(error?.localizedDescription)
                
                //Error Code 202 (Username taken)
                if error?.code == 202 {
                    print("Username is taken!")
                }
            }
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
