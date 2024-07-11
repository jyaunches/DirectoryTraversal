//
//  DirectoryManagerTests.swift
//  DirectoryPlaygroundTests
//
//  Created by Julietta Yaunches on 7/9/24.
//

import XCTest
@testable import DirectoryPlayground

final class DirectoryManagerTests: XCTestCase {

    var root: DirectoryNode?
    var pocFileNode: FileNode?
    
    //              ~./
    //  projects/       main.py
    //  poc.py
    override func setUpWithError() throws {
        root = DirectoryNode(name: "~./", parent: nil)
        let projectsDir = root?.addDirectory(name: "projects")
        self.pocFileNode = projectsDir?.addFile(name: "poc.py", content: "#foo")
        _ = root?.addFile(name: "main.py", content: "#bar")
    }

    func testFindsNodeGivenAPath() throws {
        let directorManager = DirectoryManager(root: self.root!)
        if let pocFileNode = directorManager.find(path: "projects/poc.py") {
            XCTAssertEqual(pocFileNode.name, self.pocFileNode?.name)
        } else {
            XCTFail("No result returned")
        }
    }
    
    func testCreatesFileInDirectorySpecifiedByPath() throws {
        let directorManager = DirectoryManager(root: self.root!)
        XCTAssertTrue(directorManager.createFile(path: "projects", name: "new_file.py", content: "# some comment"))
        
        let found = directorManager.find(path: "projects/new_file.py")
        XCTAssertNotNil(found)
        XCTAssertEqual(found!.name, "new_file.py")
    }
    
    func testCreatesFileJustOffPath() throws {
        let directorManager = DirectoryManager(root: self.root!)
        XCTAssertTrue(directorManager.createFile(path: "projects/new_file.py", content: "# some comment"))
        
        let found = directorManager.find(path: "projects/new_file.py")
        XCTAssertNotNil(found)
        XCTAssertEqual(found!.name, "new_file.py")
    }

    func testCreatesFileReturnsFalseIfNoNameGiven() throws {
        let directorManager = DirectoryManager(root: self.root!)
        XCTAssertFalse(directorManager.createFile(path: "projects/", content: "# some comment"))
    }
    
    func testCreateFileReturnsFalseIfPathDoesNotExist() throws {
        let directorManager = DirectoryManager(root: self.root!)
        XCTAssertFalse(directorManager.createFile(path: "dev", name: "poc.py", content: "# some comment"))
    }
    
    func testCreateDirReturnsTrue() throws {
        let directorManager = DirectoryManager(root: self.root!)
        XCTAssertTrue(directorManager.createDir(path: "projects", name: "swift"))
        
        XCTAssertNotNil(directorManager.find(path: "projects/swift"))
    }
    
    func testCreateDirAtRootWhenNoPathProvided() throws {
        let directorManager = DirectoryManager(root: self.root!)
        XCTAssertTrue(directorManager.createDir(path: "", name: "swift"))
        
        XCTAssertNotNil(directorManager.find(path: "swift"))
    }

    func testAppendToFile() throws {
        let directorManager = DirectoryManager(root: self.root!)
        let _ = directorManager.appendToFile(path: "projects/poc.py", content: "\nbar")
        let file = directorManager.find(path: "projects/poc.py")
        XCTAssertEqual((file as! FileNode).content, "#foo\nbar")
    }
    
    func testAppendToFileReturnsFalseIfPathDoesNotPointToFile() throws {
        let directorManager = DirectoryManager(root: self.root!)
        XCTAssertFalse(directorManager.appendToFile(path: "projects", content: "\nbar"))
    }
    
    func testAppendToFileReturnsFalseIfFileDoesNotExist() throws {
        let directorManager = DirectoryManager(root: self.root!)
        XCTAssertFalse(directorManager.appendToFile(path: "projects/nofile", content: "\nbar"))
    }
    
    func testWriteToFile() throws {
        let directorManager = DirectoryManager(root: self.root!)
        let _ = directorManager.writeToFile(path: "projects/poc.py", content: "#bar")
        let file = directorManager.find(path: "projects/poc.py")
        XCTAssertEqual((file as! FileNode).content, "#bar")
    }
    
    func testDeleteFile() throws {
        let directorManager = DirectoryManager(root: self.root!)
        XCTAssertTrue(directorManager.deleteFile(path: "projects/poc.py"))
        let file = directorManager.find(path: "projects/poc.py")
        XCTAssertNil(file)
    }
    
}
