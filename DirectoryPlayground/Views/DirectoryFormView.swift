//
//  DirectoryFormView.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

struct DirectoryFormView: View {
    @EnvironmentObject var directoryManager: DirectoryManager
    @Binding var activeModal: ActiveModal?
    @State private var directoryName: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Directory Name")) {
                    TextField("directory", text: $directoryName)
                }
                Button(action: {
                    _ = directoryManager.createDir(path: "", name: directoryName)
                    activeModal = nil
                }) {
                    Text("Submit")
                }
            }
            .navigationTitle("New Directory")
            .navigationBarItems(leading: Button("Cancel") {
                activeModal = nil
            })
        }
        
    }
}

struct DirectoryFormView_Previews: PreviewProvider {
    static var previews: some View {
        DirectoryFormView(activeModal: .constant(nil))
    }
}
