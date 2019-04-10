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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - IBActions
    
    @IBAction func registerButton(_ sender: Any) {
        
        SVProgressHUD.show()
        
    //1. Metodo de Autenticacao
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            
            if let error = error {
                
                print("Failed to sign up a user with the email", error.localizedDescription)
                
                return
                
            }
            guard let uid = result?.user.uid else {return}
            
            let values = ["email" : self.emailTextField.text , "username" : self.usernameTextField.text]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
                
                if let error = error {
                    
                    print("Failed to update database values with error", error.localizedDescription)
                    
                    return
                }
                
                print("Sucessfuly signed user up")
                
                SVProgressHUD.dismiss()
                
            })
           
        }
        
    }
    
    
    //MARK: - API
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
