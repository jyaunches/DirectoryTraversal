//
//  DirNode.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import Foundation

enum DirType {
    case file
    case directory
}

class DirNode {
    var type: DirType
    var name: String
    private var parent: DirNode?    
    public private(set) var children: [DirNode] = []
    
    var id = UUID()
    
    var displayPath: String {
        var result = "/\(name)"
        var nextEval: DirNode? = parent
        
        while let op = nextEval {
            result = "/\(op.name)" + result
            nextEval = nextEval?.parent
        }
        return result
    }
    
    init(type: DirType, name: String, parent: DirNode?) {
        self.type = type
        self.name = name
        self.parent = parent
    }
    
    func addFile(name: String, content: String) -> FileNode? {
        guard name != "" else { return nil }
        
        if let _ = childWith(name: name, type: .file) {
            return nil
        }
        
        let file = FileNode(name: name, content: content, parent: self)
        self.children.append(file)
        return file
    }
    
    func addDirectory(name: String) -> DirNode? {
        guard name != "" else { return nil }
        
        if let _ = childWith(name: name, type: .directory) {
            return nil
        }
        
        let dir = DirNode(type: .directory, name: name, parent: self)
        self.children.append(dir)
        return dir
    }
    
    func childWith(name: String, type: DirType) -> DirNode? {
        return children.first(where: { $0.name == name && $0.type == type })
    }
    
    func childWith(name: String) -> DirNode? {
        return children.first(where: { $0.name == name })
    }
    
    func deleteChild(name: String) -> Bool {
        guard let index = children.firstIndex(where: { $0.name == name }) else { return false }
        children.remove(at: index)
        return true
    }
}

class FileNode: DirNode {
    var content: String
    
    init(name: String, content: String, parent: DirNode?) {
        self.content = content
        super.init(type: .file, name: name, parent: parent)
    }
}
