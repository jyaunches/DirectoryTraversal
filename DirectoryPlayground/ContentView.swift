//
//  ContentView.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var text: String = ""
    @FocusState private var isFocused: Bool
    
    @State private var activeModal: ActiveModal?
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                if !isFocused {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.red)
                        .padding(.leading, 8)
                }
                
                TextField("search", text: $text)
                    .padding(EdgeInsets(top: 8, leading: isFocused ? 8 : 30, bottom: 8, trailing: 8))
                    .background(Color.white)
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
    ContentView()
}
