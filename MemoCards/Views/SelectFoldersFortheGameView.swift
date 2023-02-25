//
//  SelectFoldersFortheGameView.swift
//  MemoCards
//
//  Created by Denis Svirin on 25.02.2023.
//

import SwiftUI
/*
struct SelectFoldersFortheGameView: View {
    @FetchRequest(sortDescriptors: []) var folders: FetchedResults<FolderEntity>
    @State var foldersForTheGame: [FolderEntity] = []
    var body: some View {
        NavigationStack{
            ZStack{
                Color(red: 128/255, green: 138/255, blue: 159/255).edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false){
                    VStack{
                        NavigationLink(destination: SwipeCardsGameView(GameFolder: foldersForTheGame), label: {ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 110/255, green: 259/255, blue: 141/255), Color(red: 13/255, green: 236/255, blue: 235/255)]), startPoint: .top, endPoint: .bottom))
                                .frame(width: UIScreen.main.bounds.width - 70, height: 65)
                            Text("START".uppercased())
                                .fontWeight(.semibold)
                                .font(.title)
                                .foregroundColor(Color(red: 2/255, green: 17/255, blue: 27/255))
                                .kerning(3)
                        }})
                        
                        .frame(width: UIScreen.main.bounds.width)
                        .padding(.top, 25)
                        .background(
                            Circle()
                                .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                                .frame(width: 900, height: 900)
                                .padding(.bottom, 700)
                                .shadow(radius: 15))
                        Spacer()
                            .frame(height: 100)
                        ForEach(folders){Fname in
                            if foldersForTheGame.contains(Fname) {
                                FolderView(icon: Image(systemName: "checkmark.circle"), FolderName: Fname.name ?? "UNKNOWN", CardCount: Fname.cards?.count)
                                    .onTapGesture {
                                        if let index = foldersForTheGame.firstIndex(of: Fname) {
                                            foldersForTheGame.remove(at: index)
                                        }
                                        
                                    }
                            }
                            else{
                                FolderView(icon: Image(systemName: "circle"), FolderName: Fname.name ?? "UNKNOWN", CardCount: Fname.cards?.count)
                                
                                    .onTapGesture {
                                        foldersForTheGame.append(Fname)
                                    }
                            }
                        }
                        Spacer()
                        
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
            }
        }
    }
}

*/
