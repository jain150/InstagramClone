//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Arnav Jain on 3/20/17.
//  Copyright © 2017 Arnav Jain. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.barTintColor = UIColor(red:83/255, green: 127/255 , blue: 164/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutPressed(_ sender: Any) {
        
        PFUser.logOut()
        
        if PFUser.current() == nil {
            self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            print("Logged Out")
        }
        else {
            print("Logout Unsuccessful")
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
