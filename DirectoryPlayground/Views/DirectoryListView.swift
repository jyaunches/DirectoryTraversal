//
//  DirectoryListView.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//
import SwiftUI

struct DirectoryListView: View {    
    @ObservedObject var root: DirNode
    @Binding var searchResults: [DirNode]
    
    var body: some View {
        if searchResults.count > 0 {
            List(searchResults, id: \.id) { node in
                SearchResultView(node: node)
            }
        } else {
            List(root.children, id: \.id) { node in
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
    
    return DirectoryListView(root: root, searchResults: .constant([]))
    
}

