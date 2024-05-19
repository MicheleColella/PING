//
//  SelectionView.swift
//  Dm2
//
//  Created by Salvatore Attanasio on 19/05/24.
//

import SwiftUI

struct SelectionView: View {
    var choice1 : String
    var choice2 : String
    @Binding var selection : String
    
    init(selection: Binding<String>, beetween choice1: String, and choice2: String){
        self._selection  = selection
        self.choice1    = choice1
        self.choice2    = choice2
    }
    
    func option(text: String, size: CGSize) -> some View{
        return VStack {
            Spacer()
            Text(text)
                .font(.custom("AgrandirVariable_Bold", size: 60))
                .lineLimit(1)
                .frame(minWidth: size.height, minHeight: size.width)
                .rotationEffect(.degrees(90))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            Spacer()
        }
        .frame(minWidth: size.width, minHeight: size.height)
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                option(text: choice1, size: CGSize(
                    width: geometry.size.width / 2,
                    height: geometry.size.height)
                )
                .foregroundColor(.black)
                //.background(Color.white)
                option(text: choice2, size: CGSize(
                    width: geometry.size.width / 2,
                    height: geometry.size.height)
                )
                .foregroundStyle(.white)
                //.background(Color.black)
            }
//            .gesture(
//                DragGesture()
//                    .onEnded { swipe in
//                        if swipe.translation.width < 0{
//                            selection = choice1
//                        } else {
//                            selection = choice2
//                        }
//                    }
//            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SelectionView(selection: .constant(""), beetween: "Option 1", and: "Option 2")
    .background(
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
            Color.black
            Color.white
                .frame(width: 200)
        })
        .ignoresSafeArea()
    )
}
