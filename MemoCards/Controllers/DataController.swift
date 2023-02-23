//
//  DataController.swift
//  MemoCards
//
//  Created by Denis Svirin on 23.02.2023.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "MemoCards")
    @Published var folders: [FolderEntity] = []
    
    init(){
        container.loadPersistentStores{description ,error in
            if let error = error{
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
        func addFolder(){
            let newFolder = FolderEntity(context: container.viewContext)
            newFolder.name = "Folder"
            
        }
    }
}
