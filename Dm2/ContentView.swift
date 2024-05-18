//
//  ContentView.swift
//  Dm2
//
//  Created by Salvatore Attanasio on 07/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PathViewModel()

    var body: some View {
        NavigationView {
            WelcomeScreen(viewModel: viewModel)
        }
    }
}



#Preview {
    ContentView()
}
