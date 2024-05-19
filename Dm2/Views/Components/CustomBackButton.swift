//
//  CustomBackButton.swift
//  Dm2
//
//  Created by Salvatore Attanasio on 19/05/24.
//

import SwiftUI

struct CustomBackButton: View {
    var action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 30, height: 40)
                .foregroundStyle(.white)
                Spacer()
            }
            Spacer()
        }
        .onTapGesture {
            action()
        }
        .padding(.leading)
    }
}

#Preview {
    CustomBackButton(){}
        .background(
            Color.black
        )
}
