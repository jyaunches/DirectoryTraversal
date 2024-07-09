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
    var parent: DirNode?
    
    var children: [DirNode] = []
    
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
    
    func addChild(_ node: DirNode) {
        self.children.append(node)
    }
}

class FileNode: DirNode {
    var content: String
    
    init(name: String, content: String, parent: DirNode?) {
        self.content = content
        super.init(type: .file, name: name, parent: parent)
    }
}
