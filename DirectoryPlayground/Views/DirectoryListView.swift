//
//  DirectoryListView.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

enum ListType {
    case root, search
}


struct DirectoryListView: View {
    var elements: [DirNode]
    var mode: ListType = .root
    
    var body: some View {
        switch(mode) {
        case .search:
            List(elements, id: \.id) { node in
                SearchResultView(node: node)
            }
            
        case .root:
            List(elements, id: \.id) { node in
                if node.type == .directory {
                    DirectoryView(node: node)
                } else if let fileNode = node as? FileNode {
                    FileView(node: fileNode)
                }
            }
        }
    }
}

#Preview {
    
    let root = DirNode(type: .directory, name: "Root", parent: nil)
    let subDir = DirNode(type: .directory, name: "Sub Directory", parent: root)
    let file1 = FileNode(name: "File1.txt", content: "Content of File 1", parent: root)
    let file2 = FileNode(name: "File2.txt", content: "Content of File 2", parent: subDir)

    root.addChild(subDir)
    root.addChild(file1)
    subDir.addChild(file2)

    return DirectoryListView(elements: [root])
    
}

