//
//  LoginViewController.swift
//  trivia
//
//  Created by Felipe Silva Lima on 4/2/19.
//  Copyright © 2019 Felipe Silva Lima. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func twitterButtonPressed(_ sender: Any) {
    }
    @IBAction func facebookButtonPressed(_ sender: Any) {
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Alert", message: "Invalid Username/Password", preferredStyle: .alert)

        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel) { (dismissAction) in
            print("Cancel Button pressed")
        }

        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (resut, error) in
            
            if let error = error {
                
                alertController.addAction(dismissAction)

                self.present(alertController, animated: true, completion: nil)
                
                print("There was an error to log the user in: ", error.localizedDescription)
                
                SVProgressHUD.dismiss()
                
                return
                
            }
            
            else {
                
                self.performSegue(withIdentifier: "goToGame", sender: self)
                
                SVProgressHUD.dismiss()
                
                print("login successful")
                
            }
            
        }
        
    }
    @IBAction func registerButtonPressed(_ sender: Any) {
    }
    
     // MARK: -API

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
