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
    let subDir = root.addDirectory(name: "subdirectory")
    let _ = root.addFile(name: "File1.txt", content: "Content of File 1")
    let _ = subDir?.addFile(name: "File2.txt", content: "Content of File 2")
    
    return DirectoryListView(elements: [root])
    
}

