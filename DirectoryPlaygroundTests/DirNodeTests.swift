//
//  DirNodeTests.swift
//  DirectoryPlaygroundTests
//
//  Created by Julietta Yaunches on 7/10/24.
//

import XCTest
@testable import DirectoryPlayground

final class DirNodeTests: XCTestCase {
    
    var root: DirectoryNode?
    var pocFileNode: FileNode?

    override func setUpWithError() throws {
        root = DirectoryNode(name: "~./", parent: nil)
        let projectsDir = root?.addDirectory(name: "projects")
        self.pocFileNode = projectsDir?.addFile(name: "poc.py", content: "#foo")
        _ = root?.addFile(name: "main.py", content: "#bar")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreatesFileInDirectorySpecifiedByPath() throws {
        //root?.addFile(name: <#T##String#>, content: <#T##String#>)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
