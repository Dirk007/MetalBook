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

    @IBOutlet var webkitView: WKWebView!

    func loadPage() {
        let myURL = URL(string: "http://m.facebook.com/")
        let myRequest = URLRequest(url: myURL!)
        webkitView.stopLoading()
        webkitView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadPage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

