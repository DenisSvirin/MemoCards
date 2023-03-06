//
//  EditCardView.swift
//  MemoCards
//
//  Created by Denis Svirin on 25.02.2023.
//

import SwiftUI

struct EditCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    let entity: CardEntity
    @State var s = ""
    @State var NewBackSide = ""
    @State var NewFrontSide = ""
    @State var ResetOpacity = 1.0
    var body: some View {
        NavigationStack{
            
            ZStack{
                Color(red: 128/255, green: 138/255, blue: 159/255).edgesIgnoringSafeArea(.all)
                ScrollView(showsIndicators: false){
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
                                        entity.question = NewBackSide
                                        entity.answer = NewFrontSide
                                        try? moc.save()
                                        presentationMode.wrappedValue.dismiss()
                                    }
                            }
                            
                        }
                        .foregroundColor(.white)
                        .font(.title2)
                        //.padding(.top, 20)
                        .padding(.horizontal, 30)
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                                .shadow(radius: 15)
                            
                            VStack{
                                Text("frontside".uppercased())
                                    .fontWeight(.bold)
                                    .font(.subheadline)
                                    .kerning(3)
                                    .padding(.top, 10)
                                
                                Spacer()
                                
                                TextEditor(text: $NewBackSide)
                                    .padding(.horizontal)
                                    .scrollContentBackground(.hidden)
                                    .background(Color(red: 2/255, green: 17/255, blue: 27/255))
                                    .frame(width: 300, height: 100)
                                    .overlay(RoundedRectangle(cornerRadius: 20)
                                        .stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom), lineWidth: 3))
                                
                                    .cornerRadius(20)
                                    .padding(.bottom, 20)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .frame(width: 370)
                        
                        BlueButton(buttonText: "swap", fontsize: .headline, buttonIcon:"rectangle.2.swap")
                            .frame(width: 130, height: 50)
                            .onTapGesture(perform: {
                                swapSides()
                            })
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                                .shadow(radius: 15)
                            
                            VStack{
                                Text("backside".uppercased())
                                    .fontWeight(.bold)
                                    .font(.subheadline)
                                    .kerning(3)
                                    .padding(.top, 10)
                                
                                Spacer()
                                
                                TextEditor(text: $NewFrontSide)
                                    .padding(.horizontal)
                                    .scrollContentBackground(.hidden)
                                    .background(Color(red: 2/255, green: 17/255, blue: 27/255))
                                    .frame(width: 300, height: 100)
                                    .overlay(RoundedRectangle(cornerRadius: 20)
                                        .stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom), lineWidth: 3))
                                
                                    .cornerRadius(20)
                                    .padding(.bottom, 20)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .frame(width: 370)
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                                .shadow(radius: 15)
                            HStack{
                                LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom)
                                    .mask(Text("known".uppercased())
                                        .kerning(3)
                                        .fontWeight(.bold)
                                        .font(.title3))
                                
                                Spacer()
                                
                                BlueButton(buttonText: "reset", fontsize: .callout)
                                    .frame(width: 80, height: 30)
                                    .opacity(ResetOpacity)
                                    .onTapGesture {
                                        ResetOpacity = 0.6
                                        entity.correct_guesses = 0
                                        entity.wrong_guesses = 0
                                    }
                                    
                                
                            }
                            .padding(.horizontal)
                        }
                        .frame(width: 370, height: 80)
                        Spacer()
                        
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    func swapSides(){
        
        let x = NewBackSide
        NewBackSide = NewFrontSide
        NewFrontSide = x
    }
}

