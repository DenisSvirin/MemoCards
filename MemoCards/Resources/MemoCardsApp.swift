//
//  MemoCardsApp.swift
//  MemoCards
//
//  Created by Denis Svirin on 12.02.2023.
//

import SwiftUI

@main
struct MemoCardsApp: App {
    @StateObject var folderListViewModel: FolderListViewModel = FolderListViewModel()
    
    var body: some Scene {
        WindowGroup {
                MainView()
                .environmentObject(folderListViewModel)
        }
    }
}
