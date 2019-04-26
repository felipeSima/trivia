//
//  RegisterViewController.swift
//  trivia
//
//  Created by Felipe Silva Lima on 4/2/19.
//  Copyright © 2019 Felipe Silva Lima. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    //MARK: - Pre linked IBOUTLET

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.layer.cornerRadius = 20
        registerButton.layer.borderWidth = 2
        registerButton.layer.borderColor = UIColor.black.cgColor
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - IBActions
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Alert", message: "Invalid Username/Password", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel) { (dismissAction) in
            print("Cancel Button pressed")
        }
        
        SVProgressHUD.show()
        
        //1. Metodo de Autenticacao
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            
            if let error = error {
                
                
                alertController.addAction(dismissAction)
                
                self.present(alertController,animated: true, completion: nil)
                
                print("Failed to sign up a user with the email", error.localizedDescription)
                
                SVProgressHUD.dismiss()
                
                return
                
            }
            guard let uid = result?.user.uid else {return}
            
            let values = ["email" : self.emailTextField.text , "username" : self.usernameTextField.text]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
                
                if let error = error {
                    
                    print("Failed to update database values with error", error.localizedDescription)
                    
                    return
                }
                    
                else {
                    
                    self.performSegue(withIdentifier: "goToGame", sender: self)
                    
                    print("Sucessfuly signed user up")
                    
                    SVProgressHUD.dismiss()
                }
            })
            
        }
    }
    
    
//    @IBAction func registerButton(_ sender: Any) {
//
//    //Alert Window Properties
//
//        let alertController = UIAlertController(title: "Alert", message: "Invalid Username/Password", preferredStyle: .alert)
//
//        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel) { (dismissAction) in
//            print("Cancel Button pressed")
//        }
//
//        SVProgressHUD.show()
//
//    //1. Metodo de Autenticacao
//
//        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
//
//            if let error = error {
//
//
//                alertController.addAction(dismissAction)
//
//                self.present(alertController,animated: true, completion: nil)
//
//                print("Failed to sign up a user with the email", error.localizedDescription)
//
//                SVProgressHUD.dismiss()
//
//                return
//
//            }
//            guard let uid = result?.user.uid else {return}
//
//            let values = ["email" : self.emailTextField.text , "username" : self.usernameTextField.text]
//
//            Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
//
//                if let error = error {
//
//                    print("Failed to update database values with error", error.localizedDescription)
//
//                    return
//                }
//
//                else {
//
//                    self.performSegue(withIdentifier: "goToGame", sender: self)
//
//                    print("Sucessfuly signed user up")
//
//                    SVProgressHUD.dismiss()
//                }
//            })
//
//        }
//
//    }
//


}
