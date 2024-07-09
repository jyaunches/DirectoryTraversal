//
//  DirectoryManager.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import Foundation

//start 8:40 / restarted 11:30
class DirectoryManager {
    var root: DirNode
    
    init(root: DirNode) {
        self.root = root
    }
    
    func find(path: String) -> DirNode? {
        let components = path.components(separatedBy: "/")
        guard components.count > 0 else { return nil }
            
        var curNode = root
        for component in components {
            if let childMatch = curNode.children.first(where: { $0.name == component }) {
                curNode = childMatch
            } else {
                return nil
            }
        }
            
        return curNode
    }
    
    func createFile(path: String, content: String) -> Bool {
        guard let reducedPath = getPathAndFile(path: path),
              let insertLoc = findInsertLocation(path: reducedPath.0, name: reducedPath.1, type: .directory) else { return false }
        
        insertLoc.addChild(FileNode(name: reducedPath.1, content: content))
        return true
    }
    
    func createFile(path: String, name: String, content: String) -> Bool {
        guard let insertLoc = findInsertLocation(path: path, name: name, type: .file) else { return false }
        
        insertLoc.addChild(FileNode(name: name, content: content))
        return true
    }
    
    func createDir(path: String, name: String) -> Bool {
        guard let insertLoc = findInsertLocation(path: path, name: name, type: .directory) else { return false }
        
        insertLoc.addChild(DirNode(type: .directory, name: name))
        return true
    }
    
    private func findInsertLocation(path: String, name: String, type: DirType) -> DirNode? {
        guard let insertLocation = find(path: path),
            name != "" else { return nil }
        
        if let _ = insertLocation.children.first(where: { $0.name == name && $0.type == type }) {
            return nil
        }
        return insertLocation
    }
    
    func appendToFile(path: String, content: String) -> Bool {
        guard let existingFile = find(path: path) as? FileNode else { return false }
        existingFile.content.append(content)
        return true
    }
    
    func writeToFile(path: String, content: String) -> Bool {
        guard let existingFile = find(path: path) as? FileNode else { return false }
        existingFile.content = content
        return true
    }
    
    func deleteFile(path: String) -> Bool {
        guard let reducedPath = getPathAndFile(path: path),
              let parent = find(path: reducedPath.0),
              let child = parent.children.first(where: { $0.name == reducedPath.1 }) else { return false }

        parent.children.removeAll(where: { $0.name == reducedPath.1 })
        return true
    }
    
    private func getPathAndFile(path: String) -> (String, String)? {
        guard let lastIndex = path.lastIndex(of: "/") else {
            return nil
        }
                
        let splitIndex = path.index(after: lastIndex)
                
        let initialPath = String(path[..<lastIndex])
        let fileName = String(path[splitIndex...])
        
        return (initialPath, fileName)
    }
}
