//
//  LoginViewController.swift
//  FinalExam
//
//  Created by Акбала Тлеугалиева on 5/18/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()

        // Do any additional setup after loading the view.
    }
    func configureViews() {
    signInButton.layer.cornerRadius = 15.0
    }
    

    @IBAction func showPassword(_ sender: Any) {
     passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry

    }
    @IBAction func SignInDidTapped(_ sender: Any)
    {
        if emailTextField.text?.isEmpty == true{
                         print("Invalid input")
                  errorLabel.text = "Invalid input"
                         return
                     }
                     if passwordTextField.text?.isEmpty == true{
                         print("Invalid input")
                      errorLabel.text = "Invalid input"
                         return
                     }
                     
                     SignIn(withEmail: emailTextField.text!, passwordTextField.text!)

    }
    func SignIn(withEmail email: String, _ password: String){
           Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
               if let error = error {
                   self.errorLabel.text = error.localizedDescription

                   print("Failed to sign in", error.localizedDescription)
                   return
               }
             self.startApp()

           }
       }
    func startApp() {
               let viewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
               viewcontroller?.modalPresentationStyle = .fullScreen
               self.present(viewcontroller!, animated: true, completion: nil)
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
