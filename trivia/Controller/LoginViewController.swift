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
        
        persistedLogin()
        
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
    
    func persistedLogin () {
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
    }
    
}


