//
//  LoginRegisterViewController.swift
//  FinalExam
//
//  Created by Акбала Тлеугалиева on 5/18/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class LoginRegisterViewController: UIViewController {
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var signUpbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        
    }
    func configureViews() {
        registerButton.layer.cornerRadius = 15.0
        signUpbutton.layer.cornerRadius = 15.0
        
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
