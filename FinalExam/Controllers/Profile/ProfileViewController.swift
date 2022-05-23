//
//  ProfileViewController.swift
//  FinalExam
//
//  Created by Акбала Тлеугалиева on 5/23/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import UIKit

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
         loadUserData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        do {
                   try Auth.auth().signOut()
                   UserDefaults.standard.set(false, forKey: "ISUSERLOGGED")
                    let viewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "LoginRegisterViewController")
                             viewcontroller?.modalPresentationStyle = .fullScreen
                             self.present(viewcontroller!, animated: true, completion: nil)
               }catch let error {
                   print("Failed to  signout", error)
               }
    }
    
    func loadUserData(){
           guard let uid = Auth.auth().currentUser?.uid else {
               return
           }
           
           Database.database().reference().child("users").child(uid).child("username").observeSingleEvent(of: .value){
               (snapshot) in
               guard let username = snapshot.value as? String else {
                   return
               }
               self.usernameLabel.text = username
           }
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
