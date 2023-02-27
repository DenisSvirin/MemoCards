//
//  AfterGameView.swift
//  MemoCards
//
//  Created by Denis Svirin on 25.02.2023.
//

import SwiftUI

struct AfterGameView: View {
    let entity: FolderEntity
    let correct_guesses: Int
    let wrong_guesses: Int
    
    @Binding var currentDayProgress: Int
    let date = Date()
    let calendar = Calendar.current
    var body: some View {
        NavigationStack{
            ZStack{
                Color(red: 128/255, green: 138/255, blue: 159/255).edgesIgnoringSafeArea(.all)
                VStack(spacing: 30){
                    HStack{
                        
                        NavigationLink(destination: SetView(currentDayProgress: $currentDayProgress, entity: entity), label: {Image(systemName: "xmark")})
                            
                        Spacer()
                        
                        Text("Finished")
                            .fontWeight(.bold)
                            .kerning(3)
                        
                        Spacer()
                        
                        Spacer()
                            .frame(width: 30)
                        
                    }
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding(.top, 20)
                        .padding(.horizontal)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                            .frame(width: 340, height: 65)
                            .shadow(radius: 15)
                        
                        Text("Total cards: \(entity.cards?.count ?? 0)".uppercased())
                            .kerning(3)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                            
                            .shadow(radius: 15)
                        HStack{
                            if correct_guesses + wrong_guesses > 0{
                                Rate_Circle(frame_size: 130, completion: Float(100 * correct_guesses / (correct_guesses + wrong_guesses)), noText: false, lineWidth: 10)
                            }
                            else{
                                Rate_Circle(frame_size: 130, completion: 0.0, noText: false, lineWidth: 10)

                            }
                            
                            Spacer()
                            
                           
                                LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom)
                                    .mask(
                                        VStack{
                                            Text("KNOWN".uppercased())
                                                .font(.title3)
                                                .fontWeight(.semibold)
                                            
                                            Spacer()
                                            
                                            Text("\(correct_guesses) CARDS")
                                                .font(.headline)
                                        }
                                            .frame(height: 70)
                                        
                                            .kerning(3)
                                            .multilineTextAlignment(.center))
                            
                                .padding(.leading, 10)
                            
                        }
                        .padding(.horizontal, 30)
                    }
                    .frame(width: 340, height: 200)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                            .frame(width: 340, height: 200)
                            .shadow(radius: 15)
                        HStack{
                            Rate_Circle(color: LinearGradient(gradient: Gradient(colors: [Color(red: 241/255, green: 41/255, blue: 41/255), Color(red: 246/255, green: 224/255, blue: 18/255)]), startPoint: .top, endPoint: .bottom), frame_size: 130, completion: Float(100 * wrong_guesses / (correct_guesses + wrong_guesses)), noText: false, lineWidth: 10)
                            
                            Spacer()
                            
                            LinearGradient(gradient: Gradient(colors: [Color(red: 241/255, green: 41/255, blue: 41/255), Color(red: 246/255, green: 224/255, blue: 18/255)]), startPoint: .top, endPoint: .bottom)
                                .mask(
                                    VStack{
                                        Text("Learning".uppercased())
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                        
                                        Spacer()
                                        
                                        Text("\(wrong_guesses) CARDS")
                                            .font(.headline)
                                    }
                                        .frame(height: 70)
                                        
                                        .kerning(3)
                                        .multilineTextAlignment(.center))
                                .padding(.leading, 10)
                        }
                        .padding(.horizontal, 30)
                    }
                    .frame(width: 340, height: 200)
                    
                    NavigationLink(destination: SwipeCardsGameView(currentDayProgress: $currentDayProgress, entity: entity), label: {BlueButton(buttonText: "RESTART")
                            .frame(width:200, height: 65)
                    })
                        .kerning(3)
                        
                        
                    
                    
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: {
            print(currentDayProgress)
            if currentDayProgress < 4{
                currentDayProgress += 1}
        })
    }
}


