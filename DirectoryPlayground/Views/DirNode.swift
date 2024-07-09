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
    
    var children: [DirNode] = []
    
    var id = UUID()
    
    init(type: DirType, name: String) {
        self.type = type
        self.name = name
    }
    
    func addChild(_ node: DirNode) {
        self.children.append(node)
    }
}

class FileNode: DirNode {
    var content: String
    
    init(name: String, content: String) {
        self.content = content
        super.init(type: .file, name: name)        
    }
}
