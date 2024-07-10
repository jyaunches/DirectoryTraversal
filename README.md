Directory Traversal App
-----------------------

Basic SwiftUI app used to explore SwiftUI basics. Contains multiple nested views utilizing ObservableObject protocol with @Published for views to receive state changes.
Within the views, using @State, @EnvironmentObject, @FocusState.

For the directory, using a tree structure with node instances that are responsible for managing their children. Nodes can be either directories or files.
