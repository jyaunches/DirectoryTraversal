//
//  ContentView.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

enum ActiveModal: Identifiable {
    case directoryForm
    case fileForm

    var id: Int {
        hashValue
    }
}

struct ContentView: View {
    @EnvironmentObject var directoryManager: DirectoryManager
    
    @State private var searchText = ""
    @State private var activeModal: ActiveModal?
    @State private var searchResults: [any Node] = []
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationView {
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
                            searchResults = filteredNodes()
                        }
                }
                .padding()
                HStack {
                    Button("Create File", action: { activeModal = .fileForm })
                    Button("Create Directory", action: { activeModal = .directoryForm })
                }.padding()
                DirectoryListView(root: directoryManager.root, searchResults: $searchResults)
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
            .navigationTitle("Directory Explorer")
        }
    }
    
    private func filteredNodes() -> [any Node] {
        guard !searchText.isEmpty else { return [] }
                
        return directoryManager.getMatches(partialText: searchText)
    }
}

#Preview {
    let root = DirectoryNode(name: "~", parent: nil)
   
    let subDir = root.addDirectory(name: "subdirectory")
    let _ = root.addFile(name: "File1.txt", content: "Content of File 1")
    let _ = subDir?.addFile(name: "File2.txt", content: "Content of File 2")
    
    return ContentView().environmentObject(DirectoryManager(root: root))
}
