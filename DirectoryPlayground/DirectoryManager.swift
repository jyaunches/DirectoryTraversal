//
//  DirectoryManager.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import Foundation

//start 8:40
class DirectoryManager {
    var root: DirNode
    
    init(root: DirNode) {
        self.root = root
    }
    
    func find(path: String) -> DirNode? {
        return nil
    }
    
    func createFile(path: String, name: String, content: String) -> Bool {
        return false
    }
    
    func createDir(path: String, name: String, parent: DirNode) -> Bool {
        return false
    }
    
    func appendToFile(path: String, content: String) -> Bool {
        return false
    }
    
    func writeToFile(path: String, content: String) -> Bool {
        return false
    }
    
    func deleteFile(path: String, content: String) -> Bool {
        return false
    }
}
