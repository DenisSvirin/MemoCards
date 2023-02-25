//
//  deleteFoldersView.swift
//  MemoCards
//
//  Created by Denis Svirin on 23.02.2023.
//

import SwiftUI

struct DeleteFoldersView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var folders: FetchedResults<FolderEntity>
    @Binding var foldersToDelete: [FolderEntity]
    var body: some View {
        VStack{
            
            ForEach(folders){ Fname in
                if foldersToDelete.contains(Fname) {
                    FolderView(icon: Image(systemName: "checkmark.circle"), FolderName: Fname.name ?? "UNKNOWN", CardCount: Fname.cards?.count)
                        
                        .onTapGesture {
                            if let index = foldersToDelete.firstIndex(of: Fname) {
                                foldersToDelete.remove(at: index)
                            }
                            
                        }
                }
                else{
                    FolderView(icon: Image(systemName: "circle"), FolderName: Fname.name ?? "UNKNOWN", CardCount: Fname.cards?.count)
                        
                        .onTapGesture {
                            foldersToDelete.append(Fname)
                        }
                }
                
                
            }
        }
    }
}
