//
//  DirectoryListView.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

struct DirectoryListView: View {
    var elements: [DirNode] = [DirNode(type: .directory, path: "~/.")]
    
    var body: some View {
        List {
            ForEach(elements.indices, id: \.self) { index in
                let element = elements[0]
                switch element.type {
                case .directory:
                    FileView(text: type)
                case .file:
                    DirectoryView(text: type)
                }
            }
        }
    }
}

#Preview {
    DirectoryListView()
}
