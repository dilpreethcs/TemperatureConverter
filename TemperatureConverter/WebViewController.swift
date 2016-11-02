//
//  WebViewController.swift
//  TemperatureConverter
//
//  Created by Dilpreet Singh on 27/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    let siteURL = "https://www.bignerdranch.com"
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let nsurl = URL(string: siteURL) else { return }
        webView.loadRequest(URLRequest(url: nsurl))
    }
    
}
