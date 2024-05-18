//  WelcomeScreenView.swift


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
