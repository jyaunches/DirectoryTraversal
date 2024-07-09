//
//  FileView.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

struct FileView: View {
    var node: FileNode

    var body: some View {
        Text("📄 \(node.name)")
    }
}

struct DirectoryView: View {
    @ObservedObject var node: DirNode
    
    var body: some View {
        DisclosureGroup(isExpanded: .constant(true)) {
            ForEach(node.children, id: \.id) { child in
                if child.type == .directory {
                    DirectoryView(node: child)
                } else if let fileNode = child as? FileNode {
                    FileView(node: fileNode)
                }
            }
        } label: {
            Text("📁 \(node.name)")
        }
    }
}

struct SearchResultView: View {
    var node: DirNode

    var body: some View {
        Text("📄 \(node.displayPath)")
    }
}
