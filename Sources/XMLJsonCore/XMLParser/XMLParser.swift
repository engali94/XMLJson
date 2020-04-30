//
//  Parser.swift
//  XMLJsonCore
//
//  Created by Ali on 27.04.2020.
//

import Foundation


class Parser: NSObject, XMLParserDelegate {
    
    private var parser: XMLParser!
    private var attributes: [String: String] = [:]
    private var lastElement: String = ""
    private var stack = Stack()
    private var xmlElement: XMLElement?
    
    let files: [URL]
    let outputPath: URL
    // TODO: - Support merging files into sinlge file
    // let merge: Bool
    // var mergeString = ""
    
    private var currentFile = ""
    private var steps = 0
    
    init(files: [URL], outputPath: URL) {
        self.files = files
        self.outputPath = outputPath
        
        super.init()
    }
    
    func parse() throws {
        for file in files {
            // FIXME: - replace with warning
            guard file.pathExtension == "xml" else { throw XMLJsonError.fileNameInvalid(file: file.lastPathComponent) }
            currentFile =  file.lastPathComponent
            parser = XMLParser(contentsOf: file)
            parser.delegate = self
            parser.parse()
        }
        
        Loger.sucess("Done! You can find your file(s) in \(outputPath.absoluteString)")
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
        steps += 1
        Loger.animate(step: steps, total: files.count, fileName: currentFile)
        Loger.log("🚀 Parsed \(currentFile) successfully!")
        try? saveToDisk()
        stack.finalString = ""
    }
}

// MARK: - Helpers

private extension Parser {
    
    func prettifyJson(_ string: String) throws -> Data? {
        guard let data = string.data(using: .utf8) else { return nil }
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        let prettyPrintedData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        return prettyPrintedData
    }
    
    func saveToDisk () throws {
        guard let prettyPrintedData = try prettifyJson(stack.finalString) else { return  }
        currentFile.removeLast(4)
        let filePath = outputPath.appendingPathComponent("\(currentFile).json")
        try prettyPrintedData.write(to: filePath)
    }
    
}
