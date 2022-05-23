//
//  PlayerViewController.swift
//  FinalExam
//
//  Created by Акбала Тлеугалиева on 5/23/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire
import SDWebImage
import WebKit

class PlayerViewController: UIViewController {

    var movieID = 0

    @IBOutlet weak var webKit: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.youtube.com/watch?v=22oiqgtV6hw")
        let urlRequest = URLRequest(url: url!)
        webKit.load(urlRequest)
    }
}
