//
//  ContentView.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                SearchAndDirectoryListView()
            }
            .navigationTitle("Directory Explorer")
        }
    }
}


struct SearchAndDirectoryListView: View {
    @EnvironmentObject var directoryManager: DirectoryManager
    
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
            DirectoryListView(root: directoryManager.root)
            
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
        guard !searchText.isEmpty else { return directoryManager.root.children }
                
        return directoryManager.getMatches(partialText: searchText)
    }
    
    private func updateSearchMode() {
        searchMode = searchText.isEmpty ? .root : .search
    }
}

#Preview {
    
    let root = DirNode(type: .directory, name: "Root", parent: nil)
   
    let subDir = root.addDirectory(name: "subdirectory")
    let _ = root.addFile(name: "File1.txt", content: "Content of File 1")
    let _ = subDir?.addFile(name: "File2.txt", content: "Content of File 2")
    
    return ContentView().environmentObject(DirectoryManager(root: root))
}

