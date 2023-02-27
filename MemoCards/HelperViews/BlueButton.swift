//
//  LearnSetsButton.swift
//  MemoCards
//
//  Created by Denis Svirin on 23.02.2023.
//

import SwiftUI

struct BlueButton: View {
    let buttonText: String
    var fontsize = Font.title
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 110/255, green: 259/255, blue: 141/255), Color(red: 13/255, green: 236/255, blue: 235/255)]), startPoint: .top, endPoint: .bottom))
                
            Text(buttonText.uppercased())
                .fontWeight(.semibold)
                .font(fontsize)
                .foregroundColor(Color(red: 2/255, green: 17/255, blue: 27/255))
        }
    }
}
