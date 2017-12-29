//
//  ViewController.swift
//  MetalBook
//
//  Created by Dirk Faust on 27.12.17.
//  Copyright © 2017 Dirk Faust. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet var webkitView: WKWebView!

    @IBAction func homeTapped(_ sender: Any)
    {
        loadPage(url: "https://www.facebook.com/?sk=h_nor")
    }
    
    @IBAction func newestTapped(_ sender: Any) {
        loadPage(url: "https://www.facebook.com/?sk=h_chr")
    }
    
    @IBAction func messagesTapped(_ sender: Any) {
        loadPage(url: "https://www.facebook.com/messages")
    }
    
    func loadPage(url: String) {
        let myRequest = URLRequest(url: URL(string: url)!)
        webkitView.stopLoading()
        webkitView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPage(url: "https://www.facebook.com/")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

