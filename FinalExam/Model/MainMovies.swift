//
//  Movies.swift
//  FinalExam
//
//  Created by Акбала Тлеугалиева on 5/22/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import Foundation
import SwiftyJSON

enum CellType {
    case mainBanner
    case mainMovie
    case userHistory
    case genre
    case ageCategory
}

class MainMovies {
    var page = ""
    var movies: [Movie] = []
    var banner: [Movie] = []
    var cellType: CellType = .mainMovie
    var total_pages = ""
    var total_results = ""

    
    init() {
        
    }
    init(json: JSON) {
        
        if let temp = json["page"].string {
            self.page = temp
        }
        if let temp = json["total_results"].string {
                  self.total_results = temp
              }
        if let temp = json["total_pages"].string {
            self.total_pages = temp
        }
        if let array = json["results"].array {
            for item in array {
                let temp = Movie(json: item)
                self.movies.append(temp)
            }
        }
    }
}

