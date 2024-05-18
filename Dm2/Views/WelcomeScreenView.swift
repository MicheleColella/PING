//  WelcomeScreenView.swift
//  Dm2
//
//  Created by Michele Colella on 18/05/24.
//

import SwiftUI

struct WelcomeScreen: View {
    @ObservedObject var viewModel: PathViewModel

    var body: some View {
        VStack {
            if viewModel.isActive {
                LineSelectionView(viewModel: viewModel)
            } else {
                Text("benvenuto a\nmunicipio")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .transition(.opacity)
                    .onAppear {
                        viewModel.activateWelcomeMessage()
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .foregroundColor(.white)
    }
}
