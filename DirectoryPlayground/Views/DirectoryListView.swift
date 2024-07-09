//
//  DirectoryListView.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

struct DirectoryListView: View {
    var elements: [DirNode] = [DirNode(type: .directory, name: "~/")]
    
    var body: some View {
        Text("hello world")
//        List {
//            ForEach(elements.indices, id: \.self) { index in
//                let element = elements[index]
//                switch element.path {
//                case .directory(let path):
//                    DirectoryView(text: path)
//                case .file(let path):
//                    FileView(text: path)
//                }
//            }
//        }
    }
}

#Preview {
    DirectoryListView()
}
