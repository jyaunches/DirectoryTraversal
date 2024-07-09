//
//  DirectoryPlaygroundApp.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import SwiftUI

@main
struct DirectoryPlaygroundApp: App {
    
    
    
    var root: DirNode {
        let root = DirNode(type: .directory, name: "Root", parent: nil)
        let subDir = DirNode(type: .directory, name: "Sub Directory", parent: root)
        let file1 = FileNode(name: "File1.txt", content: "Content of File 1", parent: root)
        let file2 = FileNode(name: "File2.txt", content: "Content of File 2", parent: subDir)

        root.addChild(subDir)
        root.addChild(file1)
        subDir.addChild(file2)
        
        return root
    }
    
    var body: some Scene {
        
        
        WindowGroup {
            
            
            
            ContentView(directoryManager: DirectoryManager(root: root))
        }
    }
}
