//
//  Path.swift
//  XMLJsonCore
//
//  Created by Ali on 29.04.2020.
//

import Foundation

struct Path  {
    
    private let fileManager = FileManager.default
    public let directory: String
    public var files: [String]
    public let outputPath: String
    
    init(_ dir: String, files: [String], outputPath: String) {
        self.directory = dir
        self.files = files
        self.outputPath = outputPath
    }
    
    private init (dir: String, outputPath: String) {
        self.directory = dir
        self.outputPath = outputPath
        self.files = []
    }
    
    init(inputDir dir: String, outputPath: String) {
        self.init(dir: dir, outputPath: outputPath)
        enumerateXMLFiles()
    }
    
    var baseUrl: URL {
        return URL(fileURLWithPath: directory, isDirectory: true)
    }
    
    var outputUrl: URL {
        return URL(fileURLWithPath: outputPath, isDirectory: true)
    }
    
    var filesUrls: [URL] {
        return urlsFromFiles(files)
    }
    
    mutating private func enumerateXMLFiles() {

        guard let files = fileManager.enumerator(at: baseUrl,
                                                 includingPropertiesForKeys: nil) else { return }
        for case let file as URL in files {
            guard file.pathExtension == "xml" else { continue }
            self.files.append(file.lastPathComponent)
        }
    }
    
    private func urlsFromFiles(_ files: [String]) -> [URL] {
        return files.compactMap { URL(fileURLWithPath: self.directory + "/" + $0) }
    }
    
}
