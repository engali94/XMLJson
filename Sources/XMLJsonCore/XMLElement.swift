//
//  XMLElement.swift
//  ArgumentParser
//
//  Created by Ali on 27.04.2020.
//

struct XMLElement {
    
    var name: String
    var attributs: [String: String]
    var text: String
    
    var hasAttributes: Bool {
        return !attributs.isEmpty
    }
    
    var hasText: Bool {
        return !text.isEmpty
    }
    
    var hasAttrAndText: Bool {
        return hasText && hasAttributes
    }
}
