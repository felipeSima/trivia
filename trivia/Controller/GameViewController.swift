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
    var bankQuestion = [Question]()
    
    //MARK : - VARIABLES
    
    var questionNumber: Int = 0
    
    var score: Int = 0
    
    let baseURL = "https://opentdb.com/api.php?amount=20&category=15&type=multiple"
    
    @IBOutlet weak var buttonOne: UIButton!
    
    @IBOutlet weak var buttonTwo: UIButton!
    
    @IBOutlet weak var buttonThree: UIButton!
    
    @IBOutlet weak var buttonFour: UIButton!
    
    @IBOutlet weak var questionTextField: UITextView!
    
    @IBOutlet weak var questionNumberTextField: UILabel!
    
    @IBOutlet weak var scoreTextField: UILabel!
    
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
            let allQuestions = Question()
            //Saving the question text, number "jsonIndex", to the question property array(of the class Question)
            allQuestions.question.append(data[jsonIndex]["question"].stringValue)

            //Saving the 3 incorrect answers in the answerArray Property(of the class Question)
            for answerIndex in 0..<data[jsonIndex]["incorrect_answers"].count {
                allQuestions.ansArray.append((data[jsonIndex]["incorrect_answers"][answerIndex].stringValue, false))
            }
            //Saving the correct answers in the last element of the answerArray Property(of the class Question)
            allQuestions.ansArray.append((data[jsonIndex]["correct_answer"].stringValue, true))
            
            //Shuffling the answerArray
            allQuestions.ansArray = allQuestions.ansArray.shuffled()
            
            //Appending to the bankQuestion(of Type: [Question]) as the "jsonIndex" element
            bankQuestion.append(allQuestions)

            print("")
            //Checking the answers
            print(bankQuestion[jsonIndex].question[0])
            for i in 0..<bankQuestion[jsonIndex].ansArray.count {
                print(bankQuestion[jsonIndex].ansArray[i])
            }
            
        }
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
        
        if bankQuestion[questionNumber].ansArray[index].value == true {
            print("right answer")
            score += 10
            questionNumber += 1
            updateUI()
        }
        else  {
            print("wrong answer")
            questionNumber += 1
            updateUI()
        }
    }
    
    func updateUI () {
        
        if questionNumber < bankQuestion.count{
            
            questionNumberTextField.text = "Question: \(questionNumber + 1)/\(bankQuestion.count)"
            scoreTextField.text = "Score: \(score)"
            questionTextField.text = bankQuestion[questionNumber].question[0]
            buttonOne.setTitle(bankQuestion[questionNumber].ansArray[0].text, for: .normal)
            buttonTwo.setTitle(bankQuestion[questionNumber].ansArray[1].text, for: .normal)
            buttonThree.setTitle(bankQuestion[questionNumber].ansArray[2].text, for: .normal)
            buttonFour.setTitle(bankQuestion[questionNumber].ansArray[3].text, for: .normal)
        }
            
        else {
            
            scoreTextField.text = "Score: \(score)"
            alertPopUp()
        }
        
    }
    
    func alertPopUp() {
        let alertController = UIAlertController.init(title: "Awesome!", message: "You Made it. Would you like to start over?", preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Play Again", style: .default) { (alertAction) in
            self.startOver()
        }
        let cancelAction = UIAlertAction.init(title: "I stop at my deyDay", style: .cancel) { (cancelAction) in
            print("EndGame")
        }
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)

    }
    
    func startOver() {
        questionNumber = 0
        bankQuestion = bankQuestion.shuffled()
        updateUI()
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
