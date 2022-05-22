//
//  MainViewController.swift
//  FinalExam
//
//  Created by Акбала Тлеугалиева on 5/22/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
     
       var mainMovies: [MainMovies] = []
        let category = ["Upcoming", "Top rated", "Now playing"]

            override func viewDidLoad() {
                super.viewDidLoad()
                
                tableView.delegate = self
                tableView.dataSource = self

                addNavBarImage()
                downloadMainBanners()
            }
            
            func addNavBarImage() {
                let image = UIImage(named: "SANDWITCH")!

                let logoImageView = UIImageView(image: image)
                let imageItem = UIBarButtonItem.init(customView: logoImageView)
                navigationItem.leftBarButtonItem = imageItem
            }

            // MARK: - downloads
            // step 1
            func downloadTopRated() {
                SVProgressHUD.show()
                AF.request(Urls.TOP_RATED, method: .get).responseData { response in
                    
                    SVProgressHUD.dismiss()
                    var resultString = ""
                    if let data = response.data {
                        resultString = String(data: data, encoding: .utf8)!
                        print(resultString)
                    }
                    
                    if response.response?.statusCode == 200 {
                        let json = JSON(response.data!)
                        print("JSON: \(json)")
                        
                        if let array = json["results"].array {
                            let movie = MainMovies()
                            for item in array {
                                let bannerMovie = Movie(json: item)
                                movie.movies.append(bannerMovie)
                            }
                            self.mainMovies.append(movie)
                            self.tableView.reloadData()
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
                     self.downloadNowPlaying()
                }
            }
            
            // step 2
            func downloadNowPlaying() {
                SVProgressHUD.show()
                AF.request(Urls.NOW_PLAYING, method: .get).responseData { response in

                    SVProgressHUD.dismiss()
                    var resultString = ""
                    if let data = response.data {
                        resultString = String(data: data, encoding: .utf8)!
                        print(resultString)
                    }
                    if response.response?.statusCode == 200 {
                                      let json = JSON(response.data!)
                                      print("JSON: \(json)")

                    if let array = json["results"].array {
                    let movie = MainMovies()
                    for item in array {
                    let bannerMovie = Movie(json: item)
                    movie.movies.append(bannerMovie)
                }
                                           self.mainMovies.append(movie)
                                           self.tableView.reloadData()
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
    //
                }
            }
        func downloadMainBanners() {
                    SVProgressHUD.show()
                    AF.request(Urls.UPCOMING, method: .get).responseData { response in

                        SVProgressHUD.dismiss()
                        var resultString = ""
                        if let data = response.data {
                            resultString = String(data: data, encoding: .utf8)!
                            print(resultString)
                        }
                        if response.response?.statusCode == 200 {
                                          let json = JSON(response.data!)
                                          print("JSON: \(json)")

                        if let array = json["results"].array {
                        let movie = MainMovies()
                        movie.cellType = .mainBanner

                        for item in array {
                        let bannerMovie = Movie(json: item)
                            movie.banner.append(bannerMovie)
                    }
                                               self.mainMovies.append(movie)
                                               self.tableView.reloadData()
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
                        self.downloadTopRated()
                    }
                }

            // MARK: - Table view data source
            func numberOfSections(in tableView: UITableView) -> Int {
                // #warning Incomplete implementation, return the number of sections
                return 1
            }

            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                // #warning Incomplete implementation, return the number of rows
                return mainMovies.count
            }

            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                //mainBanner
                if mainMovies[indexPath.row].cellType == .mainBanner {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "bannerCell", for: indexPath) as! UpcomingTableViewCell

                    cell.setData(mainMovie: mainMovies[indexPath.row])
                    cell.categoryLabel.text = category[indexPath.row]

                    return cell
                }
                

                let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! TopRatedTableViewCell

                cell.setData(mainMovie: mainMovies[indexPath.row])
                cell.categoryLabel.text = category[indexPath.row]

                return cell
            }
            
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                if mainMovies[indexPath.row].cellType == .mainBanner {
                    return 310.0
                }
                return 330.0
            }
            
//            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//                let categoryTableViewController = storyboard?.instantiateViewController(withIdentifier: "SearchTableViewController") as! SearchTableViewController
//    //            categoryTableViewController.categoryID = mainMovies[indexPath.row].categoryId
//    //            categoryTableViewController.categoryName = mainMovies[indexPath.row].categoryName
//
//                navigationController?.show(categoryTableViewController, sender: self)
//            }

        }
