//
//  DirectoryListView.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

struct DirectoryListView: View {
    var elements: [DirNode]
    
    var body: some View {
        Text("hello world")
        
        List(elements, id: \.id) { node in
            if node.type == .directory {
                DirectoryView(node: node)
            } else if let fileNode = node as? FileNode {
                FileView(node: fileNode)
            }
        }
    }
}

#Preview {
    
    let root = DirNode(type: .directory, name: "Root")
    let subDir = DirNode(type: .directory, name: "Sub Directory")
    let file1 = FileNode(name: "File1.txt", content: "Content of File 1")
    let file2 = FileNode(name: "File2.txt", content: "Content of File 2")

    root.addChild(subDir)
    root.addChild(file1)
    subDir.addChild(file2)

    return DirectoryListView(elements: [root])
    
}

