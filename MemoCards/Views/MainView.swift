//
//  SwiftUIView.swift
//  MemoCards
//
//  Created by Denis Svirin on 11.02.2023.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State var Show_delete_menu = false
    @State var Show_search_bar = false
    @State private var foldersToDelete: [FolderEntity]  = []
    @FetchRequest(sortDescriptors: []) var folders: FetchedResults<FolderEntity>
    
    @State var c:Int = 0
    var body: some View {
        NavigationStack{
            ZStack{
                Color(red: 128/255, green: 138/255, blue: 159/255).edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false){
                    VStack{
                        Home_Header()
                            .background(
                                Circle()
                                    .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                                    .frame(width: 750, height: 750)
                                    .padding(.bottom, 370))
                            .shadow(radius: 10, y: 6)
                        
                        if Show_delete_menu{
                            Delete_menu(Show_menu: $Show_delete_menu, foldersToDelete: $foldersToDelete)
                                .frame(width: UIScreen.main.bounds.width - 50, height: 65)
                                .padding(.top, 80)
                        }
                        else if Show_search_bar{
                            Search_bar(Show_search_bar: $Show_search_bar)
                                .frame(width: UIScreen.main.bounds.width - 50, height: 65)
                                .padding(.top, 80)
                        }
                        else{
                            Folders_control_buttons(Show_menu: $Show_delete_menu, Show_search_bar: $Show_search_bar)
                                .frame(width: UIScreen.main.bounds.width - 50, height: 65)
                                .padding(.top, 80)
                        }
                        
                        
                        
                        
                        
                        
                        
                        // .foregroundColor(Color(red: 2/255, green: 17/255, blue: 27/255))
                        
                        Spacer()
                            .frame(height: 20)
                        if Show_delete_menu{
                            DeleteFoldersView(foldersToDelete: $foldersToDelete)
                        }
                        else{
                            ForEach(folders){ Fname in
                                //Text(Fname.FolderName)
                                NavigationLink(destination: SetView(entity: Fname), label: {
                                    if let cards = Fname.cards?.allObjects as? [CardEntity]{
                                        FolderView(FolderName: Fname.name ?? "UNKNOWN", CardCount: cards.count )}})
                                //FolderView(FolderName: Fname.name ?? "UNKNOWN", CardCount: c)
                                //.onTapGesture(perform: {moc.delete(Fname)
                                //try? moc.save()})
                                
                            }
                        }
                        Spacer()
                        
                        
                        
                        
                        
                    }
                    .kerning(4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    
                    
                }
            }
        }
    }
}

struct Home_Header: View {
    var body: some View {
            VStack{
                HStack{
                    Text("MemoCards")
                        .fontWeight(.semibold)
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "gear")
                        .fontWeight(.semibold)
                        .font(.system(size:25))
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                
                Weekly_goal_progress_bar()
                    .frame(width: UIScreen.main.bounds.width - 50 - 80)
                    .padding(.top, 20)
                
                Button("LEARN SETS"){}
                    .fontWeight(.semibold)
                    .font(.system(size: 27))
                    .foregroundColor(Color(red: 2/255, green: 17/255, blue: 27/255))
                    .frame(width: UIScreen.main.bounds.width - 70, height: 65)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(red: 110/255, green: 259/255, blue: 141/255), Color(red: 13/255, green: 236/255, blue: 235/255)]), startPoint: .top, endPoint: .bottom).cornerRadius(20))
                    .padding(.top, 30)
            }
    }
}


struct Weekly_goal_progress_bar: View {
     var body: some View {
        HStack{
            ForEach(0..<7){ index in
                 
                Spacer()
                 
                ZStack{
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom), style: StrokeStyle(lineWidth: 4))
                        .frame(width:20, height: 110)
                                
                    RoundedRectangle(cornerRadius: 3)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom))
                        .frame(width:10, height: 100)
                }
                
                Spacer()
            }
        }
    }
}

struct Folders_control_buttons: View {
    @Binding var Show_menu:Bool
    @Binding var Show_search_bar : Bool
    var body: some View {
        HStack{
            SearchButton()
            .frame(width: 65, height: 65)
            .onTapGesture {
                withAnimation(.default){
                    Show_search_bar.toggle()
                }
                
            }
            
            Spacer()
            NavigationLink(destination: AddFolderView(), label: {AddButton()})
            
            
                
            
            Spacer()
            
            DeleteButton()
            .frame(width: 65, height: 65)
            
            .onTapGesture {
                withAnimation(.default){
                    Show_menu.toggle()
                }
            }
        }
    }
}

struct Search_bar: View {
    @Binding var Show_search_bar : Bool
    var body: some View {
        HStack{
            
            RoundedRectangle(cornerRadius: 20)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 241/255, green: 41/255, blue: 41/255), Color(red: 246/255, green: 224/255, blue: 18/255)]), startPoint: .top, endPoint: .bottom), style: StrokeStyle(lineWidth: 3))
                
                .shadow(radius: 10, y:6)
                .fontWeight(.semibold)
                .font(.system(size: 25))
                .frame(width: UIScreen.main.bounds.width - 50 - 65 - 10)
                
                .foregroundColor(Color(red: 2/255, green: 17/255, blue: 27/255))
                //.shadow(radius: 10, y:6)
            
            Spacer()
            
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 241/255, green: 41/255, blue: 41/255), Color(red: 246/255, green: 224/255, blue: 18/255)]), startPoint: .top, endPoint: .bottom))
                    .shadow(radius: 10, y:6)
                Image(systemName: "xmark")
                    .fontWeight(.semibold)
                    .font(.system(size: 25))
                    .foregroundColor(Color(red: 2/255, green: 17/255, blue: 27/255))
            }
            .frame(width: 65)
            .onTapGesture {
                withAnimation(.default){
                    Show_search_bar.toggle()
                }
            }
            
        }
        
    }
}

struct Delete_menu: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var Show_menu : Bool
    @Binding var foldersToDelete: [FolderEntity]
    var body: some View {
        HStack{
            
            Button("Delete"){
                for folder in foldersToDelete {
                    moc.delete(folder)
                    try? moc.save()
                }
            }
                .fontWeight(.semibold)
                .font(.system(size: 25))
                .frame(width: UIScreen.main.bounds.width - 50 - 65 - 10, height: 65)
                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 241/255, green: 41/255, blue: 41/255), Color(red: 246/255, green: 224/255, blue: 18/255)]), startPoint: .top, endPoint: .bottom).cornerRadius(20))
                .foregroundColor(Color(red: 2/255, green: 17/255, blue: 27/255))
                .shadow(radius: 10, y:6)
            
            Spacer()
            
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 241/255, green: 41/255, blue: 41/255), Color(red: 246/255, green: 224/255, blue: 18/255)]), startPoint: .top, endPoint: .bottom))
                    .shadow(radius: 10, y:6)
                Image(systemName: "xmark")
                    .fontWeight(.semibold)
                    .font(.system(size: 25))
                    .foregroundColor(Color(red: 2/255, green: 17/255, blue: 27/255))
            }
            .frame(width: 65)
            .onTapGesture {
                withAnimation(.default){
                    Show_menu.toggle()
                }
                
            }
            
        }
        
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
