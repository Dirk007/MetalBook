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
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var newestButton: UIButton!
    @IBOutlet var messagesButton: UIButton!

    enum ButtonAction {
        case home, newest, messages
    }
    
    struct ButtonContext {
        var url: String
        var button: UIButton
    }
    
    var ActionDict : [ButtonAction: ButtonContext] = [:]
        
    var lastLoaded : String = ""

    func initWebButtons()
    {
        ActionDict = [ButtonAction.home: ButtonContext(url: "https://www.facebook.com/?sk=h_nor", button: homeButton),
                      ButtonAction.newest: ButtonContext(url: "https://www.facebook.com/?sk=h_chr", button: newestButton),
                      ButtonAction.messages: ButtonContext(url: "https://www.facebook.com/messages", button: messagesButton)]
        
    }
    
    func performWebButton(button: ButtonAction) {
        loadPage(url: (ActionDict[button]?.url)!)
        for (action, context) in ActionDict {
            context.button.isSelected = (action == button)
        }
    }

    @IBAction func homeTapped(_ sender: Any)
    {
        performWebButton(button: ButtonAction.home)
    }
    
    @IBAction func newestTapped(_ sender: Any) {
        performWebButton(button: ButtonAction.newest)
    }
    
    @IBAction func messagesTapped(_ sender: Any) {
        performWebButton(button: ButtonAction.messages)
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if (motion == .motionShake) {
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
        
        initWebButtons()
        performWebButton(button: ButtonAction.home)
        
        //loadPage(url: "https://www.facebook.com/")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
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

