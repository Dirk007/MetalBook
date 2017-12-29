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

    @IBOutlet var webLoadProgress: UIProgressView!
    @IBOutlet var mainView: UIView!
    @IBOutlet var webkitView: WKWebView!

    var lastLoaded : String = ""
    
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
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if (motion == .motionShake) {
            print("!!!!! SHAKE !!!!!");
            if (!lastLoaded.isEmpty) {
                loadPage(url: lastLoaded)
            }
        }
    }
    func loadPage(url: String) {
        lastLoaded = url
        let myRequest = URLRequest(url: URL(string: url)!)
        webkitView.stopLoading()
        webkitView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webkitView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        loadPage(url: "https://www.facebook.com/")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            print("** PROGRESS: \(webkitView.estimatedProgress )")
            webLoadProgress.progress = Float(webkitView.estimatedProgress)
            webLoadProgress.isHidden = (webkitView.estimatedProgress == 1.0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        lastLoaded.removeAll()
    }


}

