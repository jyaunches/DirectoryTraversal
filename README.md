# Directory Traversal App

Basic SwiftUI app managing a simple, in-memory file system. 

## Directory Data Structure

For the directory, using a tree structure with node instances that are responsible for managing their children. Nodes can be either directories or files.

Selected to represent common behavior across directories & views using a protocol, Node. This protocol has an extension for common functions these two may share. The FileNode and DirectoryNode are classes, enabling them to easily implement @ObservableObject and have SwiftUI bindings setup.

## SwiftUI 

#### State Setup
- Multiple nested views utilizing @ObservedObject to observe various levels of the directory
- @Binding used to sync search results with child views
- @EnvironmentObject used to maintain reference to the DirectoryManager throughout the views

#### Components Used
- NavigationView, VStack, HStack, TextField, DisclosureGroup, List, ForEach

## Features

- On app launch, list all files and directories, showig nested relationships
- Ability to search across directories and files
- Add a new file
- Add a new directory

## Unit Tests

Unit tests are divided between testing the Node objects and testing the functionality maintained in the DirectoryManager. Redundancy between these is kept minimal but in some cases may be unavoidable to enable full coverage on the DirectoryManager.


