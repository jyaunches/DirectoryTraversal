//
//  ContentView.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

struct ContentView: View {
    var directoryManager: DirectoryManager
    
    @State private var searchText = ""
    @FocusState private var isFocused: Bool
    
    @State private var activeModal: ActiveModal?
    @State private var searchMode: ListType = .root
    
    var body: some View {
        VStack {        
            ZStack(alignment: .leading) {
                if !isFocused {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                }
                
                TextField("search", text: $searchText)
                    .padding(EdgeInsets(top: 8, leading: isFocused ? 8 : 30, bottom: 8, trailing: 8))
                    .background(Color.clear)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .focused($isFocused)
                    .onChange(of: searchText) { newValue in
                        updateSearchMode()
                    }
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
            DirectoryListView(elements: filteredNodes(), mode: searchMode)
            
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
    
    private func filteredNodes() -> [DirNode] {
        guard !searchText.isEmpty else { return [directoryManager.root] }
                
        let filtered = getMatches(in: [directoryManager.root])
        return filtered
    }
    
    private func updateSearchMode() {
          searchMode = searchText.isEmpty ? .root : .search
      }

    private func getMatches(in searchNodes: [DirNode]) -> [DirNode] {
        var matchs: [DirNode] = []
        for node in searchNodes {
            if node.name.localizedCaseInsensitiveContains(searchText) {
                matchs.append(node)
            }
            matchs.append(contentsOf: getMatches(in: node.children))
        }
        return matchs
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
    
    return ContentView(directoryManager: DirectoryManager(root: root))
}
