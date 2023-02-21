//
//  AddFolder.swift
//  MemoCards
//
//  Created by Denis Svirin on 21.02.2023.
//

import SwiftUI

struct AddFolderView: View {
    @EnvironmentObject var folderViewModel: FolderListViewModel
    @State var NewFolderName: String = ""
   
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            Color(red: 128/255, green: 138/255, blue: 159/255).edgesIgnoringSafeArea(.all)
            VStack{
                Text("Create new folder".uppercased())
                    .fontWeight(.bold)
                    .font(.system(size: 27))
                    .kerning(3)
                
                TextField("Type something here...", text: $NewFolderName)
                    .padding(.horizontal)
                    .frame(height: 55)
                    
                    .border(LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom), width: 3)
                    .cornerRadius(20)
                AddButton()
                    .padding(.top, 20)
                    .onTapGesture {
                        folderViewModel.Folders.append(MCFolder(FolderName: NewFolderName, Cards: []) )
                        presentationMode.wrappedValue.dismiss()
                        
                    }
                Spacer()
            }
            .padding(20)
            
        }
    }
}

