//
//  CardView.swift
//  MemoCards
//
//  Created by Denis Svirin on 16.02.2023.
//

import SwiftUI

struct CardView: View {
    var icon: Image = Image(systemName: "ellipsis.circle")
    let question: String
    let answer: String
    let correct_guesses: Int
    let wrong_guesses: Int
   
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 128/255, green: 138/255, blue: 159/255))
            HStack{
                VStack(alignment: .leading, spacing: 0, content: {
                    Text(question)
                        .padding(.leading, 10)
                        .padding(.top, 20)
                    Spacer()
                    Text(answer)
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                })
               
                Spacer()
                VStack {
                    TopRightButtonCardView(icon: icon)
                    Spacer()
                    Rate_Circle(frame_size: 22, completion: 100, noText: true, lineWidth: 4)
                        .padding(.bottom, 10)
                }
                .padding(.trailing, 10)
                
            }
            .frame(width: 170, alignment: .leading)
                
    }
        .frame(width: 170, height: 100)
    }
}

struct TopRightButtonCardView: View {
    let icon: Image
    var body: some View {
       icon
            .font(.system(size: 26))
            .padding(.top, 10)
    
    }
}



