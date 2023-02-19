//
//  FolderView.swift
//  MemoCards
//
//  Created by Denis Svirin on 11.02.2023.
//

import SwiftUI

struct FolderView: View {
    var body: some View {
        let block_width = UIScreen.main.bounds.size.width - 70
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 128/255, green: 138/255, blue: 159/255))
                .shadow(radius: 10, y:10)
                
            HStack{
                Image(systemName: "folder.fill")
                    .padding(.leading, 20)
                    .font(.system(size: 25))
                Spacer()
                Text("Untitled")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(.trailing, block_width / 4 - 40)
                Spacer()
                Text("53")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(.trailing, 25)
                
            }
        }
        .frame(width: block_width, height: 65)
        .foregroundColor(Color(red: 2/255, green: 17/255, blue: 27/255))
    }
}




struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView()
    }
}
