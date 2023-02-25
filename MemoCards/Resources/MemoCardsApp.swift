//
//  MemoCardsApp.swift
//  MemoCards
//
//  Created by Denis Svirin on 12.02.2023.
//

import SwiftUI

@main
struct MemoCardsApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            
            MainView()
                
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
