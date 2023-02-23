//
//  SetView.swift
//  MemoCards
//
//  Created by Denis Svirin on 16.02.2023.
//

import SwiftUI

struct SetView: View {
    @Environment(\.managedObjectContext) var moc
    @State var test : Bool = false
    @State var ShowDeleteMenu : Bool = false
    @State private var cardsToDelete: [CardEntity] = []
    let columns: [GridItem] = [
        GridItem(.fixed(170), spacing: nil, alignment: nil),
        GridItem(.fixed(170), spacing: nil, alignment: nil)
    ]
    let entity: FolderEntity
    
    var body: some View {
        
        ZStack{
            Color(red: 128/255, green: 138/255, blue: 159/255).edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false){
                VStack{
                    Set_Header(entity: entity)
                        .padding(.top, 10)
                        .background(Circle()
                                    
                            .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                            .frame(width: 750,height: 750)
                            .padding(.bottom, 370))
                        .shadow(radius: 20)
                    
                    if ShowDeleteMenu{
                        SetDeletehView(Show_menu: $ShowDeleteMenu, cardsToDelete: $cardsToDelete)
                            .frame(width: UIScreen.main.bounds.width - 50, height: 65)
                            .padding(.top, 110)
                            
                    }
                    else{
                        HStack{
                            SearchButton()
                                .frame(width: 65)
                            
                            Spacer()
                            
                            NavigationLink(destination: AddCardView(entity: entity), label: {AddButton()})
                            
                            Spacer()
                            
                            DeleteButton()
                                .frame(width: 65)
                                .onTapGesture {
                                    ShowDeleteMenu.toggle()
                                }
                            
                        }
                        .frame(width: UIScreen.main.bounds.width - 50, height: 65)
                        .padding(.top, 110)
                        
                    }
                    
                    
                    /*
                     
                     }*/
                    
                    
                    ScrollView{
                        LazyVGrid(columns: columns){
                            if let cards = entity.cards?.allObjects as? [CardEntity] {
                                ForEach(cards) {card in
                                    if ShowDeleteMenu {
                                        DeleteCardsView(card: card, cardsToDelete: $cardsToDelete)
                                    }
                                    else{
                                        CardView(question: card.question ?? "?", answer: card.answer ?? "?", correct_guesses: Int(card.correct_guesses), wrong_guesses: Int(card.wrong_guesses))
                                    }
                                }
                                .frame(height: 100)
                                .shadow(radius: 10)
                                .padding(.top, 10)
                            }
                        }
                        
                    
                }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
            }
        }
        .kerning(3)
    }
}


struct Set_Header: View {
    let entity: FolderEntity
    var body: some View {
        VStack{
            Text(entity.name ?? "UNKNOWN")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.title)
            HStack{
                VStack{
                    
                    
                    Rate_Circle(frame_size: 140, completion: 100, noText: false, lineWidth: 10)
                    
                    Text("SUCCESS")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.top, 15)
                }
                .frame( height: 140)
                .padding(.leading, 30)
                
                Spacer()
                
                VStack{
                    Rate_Circle(frame_size: 140, completion: 50, noText: false, lineWidth: 10)
                    
                    Text("LEARNED")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.top, 15)
                }
                .frame( height: 140)
                .padding(.trailing, 30)
            }.padding(.top, 35)
        }
    }
}

struct Rate_Circle: View {
    var frame_size: CGFloat
    var completion: Float
    var noText: Bool
    var lineWidth: CGFloat
    var body: some View {
        ZStack{
            Circle()
                .trim(from: 0, to: 1)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom), style: StrokeStyle(lineWidth: lineWidth))
                .opacity(0.13)
            Circle()
                .trim(from: 0, to: CGFloat(completion / 100) )
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom), style: StrokeStyle(lineWidth: lineWidth))
                
                
            LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom)
                .mask(
                    Text(noText ? "" : String(completion) + "%")
                .font(.system(size: 23))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 2/255, green: 17/255, blue: 27/255)))
        }
        .frame(width: frame_size, height: frame_size)
    }
}

struct SetDeletehView: View {
        @Environment(\.managedObjectContext) var moc
        @Binding var Show_menu : Bool
        @Binding var cardsToDelete: [CardEntity]
        var body: some View {
            HStack{
                
                Button("Delete"){
                    for card in cardsToDelete {
                        moc.delete(card)
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
struct SetSearchView: View {
    var body: some View {
            Text("f")
    }
}

struct SetView_Previews: PreviewProvider {
    static var previews: some View {
        Rate_Circle(frame_size: 140, completion: 100, noText: false, lineWidth: 10)
            .previewLayout(.sizeThatFits)
    }
}
