//
//  XMLJson.swift
//  XMLJsonCore
//
//  Created by Ali on 28.04.2020.
//

import ArgumentParser

public struct  XMLJsonCommand: ParsableCommand {
    
    public static var configuration = CommandConfiguration(commandName: "XMLJson",abstract: "Convert XML Format to JSON Format.")
    
    public init() { }

    @Option(name: .shortAndLong, help: "Absolute path to a directory containing the xml files.")
    private var dir: String
    
    @Option(name: .shortAndLong, parsing: .upToNextOption, help: "XML files to be parsed.")
    var files: [String]
    
    @Option(name: .shortAndLong, help: "JSON file(s) output directory.")
    private var output: String?
    
    @Flag(name: .shortAndLong, help: "Show extra logging for debugging purposes.")
    var verbose: Bool
    
    @Flag(name: .shortAndLong, help: "Merge all converted XML files into one JSON file.")
    var merge: Bool
    
    @Flag(name: .shortAndLong, help: "Convert all XML files present in the specifed directory.")
    var all: Bool
    
    public func run() throws {
        
        guard !dir.isEmpty  else {
            throw XMLJsonError.invlaidInput
        }
        let parser = Parser(files: [dir], output: output, merge: merge, all: all)
        try parser.parse()
        let path = Path(dir)
        print(path.type)
        
    }
}


