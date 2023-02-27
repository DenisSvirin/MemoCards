//
//  SetView.swift
//  MemoCards
//
//  Created by Denis Svirin on 16.02.2023.
//

import SwiftUI

struct SetView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State var showSettings: Bool = false
    @State var test : Bool = false
    @State var ShowDeleteMenu : Bool = false
    @State private var cardsToDelete: [CardEntity] = []
    let columns: [GridItem] = [
        GridItem(.fixed(170), spacing: nil, alignment: nil),
        GridItem(.fixed(170), spacing: nil, alignment: nil)
    ]
    let entity: FolderEntity
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color(red: 128/255, green: 138/255, blue: 159/255).edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false){
                    VStack{
                        
                        
                        HStack{
                            
                            NavigationLink(destination: MainView(), label: {
                            Image(systemName: "arrow.backward")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.title2)
                            })
                            
                            Spacer()
                            
                            Text(entity.name ?? "UNKNOWN")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .frame(height: 80)
                                
                            
                            Spacer()
                            
                            Image(systemName: "gear")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.title2)
                                .onTapGesture {
                                    showSettings.toggle()
                                }
                            
                        }
                         
                        
                            .font(.headline)
                        //.padding(.top)
                            .padding(.horizontal)
                            .background(Circle()
                                .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                                .frame(width: 850, height: 850)
                                .shadow(radius: 20))
                                //.padding(.bottom, 200))
                         
                        
                        Set_Header(entity: entity)
                            .frame(width: 390)
                            .padding(.top, 10)
                             
                                //))
                            //
                        
                        if ShowDeleteMenu{
                            SetDeletehView(Show_menu: $ShowDeleteMenu, cardsToDelete: $cardsToDelete)
                                .frame(width: UIScreen.main.bounds.width - 50, height: 65)
                                .padding(.top, 80)
                            
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
                            .padding(.top, 80)
                            
                        }
                                               
                        
                        
                        
                        VStack{
                            LazyVGrid(columns: columns){
                                if let cards = entity.cards?.allObjects as? [CardEntity] {
                                    ForEach(cards) {card in
                                        if ShowDeleteMenu {
                                            DeleteCardsView(card: card, cardsToDelete: $cardsToDelete)
                                        }
                                        else{
                                            NavigationLink(destination: EditCardView(entity: card, NewBackSide: card.question ?? "?", NewFrontSide:card.answer ?? "?"), label: {
                                                CardView(question: card.question ?? "?", answer: card.answer ?? "?", correct_guesses: Int(card.correct_guesses), wrong_guesses: Int(card.wrong_guesses))
                                                    .foregroundColor(.white)
                                            })
                                        }
                                    }
                                    
                                    .shadow(radius: 10)
                                    .padding(.top, 10)
                                }
                            }
                            
                            
                        }
                        Spacer()
                    }
                    
                    
                }
            }
            .kerning(3)
            .sheet(isPresented: $showSettings, content: {EditFolderView( newName: entity.name ?? "", SR: Float(entity.attempts != 0 ? 100 * entity.successRate / entity.attempts : 0),LR: Float(entity.cards?.count ?? 0 != 0 ? 100 * getLearntAmount() / (entity.cards?.count ?? 0): 0), entity: entity )})
        }
        .navigationBarHidden(true)
    }
    func getLearntAmount() -> Int{
        var result = 0
        if let cards = entity.cards?.allObjects as? [CardEntity] {
            for card in cards {
                if card.correct_guesses > 4{
                    result += 1
                }
                
            }
        }
        return result
    }
    
}


struct Set_Header: View {
    let entity: FolderEntity
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Rate_Circle(frame_size: 140, completion: Float(entity.attempts != 0 ? 100 * entity.successRate / entity.attempts : 0), noText: false, lineWidth: 10)
                    
                    Text("SUCCESS")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.top, 15)
                }
                .frame( height: 140)
                .padding(.leading, 30)
                
                Spacer()
                
                VStack{
                    Rate_Circle(frame_size: 140, completion: Float(entity.cards?.count ?? 0 != 0 ? 100 * getLearntAmount() / (entity.cards?.count ?? 0): 0), noText: false, lineWidth: 10)
                    
                    Text("LEARNED")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.top, 15)
                }
                .frame( height: 140)
                .padding(.trailing, 30)
            }
            .padding(.top, 35)
            
            NavigationLink(destination: SwipeCardsGameView(entity: entity), label: {BlueButton(buttonText: "LEARN")
                    .frame(width: 200, height: 65)
                    .padding(.top, 20)
            } )
                    .padding(.top, 35)
        }
        
    }
    func getLearntAmount() -> Int{
        var result = 0
        if let cards = entity.cards?.allObjects as? [CardEntity] {
            for card in cards {
                if card.correct_guesses > 4{
                    result += 1
                }
                
            }
        }
        return result
    }
}

struct Rate_Circle: View {
    var color: LinearGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom)
    var frame_size: CGFloat
    var completion: Float
    var noText: Bool
    var lineWidth: CGFloat
    var body: some View {
        ZStack{
            Circle()
                .trim(from: 0, to: 1)
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth))
                .opacity(0.13)
            Circle()
                .trim(from: 0, to: CGFloat(completion / 100) )
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth))
                
                
            color
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
