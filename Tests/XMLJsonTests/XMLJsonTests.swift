import XCTest
import class Foundation.Bundle
@testable import XMLJsonCore

final class XMLJsonTests: XCTestCase {
 
    private let testDataPath = URL(fileURLWithPath: #file)
        .deletingLastPathComponent()
        .pathComponents
        .prefix(while: { $0 != "Sources" })
        .joined(separator: "/").dropFirst()
    
    private let fileManager = FileManager.default
    private var dirPath: String!
    
    override func setUp() {
        dirPath = String(testDataPath) + "/TestData"
    }
    
    func testPathCreation() {

        let path = Path(inputDir: dirPath, outputPath: dirPath)
        XCTAssertEqual(path.baseUrl, URL(fileURLWithPath: dirPath, isDirectory: true))
        XCTAssertEqual(path.outputUrl, URL(fileURLWithPath: dirPath, isDirectory: true))
    }
    
    func testParseAllCommand() throws {
       
        let args = ["--dir", dirPath! ,"--all"]
        
        let parseCommand = try XMLJsonCommand.parseAsRoot(args)
        try parseCommand.run()
        
        XCTAssertTrue(isFileExists("1.json"))
        XCTAssertTrue(isFileExists("2.json"))
        
        try jsonFileTest(file: "1.json", cattegory: "cooking", year: "2005")
        try jsonFileTest(file: "2.json", cattegory: "web", year: "2003")
        
     
        removeFiles(["1.json", "2.json"])
    }
    
    func testParseOneComand() throws {
        let args = ["--dir", dirPath! ,"-f", "1.xml"]
               
        let parseCommand = try XMLJsonCommand.parseAsRoot(args)
        try parseCommand.run()
        
        XCTAssertTrue(isFileExists("1.json"))
        
        try jsonFileTest(file: "1.json", cattegory: "cooking", year: "2005")
        removeFiles(["1.json"])
    }
    
    func testFileNotFound() throws {
        let args = ["--dir",dirPath! ,"-f", "1.xfl"]
               
        let parseCommand = try XMLJsonCommand.parseAsRoot(args)
        XCTAssertThrowsError( try parseCommand.run())
    }

    static var allTests = [
         testPathCreation,
         testParseAllCommand,
         testParseOneComand,
    ]
}

private extension XMLJsonTests {
    
    private func isFileExists(_ name: String) -> Bool {
        return fileManager.fileExists(atPath: dirPath + "/" + name)
    }
    
    private func loadAndParseJson(from file: String) throws -> Book{
        let url = try XCTUnwrap(URL(fileURLWithPath: dirPath + "/" + file))
        let data = try Data(contentsOf: url)
        let book = try JSONDecoder().decode([Book].self, from: data)
        return book.first!
    }
    
    private func jsonFileTest(file: String, cattegory: String, year: String) throws {
        let book = try loadAndParseJson(from: file)
        XCTAssertEqual(book.category, cattegory)
        XCTAssertEqual(book.year, year)
    }
    
    private func removeFiles(_ files: [String])  {
        addTeardownBlock {
            do {
                for file in files {
                    let filePath = self.dirPath + "/" + file
                    
                    if self.isFileExists(file) {
                        try self.fileManager.removeItem(atPath: filePath)
                    }
                }
            } catch {
                XCTFail("Error while deleting the genetrated file: \(error)")
            }
        }
    }

}

struct Book: Codable {

    struct Title: Codable {
        let lang: String
        let text: String
    }
    
    let author: String?
    let category: String?
    let price: String?
    let title: Title?
    let year: String?

}



