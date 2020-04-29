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
    
    init(_ dir: String, files: [String]) {
        self.directory = dir
        self.files = files
    }
    
    private init (dir: String) {
        self.directory = dir
        files = []
    }
    
    init(_ dir: String) {
        self.init(dir: dir)
        enumerateXMLFiles()
    }
    
    mutating func enumerateXMLFiles() {
        guard let files = fileManager.enumerator(at: baseUrl,
                                                 includingPropertiesForKeys: nil) else { return }
        for case let file as URL in files {
            guard file.pathExtension == "xml" else { continue }
            self.files.append(file.lastPathComponent)
        }
    }
    
    func urlsFromFiles(_ files: [String]) -> [URL] {
        return files.compactMap { URL(fileURLWithPath: self.directory + $0) }
    }
    
    var baseUrl: URL {
        return URL(fileURLWithPath: directory)
    }
    
    var filesUrls: [URL] {
        return urlsFromFiles(files)
    }
    
}
