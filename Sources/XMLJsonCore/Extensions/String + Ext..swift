//
//  String + Ext..swift
//  XMLJsonCore
//
//  Created by Ali on 27.04.2020.
//

import Foundation


extension String {
    
    mutating func newLine() {
        self.append("\n")
    }
    
    mutating func indentText(level: Int)  {
        self.append(String(repeating: "    ", count: level))
    }
    
    var condenseWhitespacs: String {
        
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: "")
        
    }
}
