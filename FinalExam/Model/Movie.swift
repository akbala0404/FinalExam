//
//  Movie.swift
//  FinalExam
//
//  Created by Акбала Тлеугалиева on 5/22/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie: Decodable, Encodable {
  var id = 0
  var title = ""
  var release_date = ""
  var vote_average: Double = 0.0
  var original_title = ""
  var overview = ""
  var posterImage = ""
  var backdrop_path = ""
  var original_language = ""
  init (){
  }
  init (json: JSON){
    if let temp = json["id"].int{
            id = temp
        }
     if let temp = json["title"].string{
          title = temp
      }
      if let temp = json["release_date"].string{
               release_date = temp
           }
      if let temp = json["vote_average"].double{
               vote_average = temp
           }
     if let temp = json["original_title"].string{
             original_title = temp
         }
     if let temp = json["overview"].string{
        
            overview = temp
         }
    if let temp = json["original_language"].string{
       
           original_language = temp
    }
    if let temp = json["poster_path"].string{
    let fullPath = "https://image.tmdb.org/t/p/w500/" + temp
    posterImage = fullPath
    }
    if let temp = json["backdrop_path"].string{
       let fullPath = "https://image.tmdb.org/t/p/original/" + temp
       backdrop_path = fullPath
       }
}
    
}

