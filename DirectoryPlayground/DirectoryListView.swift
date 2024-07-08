//
//  DirectoryListView.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

struct DirectoryListView: View {
    var elements: [DirNode] = [DirNode(type: .directory("main"))]
    
    var body: some View {
        List {
            ForEach(elements.indices, id: \.self) { index in
                switch elements[index].type {
                case .directory(let type):
                    FileView(text: type)
                case .file(let type):
                    DirectoryView(text: type)
                }
            }
        }
    }
}

#Preview {
    DirectoryListView()
}
