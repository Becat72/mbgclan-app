//
//  ShoutboxViewController.swift
//  mbgclan app
//
//  Created by Bert Ten Cate on 30-01-16.
//  Copyright © 2016 Bert Ten Cate. All rights reserved.
//

import UIKit
import Foundation

class ShoutboxViewController: UIViewController, NSXMLParserDelegate {
    
    var arrParsedData = [Dictionary<String, String>]()
    var currentDataDictionary = Dictionary<String, String>()
    var currentElement = ""
    var foundCharacters = ""
    var url: NSURL! = NSURL(string: "http://www.mbgclan.nl/shouts/index.rss")
    var shoutboxitemnumber: Int = 0
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
        
        let swipeRightOnShoutbox  = UISwipeGestureRecognizer(target: self, action: "SwipeRightOnShoutbox:")
        swipeRightOnShoutbox.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRightOnShoutbox)
        
        let swipeLeftOnShoutbox = UISwipeGestureRecognizer(target: self, action: "SwipeLeftOnShoutbox:")
        swipeLeftOnShoutbox.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeftOnShoutbox)
        
        let swipeDownOnShoutbox = UISwipeGestureRecognizer(target: self, action: "SwipeDownOnShoutbox:")
        swipeDownOnShoutbox.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDownOnShoutbox)
        
        startParsingWithContentsOfURL(url)
        DisplayShoutbox()
    }
    
    
    func DisplayShoutbox() {
        currentDataDictionary = arrParsedData[shoutboxitemnumber]
        pubDateLabel.text = currentDataDictionary["pubDate"]
        DescriptionWebView.loadHTMLString(currentDataDictionary["description"]!, baseURL: nil)
    }
    
    
    @IBAction func SwipeRightOnShoutbox(sender: UISwipeGestureRecognizer) {
        if shoutboxitemnumber > 0 {
            shoutboxitemnumber = shoutboxitemnumber - 1
            DisplayShoutbox()
        }
    }
    
    
    @IBAction func SwipeLeftOnShoutbox(sender: UISwipeGestureRecognizer) {
        if shoutboxitemnumber < 19 {
            shoutboxitemnumber = shoutboxitemnumber + 1
            DisplayShoutbox()
        }
    }
    
    
    @IBAction func SwipeDownOnShoutbox(sender: UISwipeGestureRecognizer) {
        shoutboxitemnumber = 0
        startParsingWithContentsOfURL(url)
        DisplayShoutbox()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}