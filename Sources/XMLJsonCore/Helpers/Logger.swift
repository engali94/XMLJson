//
//  Logger.swift
//  ArgumentParser
//
//  Created by Ali on 29.04.2020.
//

import Foundation
import TSCBasic
import TSCUtility

enum Loger {
    
    static var isVerbose: Bool = false
    static let terminalController = TerminalController(stream: stdoutStream)
    static let animation = PercentProgressAnimation(stream: stdoutStream, header: "Processing Files ⚙️  ...")
    
    static func warning(_ message: String) {
        terminalController?.write("⚠️  \(message)", inColor: .yellow, bold: true)
        terminalController?.endLine()
        
    }
    
    static func log(_ message: String) {
        guard isVerbose else { return }
        terminalController?.write("\n" + message, inColor: .white, bold: true)
        terminalController?.endLine()
    }

    static func sucess(_ message: String) {
        
        terminalController?.write("\n\n\n✅ " + message, inColor: .green, bold: true)
        terminalController?.endLine()
    }
    
    static func animate(step: Int, total: Int, fileName: String) {
        guard !isVerbose else { return }
        animation.update(step: step, total: total , text: "Parsing \(fileName)...")
    }

}
