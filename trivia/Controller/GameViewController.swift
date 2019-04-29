//
//  GameViewController.swift
//  trivia
//
//  Created by Felipe Silva Lima on 4/2/19.
//  Copyright © 2019 Felipe Silva Lima. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import SwiftyJSON
import SVProgressHUD

class GameViewController: UIViewController {
    
    //MARK: - INSTANCES INICIALIZATION
    
    let allQuestions = Question()
    var bankQuestion = [Question]()
    
    //MARK : - VARIABLES
    
    let baseURL = "https://opentdb.com/api.php?amount=20&category=15&type=multiple"
    
    @IBOutlet weak var buttonOne: UIButton!
    
    @IBOutlet weak var buttonTwo: UIButton!
    
    @IBOutlet weak var buttonThree: UIButton!
    
    @IBOutlet weak var buttonFour: UIButton!
    
    @IBOutlet weak var questionTextField: UITextView!
    
    
    //MARK : - PRE CONFIGURATION
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSetup(button: buttonOne)
        
        buttonSetup(button: buttonTwo)
        
        buttonSetup(button: buttonThree)
        
        buttonSetup(button: buttonFour)

        getQuestionsData(with: baseURL)
        
    }
    
    
    //MARK : - Networking
    func getQuestionsData (with url : String) {
        Alamofire.request(url, method: .get).responseString { (response) in
            if response.result.isSuccess {
                
                //Encoding Result valeu of type string for use as JSON
                let encodedString = Data(response.result.value!.utf8)
                
                do {
                    //Decoding the Result as a JSON for easy use, as said in the documentation of Swift 4.1
                    let finalJSON = try JSON(data: encodedString)
                    self.updateJson(json: finalJSON)
                    
                } catch {return}

            }
            else {
                print("There was an error attempting to get data: \(String(describing: response.result.error))")
            }
        }
    }
    
    
    //MARK : - JSON Parsing
    
    func updateJson(json: JSON) {
        //Saving the reference for the Json Array of Questions&Answers
        let data = json["results"]
        
        //Looping over the 20 questions&answers of the JsonData
        for jsonIndex in 0..<data.count {
            
            //Saving the question text, number "jsonIndex", to the question property array(of the class Question)
            allQuestions.question.append(data[jsonIndex]["question"].stringValue)
            
            //Saving the 3 incorrect answers in the answerArray Property(of the class Question)
            for answerIndex in 0..<data[jsonIndex]["incorrect_answers"].count {
                allQuestions.answerArray.append((data[jsonIndex]["incorrect_answers"][answerIndex], false))
            }
            //Saving the correct answers in the last element of the answerArray Property(of the class Question)
            allQuestions.answerArray.append((data[jsonIndex]["correct_answer"], true))
            
            //Appending to the bankQuestion(of Type: [Question]) as the "jsonIndex" element
            bankQuestion.append(allQuestions)
            
            //removing the answers to be rewriten by new questions
            //allQuestions.answerArray.removeAll()
            
            print(bankQuestion[jsonIndex].answerArray.count)

        }
        
        
//        print("")
//        print(bankQuestion[0].question[0])
//        print("BankQuestion: \(bankQuestion[0].answerArray[0].text.stringValue)")
//        print("BankQuestion: \(bankQuestion[0].answerArray[1].text.stringValue)")
//        print("BankQuestion: \(bankQuestion[0].answerArray[2].text.stringValue)")
//        print("BankQuestion: \(bankQuestion[0].answerArray[3].text.stringValue)")
//        print("")
//        print("")
//        print(bankQuestion[1].question[1])
//        print("BankQuestion: \(bankQuestion[1].answerArray[4].text.stringValue)")
//        print("BankQuestion: \(bankQuestion[1].answerArray[5].text.stringValue)")
//        print("BankQuestion: \(bankQuestion[1].answerArray[6].text.stringValue)")
//        print("BankQuestion: \(bankQuestion[1].answerArray[7].text.stringValue)")
//        print("")
        updateUI()
     
    }
    
    
    func buttonSetup(button: UIButton) {
        
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            checkAnswer(index: 0)
        }
        else if sender.tag == 2 {
           checkAnswer(index: 1)
        }
        else if sender.tag == 3 {
            checkAnswer(index: 2)
        }
        else if sender.tag == 4 {
           checkAnswer(index: 3)
        }
    }
    
    func checkAnswer(index: Int) {
        
        if bankQuestion[0].answerArray[index].value == true {
            updateUI()
            print("right answer")
        }
        else  {
            print("wrong answer")
            updateUI()
        }
    }
    
    func updateUI () {
        questionTextField.text = bankQuestion[0].question[0]
        buttonOne.setTitle(bankQuestion[0].answerArray[0].text.stringValue, for: .normal)
        buttonTwo.setTitle(bankQuestion[0].answerArray[1].text.stringValue, for: .normal)
        buttonThree.setTitle(bankQuestion[0].answerArray[2].text.stringValue, for: .normal)
        buttonFour.setTitle(bankQuestion[0].answerArray[3].text.stringValue, for: .normal)
    }
    
    
    // MARK : - LogOut Session
    
    @IBAction func logOutPressed(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print("There was an error while attempting to LogOut: \(error)")
        }
    }
    
}
