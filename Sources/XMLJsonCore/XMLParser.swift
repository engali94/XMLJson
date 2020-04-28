//
//  File.swift
//  
//
//  Created by Ali on 27.04.2020.
//

import Foundation
import ArgumentParser

class Parser: NSObject, XMLParserDelegate {
    var parser: XMLParser!
    var attributes: [String: String] = [:]
    var lastElement: String = ""
    var stack = Stack()
    var xmlElement: XMLElement?
    
    func viewDidLoad() {
        let path = Bundle.main.url(forResource: "strings", withExtension: "xml")!
        parser = XMLParser(contentsOf: path)
        parser.delegate = self
        parser.parse()
        
    }
        
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String]) {
        // 1. step
        attributes = attributeDict
        lastElement = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // 2. step
        if lastElement.isEmpty { return }
        xmlElement = XMLElement(name: lastElement, attributs: attributes, text: string.condenseWhitespacs)
        lastElement = ""
        stack.push(xmlElement!)
    }
      
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        // finally this
        stack.pop()
    }
    
  
    func parserDidEndDocument(_ parser: XMLParser) {
        print("parserDidEndDocument")
        print(stack.finalString)
    }
}
