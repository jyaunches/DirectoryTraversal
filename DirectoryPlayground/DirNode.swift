//
//  DirNode.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import Foundation

enum DirType {
    case file(String)
    case directory(String)
}

class DirNode {
    var type: DirType
    
    init(type: DirType) {
        self.type = type
    }
}
