//
//  XMLJson.swift
//  XMLJsonCore
//
//  Created by Ali on 28.04.2020.
//

import ArgumentParser
import TSCBasic

public struct  XMLJsonCommand: ParsableCommand {
    
    public static var configuration = CommandConfiguration(commandName: "xmljson",abstract: "Convert XML Format to JSON Format.")
    
    public init() { }

    @Option(name: .shortAndLong, help: "Absolute path to a directory containing the xml files.")
    private var dir: String
    
    @Option(name: .shortAndLong, parsing: .upToNextOption, help: "XML files to be parsed.")
    var files: [String]
    
    @Option(name: .shortAndLong, help: "[Optinal] JSON file(s) output directory.")
    private var output: String?
    
    @Flag(name: .shortAndLong, help: "Show extra logging for debugging purposes.")
    var verbose: Bool
//
//    @Flag(name: .shortAndLong, help: "Merge all converted XML files into one JSON file.")
//    var merge: Bool
    
    @Flag(name: .shortAndLong, help: "Convert all XML files present in the specifed directory.")
    var all: Bool
    
    public func run() throws {
        
        Loger.isVerbose = verbose
        
        guard !dir.isEmpty  else {
            throw XMLJsonError.invlaidInput
        }
        
        if all {
            let path = Path(inputDir: dir, outputPath: output ?? "")
            try parse(from: path)
        
        } else {
            guard !files.isEmpty else { throw XMLJsonError.shouldProvideFiles }
            let path = Path(dir, files: files, outputPath: output ?? "")
            try parse(from: path)
        }
    }
    
    func parse(from path: Path) throws {
        let outputPath = output == nil ? path.baseUrl : path.outputUrl
        let parser = Parser(files: path.filesUrls, outputPath: outputPath)
        try parser.parse()
    }
}


