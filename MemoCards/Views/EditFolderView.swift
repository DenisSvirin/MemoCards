//
//  EditFolderView.swift
//  MemoCards
//
//  Created by Denis Svirin on 25.02.2023.
//

import SwiftUI

struct EditFolderView: View {
    @State var newName: String = ""
    @State var SR: Float
    @State var LR: Float
    @State var ResetOpacitySR = 1.0
    @State var ResetOpacityLR = 1.0
    
    let entity: FolderEntity
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        ZStack{
            Color(red: 128/255, green: 138/255, blue: 159/255).edgesIgnoringSafeArea(.all)
            
            ScrollView{
                VStack(spacing: 30){
                    HStack{
                        
                        Image(systemName: "xmark")
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                        
                      Spacer()
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom))
                                .frame(width: 80, height: 30)
                            
                                .shadow(radius: 10, y:6)
                            
                            Text("SAVE")
                                .fontWeight(.semibold)
                                .font(.title3)
                                .foregroundColor(Color(red: 2/255, green: 17/255, blue: 27/255))
                                .onTapGesture {
                                    presentationMode.wrappedValue.dismiss()
                                    entity.name = newName
                                    try? moc.save()
                                   
                                   
                                }
                        }
                        
                    }
                    .foregroundColor(.white)
                    .font(.title2)
                    //.padding(.top, 20)
                    .padding(.horizontal, 30)
                    
                    Text("NEW FOLDER NAME")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .kerning(3)
                    
                    TextField("New Folder name".uppercased(), text: $newName)
                        .foregroundColor(.white)
                        .font(.title3)
                        .kerning(3)
                        .padding(.horizontal)
                        .frame(width: 340, height: 55)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom), lineWidth: 3))
                    
                        .cornerRadius(20)
                        .padding(.horizontal, 40)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                        
                            .shadow(radius: 15)
                        
                        VStack{
                            Text("Reset Success rate".uppercased())
                                .kerning(3)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top, 20)
                            
                            HStack{
                                Rate_Circle(frame_size: 130, completion: SR, noText: false, lineWidth: 7)
                                
                                Spacer()
                                
                                VStack{
                                    Text("SUCCESS RATE shows what percentage of games u knew more than 50% of cards")
                                        .foregroundColor(.gray)
                                        .font(.headline)
                                        .frame(width:150)
                                        .multilineTextAlignment(.center)
                                    
                                    BlueButton(buttonText: "reset", fontsize: .headline)
                                        .frame(width: 70, height: 30)
                                        .opacity(ResetOpacitySR)
                                        .onTapGesture {
                                            ResetOpacitySR = 0.6
                                            entity.successRate = 0
                                            entity.attempts = 0
                                        }
                                }
                            }
                            .padding(.top, 10)
                            .padding(.horizontal)
                            
                            Spacer()
                        }
                    }
                    .frame(width: 340, height: 260)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                        
                            .shadow(radius: 15)
                        
                        VStack{
                            Text("Reset Learnt rate".uppercased())
                                .kerning(3)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top, 20)
                            
                            HStack{
                                Rate_Circle(frame_size: 130, completion: LR, noText: false, lineWidth: 7)
                                
                                Spacer()
                                
                                VStack{
                                    Text("LEARNT RATE shows what percentage of cards you have learnt out of the whole set")
                                        .foregroundColor(.gray)
                                        .font(.headline)
                                        .frame(width:150)
                                        .multilineTextAlignment(.center)
                                    
                                    BlueButton(buttonText: "reset", fontsize: .headline)
                                        .frame(width: 70, height: 30)
                                        .opacity(ResetOpacityLR)
                                        .onTapGesture {
                                            ResetOpacityLR = 0.6
                                            if let cards = entity.cards?.allObjects as? [CardEntity] {
                                                for card in cards{
                                                    card.correct_guesses = 0
                                                    card.wrong_guesses = 0
                                                }
                                            }
                                            
                                             
                                        }
                                }
                            }
                            .padding(.top, 10)
                            .padding(.horizontal)
                            
                            Spacer()
                        }
                    }
                    .frame(width: 340, height: 260)
                    
                    Spacer()
                }
            }
            .padding(.top, 30)
        }
    }
}

