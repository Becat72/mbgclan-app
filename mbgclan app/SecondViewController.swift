//
//  SecondViewController.swift
//  mbgclan app
//
//  Created by Bert Ten Cate on 10-01-16.
//  Copyright © 2016 Bert Ten Cate. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController, NSXMLParserDelegate {
    
    var arrParsedData = [Dictionary<String, String>]()
    var currentDataDictionary = Dictionary<String, String>()
    var currentElement = ""
    var foundCharacters = ""
    var url: NSURL!
    var newsitemnumber: Int = 0
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var DescriptionWebView: UIWebView!
    

    func startParsingWithContentsOfURL(url: NSURL) {
        let parser = NSXMLParser(contentsOfURL: url)
        parser?.delegate = self
        parser?.parse()
    }
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement = elementName
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if currentElement == "title" || currentElement == "link" || currentElement == "description" || currentElement == "pubDate" {
            foundCharacters += string
        }
    }
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if !foundCharacters.isEmpty {
            currentDataDictionary[currentElement] = foundCharacters
            foundCharacters = ""
            if currentElement == "pubDate" {
                arrParsedData.append(currentDataDictionary)
            }
        }
    }
    
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print(parseError.description)
    }
    
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        print(validationError.description)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var swipeRightOnNews  = UISwipeGestureRecognizer(target: self, action: "SwipeRightOnNews:")
        swipeRightOnNews.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRightOnNews)
        
        var swipeLeftOnNews = UISwipeGestureRecognizer(target: self, action: "SwipeLeftOnNews:")
        swipeLeftOnNews.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeftOnNews)
        
        url = NSURL(string: "http://www.mbgclan.nl/posts/index.rss")
        startParsingWithContentsOfURL(url)
        DisplayNews()
    }
    
    
    func DisplayNews() {
        currentDataDictionary = arrParsedData[newsitemnumber]
        TitleLabel.text = currentDataDictionary["title"]
        pubDateLabel.text = currentDataDictionary["pubDate"]
        DescriptionWebView.loadHTMLString(currentDataDictionary["description"]!, baseURL: nil)
    }
    
    
    @IBAction func SwipeRightOnNews(sender: UISwipeGestureRecognizer) {
        if newsitemnumber > 0 {
            newsitemnumber = newsitemnumber - 1
            DisplayNews()
        }
    }
    
    
    
    @IBAction func SwipeLeftOnNews(sender: UISwipeGestureRecognizer) {
        if newsitemnumber < 19 {
            newsitemnumber = newsitemnumber + 1
            DisplayNews()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

