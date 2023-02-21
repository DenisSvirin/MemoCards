//
//  AddButton.swift
//  MemoCards
//
//  Created by Denis Svirin on 21.02.2023.
//

import SwiftUI

struct AddButton: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
            .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom))
            .frame(width: 140, height: 65)
            
            .shadow(radius: 10, y:6)
       
            Text("Add")
            .fontWeight(.semibold)
            .font(.system(size: 25))
            .foregroundColor(Color(red: 2/255, green: 17/255, blue: 27/255))
        }
    }
}
