//
//  YoutubeViewController.swift
//  mbgclan app
//
//  Created by Bert Ten Cate on 30-01-16.
//  Copyright © 2016 Bert Ten Cate. All rights reserved.
//

import UIKit
import Foundation

class YoutubeViewController: UIViewController {
    
    @IBOutlet weak var YoutubeWebView: UIWebView!
    
    override func viewDidLoad() {
        
        let youtubeurl = NSURL (string: "https://m.youtube.com/user/MBGclan")
        let urlrequest = NSURLRequest(URL: youtubeurl!);
        YoutubeWebView.loadRequest(urlrequest)
        
        let swipeDownOnYoutube = UISwipeGestureRecognizer(target: self, action: "SwipeDownOnYoutube:")
        swipeDownOnYoutube.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDownOnYoutube)
        
    }
    
    
    @IBAction func SwipeDownOnYoutube(sender: UISwipeGestureRecognizer) {
        
        let youtubeurl = NSURL (string: "https://m.youtube.com/user/MBGclan")
        let urlrequest = NSURLRequest(URL: youtubeurl!);
        YoutubeWebView.loadRequest(urlrequest)
        
    }
    
}