//
//  FileFormView.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

struct FileFormView: View {
    @Binding var activeModal: ActiveModal?
    @State private var filename: String = ""
    @State private var content: String = ""
    
    var body: some View {
        GeometryReader { geometry in
        NavigationView {
            Form {
                Section(header: Text("Filename")) {
                    TextField("filename", text: $filename)
                }
                
                Section(header: Text("Content")) {
                    TextEditor(text: $content)
                        .frame(height: geometry.size.height * 0.3)  // 30% of the parent view's height
                        .cornerRadius(5)
                }
                
                Button(action: {                    
                    activeModal = nil
                }) {
                    Text("Submit")
                }
            }
            .navigationTitle("New File")
            .navigationBarItems(leading: Button("Cancel") {
                activeModal = nil
            })
        }
        }
    }
}

struct FileFormView_Previews: PreviewProvider {
    static var previews: some View {
        FileFormView(activeModal: .constant(nil))
    }
}
