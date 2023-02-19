//
//  CardView.swift
//  MemoCards
//
//  Created by Denis Svirin on 16.02.2023.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 128/255, green: 138/255, blue: 159/255))
            HStack{
                VStack(alignment: .leading, spacing: 0, content: {
                    Text("Question")
                        .padding(.leading, 10)
                        .padding(.top, 20)
                    Spacer()
                    Text("Answer")
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                })
               
                Spacer()
                VStack {
                    EditButton()
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

struct EditButton: View {
    var body: some View {
        Image(systemName: "ellipsis.circle")
            .font(.system(size: 26))
            .padding(.top, 10)
    
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
