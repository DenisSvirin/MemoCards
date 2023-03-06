//
//  SwipeCardsGameView.swift
//  MemoCards
//
//  Created by Denis Svirin on 23.02.2023.
//

import SwiftUI

struct SwipeCardsGameView: View {
    @State var offset: CGSize = .zero
    @State var isFlipped: Bool = false
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var correct_gueses = 0
    @State var wrong_gueses = 0
    @Binding var currentDayProgress: Int
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    let entity: FolderEntity
    @State var cardIndex = 0
    var body: some View {
        NavigationStack{
            ZStack{
                Color(red: 128/255, green: 138/255, blue: 159/255).edgesIgnoringSafeArea(.all)
                
                    if let cards = entity.cards?.allObjects as? [CardEntity] {
                         
                        if cardIndex < cards.count{
                            VStack{
                                HStack{
                                    Image(systemName: "arrow.backward")
                                        .onTapGesture {
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                    
                                    Spacer()
                                    
                                    Text("\(cardIndex + 1)/\(cards.count)")
                                    
                                    Spacer()
                                    
                                    Image(systemName: "gear")
                                    
                                }
                                .font(.title2)
                                .padding(.top, 20)
                                .padding(.horizontal)
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                                        .frame(width: min(370 ,UIScreen.main.bounds.width - 50), height: 500)
                                        .padding(.top, 20)
                                    
                                    //backside
                                    PlayingCardView(entity:entity, card: cards[cardIndex], flipped: false, isFlipped: $isFlipped, backDegree: $backDegree, frontDegree:  $frontDegree, cardIndex: $cardIndex, offset: $offset, correct_gueses: $correct_gueses, wrong_gueses: $wrong_gueses)
                                        .foregroundColor(.white)
                                        .shadow(radius: 15)
                                        .rotation3DEffect(Angle(degrees: backDegree), axis: (x:0, y:1, z:0))
                                        .onTapGesture {
                                            flipCard()
                                        }
                                    // frontside
                                    PlayingCardView(entity:entity, card: cards[cardIndex], flipped: true, isFlipped: $isFlipped,backDegree: $backDegree, frontDegree:  $frontDegree, cardIndex: $cardIndex, offset: $offset, correct_gueses: $correct_gueses, wrong_gueses: $wrong_gueses)
                                        .foregroundColor(.white)
                                        .shadow(radius: 15)
                                        .rotation3DEffect(Angle(degrees: frontDegree), axis: (x:0, y:1, z:0))
                                        .onTapGesture {
                                            flipCard()
                                        }
                                }
                                //.shadow(radius: 15)
                                Spacer()
                            }
                           
                        }
                            else{
                                AfterGameView(entity: entity, correct_guesses: correct_gueses, wrong_guesses: wrong_gueses, currentDayProgress: $currentDayProgress)
                                
                            }
                    }
            }

        }
        .navigationBarHidden(true)
    }
    
    func flipCard(){
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: 0.3)){
                backDegree = 90
            }
            withAnimation(.linear(duration: 0.3).delay(0.3)){
                frontDegree = 0
            }
        }
        else{
            withAnimation(.linear(duration: 0.3)){
                frontDegree = -90
            }
            withAnimation(.linear(duration: 0.3).delay(0.3)){
                backDegree = 0
            }
        }
    }
}

struct PlayingCardView: View {
    @Environment(\.managedObjectContext) var moc
    let entity: FolderEntity
    let card: CardEntity
    var flipped: Bool
    @Binding var isFlipped: Bool
    @Binding var backDegree: Double
    @Binding var frontDegree: Double
    @Binding var cardIndex: Int
    @Binding var offset: CGSize
    @Binding var correct_gueses: Int
    @Binding var wrong_gueses: Int
    
    
    var body: some View {
      
            ZStack{
                if offset.width < 0 {
                    ZStack{
                        CardFrame(offset: $offset, color: LinearGradient(gradient: Gradient(colors: [Color(red: 241/255, green: 41/255, blue: 41/255), Color(red: 246/255, green: 224/255, blue: 18/255)]), startPoint: .top, endPoint: .bottom))
                        
                    }
                }
                else{
                    CardFrame(offset: $offset, color: LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom))
                }
               
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                            .frame(width: min(370 ,UIScreen.main.bounds.width - 50), height: 500)
                            .padding(.top, 20)
                        if flipped {
                            Text(card.answer ?? "?")
                                .opacity(1 - getOpacityAmount())
                                .frame(width: 300, height: 500)
                                .multilineTextAlignment(.center)
                        }
                        else{
                            Text(card.question ?? "?")
                                .opacity(1 - getOpacityAmount())
                                .frame(width: 300, height: 500)
                                .multilineTextAlignment(.center)
                        }
                        if offset.width > 0{
                               Text("KNOW")
                                .foregroundColor(Color(red: 19/255, green: 231/255, blue: 79/255))
                                    .kerning(3)
                                    .fontWeight(.bold)
                                    .font(.title2)
                                    .opacity(getOpacityAmount())
                            
                        }
                        else{
                            Text("LEARN")
                                .foregroundColor(Color(red: 241/255, green: 41/255, blue: 41/255))
                                .kerning(3)
                                .fontWeight(.bold)
                                .font(.title2)
                                .opacity(getOpacityAmount())
                        
                        }
                            
                    }
                    .scaleEffect(getScaleAmount())
                    .rotationEffect(Angle(degrees: getRotationAmount()))
                    .offset(offset)
                    .gesture(DragGesture()
                        .onChanged {value in
                            withAnimation(.spring()) {
                                offset = value.translation
                            }
                        }
                        .onEnded {value in
                            withAnimation(.spring()) {
                                flyingCard()
                            }
                            offset = .zero
                        })
                }
        
    }
    
    func getScaleAmount() -> CGFloat{
        let maxA = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / maxA
        return 1.0 - min(percentage, 0.5) / 3
    }
    
    func getOpacityAmount() -> CGFloat{
        let maxA = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / maxA
        return percentage * 2
    }
    
    func getRotationAmount() -> Double{
        let maxA = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / maxA
        let percetageAsDouble = Double(percentage)
        let maxAngle: Double = 5
        return percetageAsDouble * maxAngle
    }
    
    func flyingCard() -> Void{
        
        if abs(offset.width) > UIScreen.main.bounds.width * 0.4 {
            offset =  CGSize(width: UIScreen.main.bounds.width / 2 + 300, height: offset.height)
            cardIndex += 1
            card.correct_guesses += 1
            correct_gueses += 1
            if isFlipped{
                flipCard()
            }
            if correct_gueses > wrong_gueses && entity.cards?.count ?? 0 <= cardIndex {
                
                entity.successRate += 1
                entity.attempts += 1
            }
            
            else if entity.cards?.count ?? 0 <= cardIndex{
                entity.attempts += 1
            }
                    
            try? moc.save()
            return
        }
        else if offset.width < -UIScreen.main.bounds.width * 0.4 {
            offset =  CGSize(width: -UIScreen.main.bounds.width / 2 - 300, height: offset.height)
            cardIndex += 1
            card.wrong_guesses += 1
            wrong_gueses += 1
            if entity.cards?.count ?? 0 <= cardIndex{
                entity.attempts += 1
            }
            return
        }
              
        offset =  .zero
    }
    func flipCard(){
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: 0.3)){
                backDegree = 90
            }
            withAnimation(.linear(duration: 0.3).delay(0.3)){
                frontDegree = 0
            }
        }
        else{
            withAnimation(.linear(duration: 0.3)){
                frontDegree = -90
            }
            withAnimation(.linear(duration: 0.3).delay(0.3)){
                backDegree = 0
            }
        }
    }
}

struct CardFrame :View{
    @Binding var offset: CGSize
    let color: LinearGradient
    var body: some View{
        
            RoundedRectangle(cornerRadius: 20)
                .stroke(color, style: StrokeStyle(lineWidth: 5))
        .frame(width: min(370 ,UIScreen.main.bounds.width - 50), height: 500)
        .opacity(getOpacityAmount())
        .padding(.top, 20)
        .scaleEffect(getScaleAmount())
        .rotationEffect(Angle(degrees: getRotationAmount()))
        .offset(offset)
        .gesture(DragGesture()
            .onChanged {value in
                withAnimation(.spring()) {
                    offset = value.translation
                }
            }
                 
            .onEnded {value in
                withAnimation(.spring()) {
                    offset = .zero
                }
            })
    }
    func getScaleAmount() -> CGFloat{
        let maxA = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / maxA
        return 1.0 - min(percentage, 0.5) / 3
    }
    
    func getOpacityAmount() -> CGFloat{
        let maxA = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / maxA
        return percentage * 1.7
    }
    
    func getRotationAmount() -> Double{
        let maxA = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / maxA
        let percetageAsDouble = Double(percentage)
        let maxAngle: Double = 5
        return percetageAsDouble * maxAngle
    }
}
