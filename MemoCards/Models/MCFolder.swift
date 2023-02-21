//
//  MCFolder.swift
//  MemoCards
//
//  Created by Denis Svirin on 21.02.2023.
//

import Foundation

struct MCFolder: Identifiable {
    let id: String = UUID().uuidString
    let FolderName: String
    let Cards: [Card]

}
