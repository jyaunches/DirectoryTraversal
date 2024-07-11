//
//  DirNode.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import Foundation

protocol Node: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var parent: DirectoryNode? { get }
}

extension Node {
    var displayPath: String {
        var result = "/\(name)"
        var nextEval: DirectoryNode? = parent
        
        while let op = nextEval {
            result = "/\(op.name)" + result
            nextEval = nextEval?.parent
        }
        return result
    }
}

class DirectoryNode: Node, ObservableObject {
    let id = UUID()
    var name: String
    internal var parent: DirectoryNode?    
    @Published public private(set) var children: [any Node] = []
    
    init(name: String, parent: DirectoryNode?) {
        self.name = name
        self.parent = parent
    }
    
    func addFile(name: String, content: String) -> FileNode? {
        guard name != "" else { return nil }
        
        if let _ = childWith(name: name, type: FileNode.self) {
            return nil
        }
        
        let file = FileNode(name: name, content: content, parent: self)
        self.children.append(file)
        return file
    }
    
    func addDirectory(name: String) -> DirectoryNode? {
        guard name != "" else { return nil }
        
        if let _ = childWith(name: name, type: DirectoryNode.self) {
            return nil
        }
        
        let dir = DirectoryNode(name: name, parent: self)
        self.children.append(dir)
        return dir
    }
    
    func childWith<T: Node>(name: String, type: T.Type) -> T? {
        return children.first(where: { $0.name == name && ($0 as? T) != nil }) as? T
    }
    
    func childWith(name: String) -> (any Node)? {
        return children.first(where: { $0.name == name })
    }
    
    func deleteChild(name: String) -> Bool {
        guard let index = children.firstIndex(where: { $0.name == name }) else { return false }
        children.remove(at: index)
        return true
    }
}

class FileNode: Node {
    let id = UUID()
    var name: String
    internal var parent: DirectoryNode?
    var content: String
    
    init(name: String, content: String, parent: DirectoryNode?) {
        self.content = content
        self.name = name
        self.parent = parent        
    }
}
