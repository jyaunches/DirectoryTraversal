//
//  DirectoryManagerTests.swift
//  DirectoryPlaygroundTests
//
//  Created by Julietta Yaunches on 7/9/24.
//

import XCTest
@testable import DirectoryPlayground

final class DirectoryManagerTests: XCTestCase {

    var root: DirNode?
    var pocFileNode: DirNode?
    
    //              ~./
    //  projects/       main.py
    //  poc.py
    override func setUpWithError() throws {
        root = DirNode(type: .directory, name: "~./", parent: nil)
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
    
    func testCreatesFile() throws {
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

    func testCreatesFileReturnsFalseWithBadName() throws {
        let directorManager = DirectoryManager(root: self.root!)
        XCTAssertFalse(directorManager.createFile(path: "projects/", content: "# some comment"))
    }
    
    func testCreateFileReturnsFalseIfExistingFileAtSameLocation() throws {
        let directorManager = DirectoryManager(root: self.root!)
        XCTAssertFalse(directorManager.createFile(path: "projects", name: "poc.py", content: "# some comment"))
    }
    
    func testCreateFileReturnsTrueIfExistingDirectorWithNameAtSameLocation() throws {
        let directorManager = DirectoryManager(root: self.root!)
        XCTAssertTrue(directorManager.createDir(path: "projects", name: "python"))
        XCTAssertTrue(directorManager.createFile(path: "projects", name: "python", content: "# some comment"))
    }
    
    func testCreateDirReturnsTrue() throws {
        let directorManager = DirectoryManager(root: self.root!)
        XCTAssertTrue(directorManager.createDir(path: "projects", name: "swift"))
        
        XCTAssertNotNil(directorManager.find(path: "projects/swift"))
    }
    
    func testCreateDirReturnsFalseIfExistingDirAtSameLocation() throws {
        let directorManager = DirectoryManager(root: self.root!)
        XCTAssertTrue(directorManager.createDir(path: "projects", name: "swift"))
        XCTAssertFalse(directorManager.createDir(path: "projects", name: "swift"))
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
    
    func testFoo() throws {
        let root = DirNode(type: .directory, name: "Root", parent: nil)
        let subDir = root.addDirectory(name: "Subdirectory")
        _ = root.addFile(name: "File1.txt", content: "Content of File 1")
        _ = subDir?.addFile(name: "File2.txt", content: "Content of File 2")
        
        let dirManager = DirectoryManager(root: root)
            
        XCTAssertFalse(dirManager.createFile(path: "Subdirectory/File2.txt", content: "Anything"))
        XCTAssertTrue(dirManager.createFile(path: "Subdirectory/File3.txt", content: "Anything"))
    }
    
    func testNodeShouldProduceItsFullPathFromTheRoot() throws {
        let root = DirNode(type: .directory, name: "Root", parent: nil)
        let subDir = DirNode(type: .directory, name: "Subdirectory", parent: root)
        let file2 = FileNode(name: "File2.txt", content: "Content of File 2", parent: subDir)
        
        XCTAssertEqual(file2.displayPath, "/Root/Subdirectory/File2.txt")
    }    
}
