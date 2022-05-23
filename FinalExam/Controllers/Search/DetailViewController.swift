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
    var kkkkey = ""
    var filmtitle = ""
    var overView = ""
    var posterImage = ""
    var rating = 0.0
    var movies = [Movie]()
    var date = ""
    var language = ""
    var movieList = [MovieVideo]()

   
    
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
        downloadMoviesByCategory()
        
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "play" {
            if let scviewcontroller = segue.description as? PlayerViewController {
            scviewcontroller.movieID = movieID
        }
    }
}
    func downloadMoviesByCategory() {
           SVProgressHUD.show()
           AF.request("https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=da0213edba5ce29d325c43cfec6aeab5&language=en-US", method: .get).responseData { response in
               
               SVProgressHUD.dismiss()
               var resultString = ""
               if let data = response.data {
                   resultString = String(data: data, encoding: .utf8)!
                   print(resultString)
               }
               
               if response.response?.statusCode == 200 {
                   let json = JSON(response.data!)
                   print("JSON: \(json)")
                   
                   if json["results"].exists() {
                       if let array = json["results"].array {
                           for item in array {
                               let movie = MovieVideo(json: item)
                               self.movieList.append(movie)
                               self.kkkkey = movie.key
                               print(self.kkkkey)
                           }
                       }
                   } else {
                       SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localizedLowercase)
                   }
               } else {
                   var ErrorString = "CONNECTION_ERROR".localizedLowercase
                   if let sCode = response.response?.statusCode {
                       ErrorString = ErrorString + " \(sCode)"
                   }
                   ErrorString = ErrorString + " \(resultString)"
                   SVProgressHUD.showError(withStatus: "\(ErrorString)")
               }
           }
       }
}
