//
//  SearchButton.swift
//  MemoCards
//
//  Created by Denis Svirin on 21.02.2023.
//

import SwiftUI

struct SearchButton: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 241/255, green: 41/255, blue: 41/255), Color(red: 246/255, green: 224/255, blue: 18/255)]), startPoint: .top, endPoint: .bottom), style: StrokeStyle(lineWidth: 4))
                .shadow(radius: 10, y:6)
            
            LinearGradient(gradient: Gradient(colors: [Color(red: 241/255, green: 41/255, blue: 41/255), Color(red: 246/255, green: 224/255, blue: 18/255)]), startPoint: .top, endPoint: .bottom)
                .mask(Image(systemName: "magnifyingglass")
                .fontWeight(.semibold)
                .font(.system(size: 25)))
        }
    }
}

struct SearchButton_Previews: PreviewProvider {
    static var previews: some View {
        SearchButton()
    }
}
