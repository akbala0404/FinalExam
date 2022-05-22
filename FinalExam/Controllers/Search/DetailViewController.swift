//
//  DetailViewController.swift
//  FinalExam
//
//  Created by Акбала Тлеугалиева on 5/22/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var LanguageLabel: UILabel!
    
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var detailView: UIView!
    var movieID = 0
    var filmtitle = ""
    var overView = ""
    var posterImage = ""
    var rating = 0.0
    var movies = [Movie]()
    var date = ""
    var language = ""
    var fav = 
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()

        print(movieID)
        titleLabel.text = filmtitle
        overviewLabel.text = overView
        ratingLabel.text = "\(rating)"
        posterImageView.sd_setImage(with: URL(string: posterImage), completed: nil)
        LanguageLabel.text = language
        dateLabel.text = convertDataFormatter(date)
        
        
    }
   // MARK: - // background view
    func configureView() {
       scroll.layer.cornerRadius = 30
       scroll.clipsToBounds = true
       scroll.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
       }
     // MARK: - // convert date
    func convertDataFormatter(_ date: String?) -> String {
           var fixDate = ""
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           if let originalDate = date {
               if let newDate = dateFormatter.date(from: originalDate){
                   dateFormatter.dateFormat = "d MMM, yyyy"
                   fixDate = dateFormatter.string(from: newDate)
               }
           }
           return fixDate

       }
    
    @IBAction func addToFavorite(_ sender: Any) {
        let defaults = UserDefaults.standard
            var newTask: [Favorite] = []
              newTask.title = filmtitle
              do{
                  if let data = defaults.data(forKey: "taskItemArray"){
                  var array = try JSONDecoder().decode([TaskItem].self, from: data)
                  array.append(newTask)
                  let encodeData = try JSONEncoder().encode(array)
                  defaults.set(encodeData, forKey: "taskItemArray")

                  } else {
                      let encodeData = try JSONEncoder().encode([newTask])
                      defaults.set(encodeData, forKey: "taskItemArray")
                  }
              }
                  catch{
                  print("Unable to Encode Array (\(error))")
              }
              textField.text = " "

          }
        
    }
    
    
}
