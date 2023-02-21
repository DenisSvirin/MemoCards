//
//  SetView.swift
//  MemoCards
//
//  Created by Denis Svirin on 16.02.2023.
//

import SwiftUI

struct SetView: View {
    
    @State var test : Bool = false
    @State var test1 : Bool = false
    
    var body: some View {
        
        ZStack{
            Color(red: 128/255, green: 138/255, blue: 159/255).edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false){
                VStack{
                    Set_Header()
                        .padding(.top, 70)
                        .background(Circle()
                            
                            .fill(Color(red: 2/255, green: 17/255, blue: 27/255))
                            .frame(width: 750,height: 750)
                            .padding(.bottom, 370))
                        .shadow(radius: 20)
                    
                    HStack{
                        SearchButton()
                            .frame(width: 65)
                        
                        Spacer()
                        
                        AddButton()
                        
                        Spacer()
                        
                        DeleteButton()
                            .frame(width: 65)
                    }
                        .frame(width: UIScreen.main.bounds.width - 50, height: 65)
                        .padding(.top, 110)
                    
                
                    HStack{  CardView().shadow(radius: 10)
                        CardView().shadow(radius: 10) }
                        .padding(.top, 30)
                    HStack{  CardView().shadow(radius: 10)
                        CardView().shadow(radius: 10) }
                        .padding(.top, 10)
                    HStack{  CardView().shadow(radius: 10)
                        CardView().shadow(radius: 10) }
                        .padding(.top, 10)
                    
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
            }
        }
        .kerning(3)
    }
}


struct Set_Header: View {
    var body: some View {
        HStack{
            VStack{
                Rate_Circle(frame_size: 140, completion: 100, noText: false, lineWidth: 10)
                    
                Text("SUCCESS")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
            }
            .frame( height: 140)
            .padding(.leading, 30)
            
            Spacer()
            
            VStack{
                Rate_Circle(frame_size: 140, completion: 100, noText: false, lineWidth: 10)
                    
                Text("LEARNED")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
            }
            .frame( height: 140)
            .padding(.trailing, 30)
        }
        
    }
}

struct Rate_Circle: View {
    var frame_size: CGFloat
    var completion: Float
    var noText: Bool
    var lineWidth: CGFloat
    var body: some View {
        ZStack{
            Circle()
                .trim(from: 0, to: CGFloat(completion / 100) )
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom), style: StrokeStyle(lineWidth: lineWidth))
                
                
            LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 231/255, blue: 79/255), Color(red: 228/255, green: 239/255, blue: 24/255)]), startPoint: .top, endPoint: .bottom)
                .mask(
                    Text(noText ? "" : String(completion) + "%")
                .font(.system(size: 23))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 2/255, green: 17/255, blue: 27/255)))
        }
        .frame(width: frame_size, height: frame_size)
    }
}
     

struct SetView_Previews: PreviewProvider {
    static var previews: some View {
        Rate_Circle(frame_size: 140, completion: 100, noText: false, lineWidth: 10)
            .previewLayout(.sizeThatFits)
    }
}
