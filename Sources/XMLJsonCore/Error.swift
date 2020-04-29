//
//  Error.swift
//  XMLJsonCore
//
//  Created by Ali on 29.04.2020.
//

import Foundation

enum XMLJsonError: Error {
    case invlaidInput
    case shouldProvideFiles
    case fileNameInvalid(file: String)
}

extension XMLJsonError: CustomStringConvertible {
    var description: String {
        
        switch self {
        case .invlaidInput: return "Please make sure you have provided a correct path."
        case .shouldProvideFiles: return "Please provide XML file(s)."
        case .fileNameInvalid(let file): return "It seems \(file) is not valid XML file."
        }
    }
}
