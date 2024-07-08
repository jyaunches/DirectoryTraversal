//
//  ActiveModal.swift
//  DirectoryPlayground
//
//  Created by Julietta Yaunches on 7/8/24.
//

import Foundation

enum ActiveModal: Identifiable {
    case directoryForm
    case fileForm

    var id: Int {
        hashValue
    }
}
