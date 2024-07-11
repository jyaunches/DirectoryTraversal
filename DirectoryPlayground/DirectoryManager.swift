//
//  DirectoryManager.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import Foundation

class DirectoryManager: ObservableObject {
    @Published var root: DirectoryNode = DirectoryNode(name: "/", parent: nil)
    
    init(root: DirectoryNode? = nil) {
        if let root = root {
            self.root = root
        }
    }
    
    func find(path: String) -> (any Node)? {
        let components = path == "" ? [] : path.components(separatedBy: "/")
            
        var curNode: (any Node)? = root
        for component in components {
            if let childMatch = (curNode as? DirectoryNode)?.childWith(name: component) {
                curNode = childMatch
            } else {
                return nil
            }
        }
            
        return curNode
    }
    
    func createFile(path: String, content: String) -> Bool {
        guard let reducedPath = getPathAndFile(path: path),
              let insertLoc = find(path: reducedPath.0),
              let _ = (insertLoc as? DirectoryNode)?.addFile(name: reducedPath.1, content: content) else { return false }
        
        return true
    }
    
    func createFile(path: String, name: String, content: String) -> Bool {
        guard let insertLoc = find(path: path),
              let _ = (insertLoc as? DirectoryNode)?.addFile(name: name, content: content) else { return false }
        
        return true
    }
    
    func createDir(path: String, name: String) -> Bool {
        guard let insertLoc = find(path: path),
            let _ = (insertLoc as? DirectoryNode)?.addDirectory(name: name) else { return false }
                
        return true
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
              (parent as? DirectoryNode)?.deleteChild(name: reducedPath.1) != nil else { return false }
        
        return true
    }
    
    func getMatches(partialText: String) -> [any Node] {
        return searchNodes(partialText: partialText, nodes: root.children)
    }
    
    private func searchNodes(partialText: String, nodes: [any Node]) -> [any Node] {
        var matchs: [any Node] = []
        for node in nodes {
            if node.name.localizedCaseInsensitiveContains(partialText) {
                matchs.append(node)
            } else if let node = node as? DirectoryNode {
                matchs.append(contentsOf: searchNodes(partialText: partialText, nodes: node.children))
            }
        }
        return matchs
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
