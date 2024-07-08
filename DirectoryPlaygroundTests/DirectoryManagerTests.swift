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
        root = DirNode(type: .directory, path: "~./")
        let projectsDir = DirNode(type: .directory, path: "projects/")
        self.pocFileNode = DirNode(type: .file, path: "poc.py")
        root?.addChild(projectsDir)
        root?.addChild(DirNode(type: .file, path: "main.py"))
        projectsDir.addChild(self.pocFileNode!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFindsNodeGivenAPath() throws {
        let directorManager = DirectoryManager(root: self.root!)
        let pocFileNode = directorManager.find(path: "poc.py")
        XCTAssertEqual(pocFileNode, self.pocFileNode)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
