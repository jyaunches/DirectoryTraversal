//
//  DirNodeTests.swift
//  DirectoryPlaygroundTests
//
//  Created by Julietta Yaunches on 7/10/24.
//

import XCTest
@testable import DirectoryPlayground

final class NodeTests: XCTestCase {
    
    var root: DirectoryNode?
    var pocFileNode: FileNode?

    override func setUpWithError() throws {
        root = DirectoryNode(name: "~", parent: nil)
        let projectsDir = root?.addDirectory(name: "projects")
        self.pocFileNode = projectsDir?.addFile(name: "poc.py", content: "#foo")
        _ = root?.addFile(name: "main.py", content: "#bar")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPathOnNode() throws {
        XCTAssertEqual(self.pocFileNode?.displayPath, "~/projects/poc.py")
    }
    
    func testAddFileFailsIfExistingFileAtSameLocation() throws {
        XCTAssertNil(root?.addFile(name: "main.py", content: "some data"))
    }
    
    func testAddFileSuceedsIfExistingDirectoryAtSameLocation() throws {
        XCTAssertNotNil(root?.addFile(name: "projects", content: "some data"))
    }
    
    func testAddDirectoryFailsIfExistingDirectoryAtSameLocation() throws {
        XCTAssertNil(root?.addDirectory(name: "projects"))
    }
    
    func testAddDirectorySuceedsIfNoExistingDirectoryAtSameLocation() throws {
        XCTAssertNotNil(root?.addDirectory(name: "projects1"))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
