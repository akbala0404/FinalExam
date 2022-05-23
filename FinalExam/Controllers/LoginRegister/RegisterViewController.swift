//
//  RegisterViewController.swift
//  FinalExam
//
//  Created by Акбала Тлеугалиева on 5/18/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()

        // Do any additional setup after loading the view.
    }
    func configureViews() {
        signUpButton.layer.cornerRadius = 15.0
    }
    
    @IBAction func SignUPDidTapped(_ sender: UIButton) {
        if emailTextField.text?.isEmpty == true{
                   errorLabel.text = "Invalid input"
                   print("Invalid input")
                   return
               }
               if passwordTextField.text?.isEmpty == true{
                   errorLabel.text = "Invalid input"
                   print("Invalid input")
                   return
               }
               if usernameTextField.text?.isEmpty == true{
                   errorLabel.text = "Invalid input"
                   print("Invalid input")
                   return
               }
               SingUp(withEmail: emailTextField.text!, passwordTextField.text!, usernameTextField.text! )
    }
    func SingUp(withEmail email: String, _ password: String, _ username: String){
           Auth.auth().createUser(withEmail : email , password: password) { (result,error ) in
               if let error = error {
                   self.errorLabel.text = "Invalid input, \(error.localizedDescription)"

                   print("Failed to sign ip", error.localizedDescription)
                   return
               }
               guard let uid = result?.user.uid else {
                   return
               }
               let values = ["email": email, "username": username]

            
               Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock:{(error, ref) in
                   if let error = error {
                       self.errorLabel.text = "Invalid input, \(error.localizedDescription)"

                       print("Failed to update database", error.localizedDescription)
                       return
                   }
                UserDefaults.standard.set(true, forKey: "ISUSERLOGGED")
                self.startApp()
               })
               
               
           }
           
       }
    @IBAction func showPassword(_ sender: Any) {
         passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
         confirmPasswordTextField.isSecureTextEntry = !confirmPasswordTextField.isSecureTextEntry
    }
    
    func startApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                          let vc = storyboard.instantiateViewController(identifier: "TabBarViewController")
                          vc.modalPresentationStyle = .overFullScreen
                   self.present(vc, animated: true, completion: nil)
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
