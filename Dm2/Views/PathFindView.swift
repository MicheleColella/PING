//  ContentView.swift


import SwiftUI

struct PathFindView: View {
    @StateObject var viewModel = PathViewModel()
    var destination: String

    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(Color.white)
                .scaleEffect(viewModel.scale)
                .animation(.easeInOut(duration: 0.5), value: viewModel.scale)
                .accessibility(hidden: true)
            
            VStack(alignment: .leading) {
                Spacer()

                Text("direzione")
                    .font(.custom("AgrandirVariable_Bold", size: 25.6))
                    .foregroundColor(.white)
                    .blendMode(.difference)
                    .accessibility(hidden: true)
                
                Text(viewModel.destinationName)
                    .font(.custom("AgrandirVariable_Bold", size: 60))
                    .foregroundColor(.white)
                    .blendMode(.difference)
                    .accessibility(hidden: true)

                Spacer()
            }.rotationEffect(.degrees(90))
            .accessibility(hidden: true)
            
            .onAppear {
                viewModel.startPath(destinationName: destination)
            }
            .onDisappear {
                        // Reset del trigger quando l'utente naviga via dalla vista del percorso
                        viewModel.resetNavigation()
                    }
        }
    }
}

struct PathFindView_Previews: PreviewProvider {
    static var previews: some View {
        PathFindView(viewModel: PathViewModel(), destination: "Margellina")
    }
}
