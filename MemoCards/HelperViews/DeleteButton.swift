//
//  DeleteButton.swift
//  MemoCards
//
//  Created by Denis Svirin on 21.02.2023.
//

import SwiftUI

struct DeleteButton: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
            
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 241/255, green: 41/255, blue: 41/255), Color(red: 246/255, green: 224/255, blue: 18/255)]), startPoint: .top, endPoint: .bottom), style:StrokeStyle(lineWidth: 4))
                
            LinearGradient(gradient: Gradient(colors: [Color(red: 241/255, green: 41/255, blue: 41/255), Color(red: 246/255, green: 224/255, blue: 18/255)]), startPoint: .top, endPoint: .bottom)
                .mask(Image(systemName: "trash")
                .fontWeight(.semibold)
                .font(.system(size: 25)))
                //.foregroundColor(Color(red: 2/255, green: 17/255, blue: 27/255))
        }
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton()
    }
}
