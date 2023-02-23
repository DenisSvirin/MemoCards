//
//  AddCardView.swift
//  MemoCards
//
//  Created by Denis Svirin on 23.02.2023.
//

import SwiftUI

struct AddCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State var question: String = ""
    @State var answer: String = ""
    let entity: FolderEntity
    var body: some View {
        ZStack{
            Color(red: 128/255, green: 138/255, blue: 159/255).edgesIgnoringSafeArea(.all)
            VStack{
                Text("Create new card".uppercased())
                    .fontWeight(.bold)
                    .font(.system(size: 27))
                    .foregroundColor(.white)
                    .kerning(3)
                    .background(
                        Circle()
                            .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                            .frame(width: 900, height: 900)
                            .padding(.bottom, 780))
                    .shadow(radius: 10, y: 6)
                VStack{
                    HStack{
                        Text("FRONTSIDE".uppercased())
                            .fontWeight(.bold)
                            .font(.subheadline)
                        .kerning(3)
                        
                        Spacer()
                    }
                    TextField("Type your question", text: $question)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom), lineWidth: 3))
                    
                        .cornerRadius(20)
                    
                    Spacer()
                    
                    HStack{
                        Text("BACKSIDE".uppercased())
                            .fontWeight(.bold)
                            .font(.subheadline)
                        .kerning(3)
                        
                        Spacer()
                    }
                   
                    TextField("Type your answer", text: $answer)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom), lineWidth: 3))
                    
                        .cornerRadius(20)
                        
                }
            
                .frame(width: UIScreen.main.bounds.width - 50, height: 200)
                .padding(.top, 30)
                
                AddButton()
                    .padding(.top, 30)
                    .onTapGesture {
                        let newCard = CardEntity(context: moc)
                        newCard.question = question
                        newCard.answer = answer
                        newCard.correct_guesses = 0
                        newCard.wrong_guesses = 0
                        newCard.folder = entity
                        
                        try? moc.save()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35, execute: {
                            presentationMode.wrappedValue.dismiss()
                            
                        })
                        
                       
                    }
                    
                
                Spacer()
            }
            
        }
    }
}

