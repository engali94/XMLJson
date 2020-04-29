//
//  File.swift
//  
//
//  Created by Ali on 27.04.2020.
//

import Foundation
import ArgumentParser

class Parser: NSObject, XMLParserDelegate {
    
    private var parser: XMLParser!
    private var attributes: [String: String] = [:]
    private var lastElement: String = ""
    private var stack = Stack()
    private var xmlElement: XMLElement?
    
    let files: [URL]
    let outputPath: URL
    
    private var currentFile = ""
    
    init(files: [URL], outputPath: URL, merge: Bool) {
        self.files = files
        self.outputPath = outputPath
        
        super.init()
    }
    
    
    func parse() throws {
        
        for file in files {
            guard file.pathExtension == "xml" else { throw XMLJsonError.fileNameInvalid(file: file.lastPathComponent) }
            currentFile =  file.lastPathComponent
            parser = XMLParser(contentsOf: file)
            parser.delegate = self
            parser.parse()
            
        }
        print("finshed!")
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
        // show debug info ike
        // now parsing\(currentFile)...
        print("✅ parserDidEndDocument", currentFile)
       // print(stack.finalString)
    }
}
