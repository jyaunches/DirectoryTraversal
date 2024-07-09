//
//  DirectoryPlaygroundApp.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

@main
struct DirectoryPlaygroundApp: App {
    
    @StateObject private var directoryManager = DirectoryManager(root: mockData())
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(directoryManager)
        }
    }
    
    
}
func mockData() -> DirNode {
    let root = DirNode(type: .directory, name: "Root", parent: nil)
    let subDir = root.addDirectory(name: "subdirectory")
    let _ = root.addFile(name: "File1.txt", content: "Content of File 1")
    let _ = subDir?.addFile(name: "File2.txt", content: "Content of File 2")
    
    return root
}
