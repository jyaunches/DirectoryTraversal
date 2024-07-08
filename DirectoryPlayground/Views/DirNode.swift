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

class DirNode: Equatable {
    var type: DirType
    var path: String
    var children: [DirNode] = []
    
    init(type: DirType, path: String) {
        self.type = type
        self.path = path
    }
    
    func addChild(_ node: DirNode) {
        self.children.append(node)
    }
    
    static func == (lhs: DirNode, rhs: DirNode) -> Bool {
        return lhs.path == rhs.path && lhs.type == rhs.type
    }
}
