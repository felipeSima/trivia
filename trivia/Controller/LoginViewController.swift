//
//  LoginViewController.swift
//  trivia
//
//  Created by Felipe Silva Lima on 4/2/19.
//  Copyright © 2019 Felipe Silva Lima. All rights reserved.
//

import UIKit
import Firebase

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
    }
    @IBAction func registerButtonPressed(_ sender: Any) {
    }
    
     // MARK: -API
    func loginUser(withEmail email : String, password : String){
        print("Login")
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
