//
//  SearchViewController.swift
//  FinalExam
//
//  Created by Акбала Тлеугалиева on 5/22/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  UISearchBarDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
       var movieList = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search movie"
        navigationItem.searchController = searchController
        searchMovie(title: "Spiderman")

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          movieList.removeAll()
          tableView.reloadData()
          searchMovie(title: searchBar.text!)
      }
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
    
     func searchMovie(title: String) {
                AF.request("https://api.themoviedb.org/3/search/movie?api_key=da0213edba5ce29d325c43cfec6aeab5&query=\(title)",
                           method: .get, parameters: nil).responseJSON {
                    response in
                    if response.response?.statusCode == 200{
                        let json = JSON(response.value!)
                        if let array = json["results"].array {
                            for item in array {
                                let movie = Movie(json: item)
                                self.movieList.append(movie)
                            }
                            
                        }
                        self.tableView.reloadData()

                    }
                }
        }

        // MARK: - Table view data source

         func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return movieList.count
        }
        
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
            cell.titleLabel.text = movieList[indexPath.row].title
            cell.dateLabel.text = convertDataFormatter( movieList[indexPath.row].release_date)
            cell.raingLabel.text = "\(movieList[indexPath.row].vote_average)"
            cell.posterImageView.sd_setImage(with: URL(string: movieList[indexPath.row].posterImage), completed: nil)
            return cell
        }
        
         func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 160.0
        }
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let viewcontroller = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
            viewcontroller.movieID = movieList[indexPath.row].id
            viewcontroller.filmtitle = movieList[indexPath.row].title
            viewcontroller.overView = movieList[indexPath.row].overview
            viewcontroller.rating = movieList[indexPath.row].vote_average
           // viewcontroller. = movieList[indexPath.row].vote_average
            viewcontroller.posterImage = movieList[indexPath.row].backdrop_path
            viewcontroller.language = movieList[indexPath.row].original_language
            viewcontroller.date = movieList[indexPath.row].release_date
            navigationController?.show(viewcontroller, sender: self)
     
        

        }


        /*
        // Override to support conditional editing of the table view.
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the specified item to be editable.
            return true
        }
        */

        /*
        // Override to support editing the table view.
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
        */

        /*
        // Override to support rearranging the table view.
        override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

        }
        */

        /*
        // Override to support conditional rearranging of the table view.
        override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the item to be re-orderable.
            return true
        }
        */

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }

