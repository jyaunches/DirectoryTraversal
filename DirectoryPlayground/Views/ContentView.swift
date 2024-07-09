//
//  ContentView.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

struct ContentView: View {
    var nodes: [DirNode]
    
    @State private var searchText = ""
    @State private var text: String = ""
    @FocusState private var isFocused: Bool
    
    @State private var activeModal: ActiveModal?
    
    var body: some View {
        VStack {        
            ZStack(alignment: .leading) {
                if !isFocused {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                }
                
                TextField("search", text: $text)
                    .padding(EdgeInsets(top: 8, leading: isFocused ? 8 : 30, bottom: 8, trailing: 8))
                    .background(Color.clear)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .focused($isFocused)
            }
            .padding()
            HStack {
                Button("Create File", action: {
                    activeModal = .fileForm
                })
                Button("Create Directory", action: {
                    activeModal = .directoryForm
                })
            }.padding()
            DirectoryListView(elements: nodes)
            
        }
        .padding()
        .sheet(item: $activeModal) { item in
            switch item {
            case .fileForm:
                FileFormView(activeModal: $activeModal)
            case .directoryForm:
                DirectoryFormView(activeModal: $activeModal)
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
    
    return ContentView(nodes: [root])
}
