//
//  SelectionSplitView.swift
//  Dm2
//
//  Created by Salvatore Attanasio on 19/05/24.
//

import SwiftUI

struct SelectionSplitView: View {
    var option1 : String
    var option2 : String
    
    init(beetween option1: String, and option2: String){
        self.option1    = option1
        self.option2    = option2
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
                option(text: option1, size: CGSize(
                    width: geometry.size.width / 2,
                    height: geometry.size.height)
                )
                .foregroundColor(.black)
                option(text: option2, size: CGSize(
                    width: geometry.size.width / 2,
                    height: geometry.size.height)
                )
                .foregroundStyle(.white)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SelectionSplitView(beetween: "Option 1", and: "Option 2")
    .background(
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
            Color.black
            Color.white
                .frame(width: 200)
        })
        .ignoresSafeArea()
    )
}
