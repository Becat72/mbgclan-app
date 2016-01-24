//
//  ThirdViewController.swift
//  mbgclan app
//
//  Created by Bert Ten Cate on 23-01-16.
//  Copyright © 2016 Bert Ten Cate. All rights reserved.
//

import UIKit
import Foundation

class ThirdViewController: UIViewController, NSXMLParserDelegate {

    var arrParsedData = [Dictionary<String, String>]()
    var currentDataDictionary = Dictionary<String, String>()
    var currentElement = ""
    var foundCharacters = ""
    var url: NSURL!
    var eventitemnumber: Int = 0
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
        
        var swipeRightOnEvents  = UISwipeGestureRecognizer(target: self, action: "SwipeRightOnEvents:")
        swipeRightOnEvents.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRightOnEvents)
        
        var swipeLeftOnEvents = UISwipeGestureRecognizer(target: self, action: "SwipeLeftOnEvents:")
        swipeLeftOnEvents.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeftOnEvents)
        
        url = NSURL(string: "http://www.mbgclan.nl/events/index.rss")
        startParsingWithContentsOfURL(url)
        DisplayEvents()
    }
    
    
    func DisplayEvents() {
        currentDataDictionary = arrParsedData[eventitemnumber]
        TitleLabel.text = currentDataDictionary["title"]
        pubDateLabel.text = currentDataDictionary["pubDate"]
        DescriptionWebView.loadHTMLString(currentDataDictionary["description"]!, baseURL: nil)
    }
    
    
    @IBAction func SwipeRightOnEvents(sender: UISwipeGestureRecognizer) {
        if eventitemnumber > 0 {
            eventitemnumber = eventitemnumber - 1
            DisplayEvents()
        }
    }
    
    
    
    @IBAction func SwipeLeftOnEvents(sender: UISwipeGestureRecognizer) {
        if eventitemnumber < 20 {
            eventitemnumber = eventitemnumber + 1
            DisplayEvents()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}