//
//  ElementsStack.swift
//  ArgumentParser
//
//  Created by Ali on 27.04.2020.
//

import Foundation

struct Stack {
    
    var elements: [XMLElement] = []
    var finalString = ""
    var rootElement: XMLElement?
    
    // Push operation
    mutating func push(_ xmlElement: XMLElement) {
        processElement(xmlElement)
        elements.append(xmlElement)
    }
  
    // Pop operation
    @discardableResult
    mutating func pop() -> XMLElement?{
        guard let _element = elements.popLast() else { return nil }
        proccesElementRemoval(_element)
        return _element
    }
    
    var indentLevel: Int {
        return elements.count
    }
}

private extension Stack {
    
    /// Process each element enters the stack.
     mutating func processElement(_ element: XMLElement) {
        
        guard !elements.isEmpty else {
            rootElement = element
            finalString.append("[\n")
            return
        }
        
        if element.hasAttributes && !element.hasText{
            openObject()
            processAttributes(for: element)
        }
        else if element.hasAttrAndText {
            processAttributesAndText(for: element)
        }
        else {
            // in case contains only text without
            // attributes for example:
            // <author>J K. Rowling</author>
            finalString.append("\"\(element.name)\": \"\(element.text)\",")
            finalString.newLine()
        }
    }
    
    /// If the `element` has attibutes this method will extract them to json object.
    mutating func processAttributes(for element: XMLElement) {
        for (key, value) in element.attributs {
            finalString.append("\"\(key)\": \"\(value)\",\n")
        }
        
        if element.hasText {
            finalString.append("\"text\": \"\(element.text)\"")
        }
    }
    
    /// In case the element has both text and attributes extract both to json object i.e
    /// <title lang="en">Harry Potter</title>
    mutating func processAttributesAndText(for element: XMLElement) {
        finalString.newLine()
        finalString.append("\"\(element.name)\":\n")
        openObject()
        processAttributes(for: element)
    
    }
    
    
    /// Opens a new JSON object.
    mutating func openObject() {
        finalString.append("{")
        finalString.newLine()
    }
    
    /// Closes the last opened JSON objects.
    mutating func closeObject() {
        // before closing the object check if the last char
        // in the final string is `comma ,` if it is present
        // delete it before closing the pbject
        if finalString.last == "," || finalString.last == "\n" {
            finalString.removeLast(2) // the last two chars is , + \n = 2
        }
        finalString.newLine()
        finalString.append("}, \n")
    }
    
    /// Triggered with each `pop` operation.
    mutating func proccesElementRemoval(_ element: XMLElement) {
        // in case of end of the root element close with ]
        if element.name == rootElement?.name  {
            finalString.removeLast(3) // to remove single spcace + newline + comma = 3
            finalString.append("\n]")
            return
        }
        // in the other elements if it has
        // attributes it means that we dealt
        // with it like object so close with }
        if element.hasAttributes {
            closeObject()
        }
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        let elemntsString = elements
            .map{"\($0)"}
            .reversed()
            .joined(separator: "\n")
        return "Stack....\n" + elemntsString + "\nStackEnd"
    }
}

