//  StationSelectionView.swift
//  Dm2
//
//  Created by Michele Colella on 18/05/24.
//

import SwiftUI

struct StationSelectionView: View {
    @ObservedObject var viewModel: PathViewModel
    var line: Line

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(line.stations, id: \.self) { station in
                    Text(station)
                        .frame(width: geometry.size.width / 2, height: geometry.size.height)
                        .foregroundColor(.white)
                        .background(viewModel.selectedStation == station ? Color.gray : Color.black)
                        .onTapGesture {
                            viewModel.selectStation(station)
                        }
                }
            }
            
            // Stessa logica di sicurezza per la navigazione
            .background(
                viewModel.selectedStation != nil ?
                NavigationLink(
                    destination: PathFindView(destination: viewModel.selectedStation ?? "N/A"),
                    isActive: $viewModel.navigationTrigger,
                    label: { EmptyView() }
                ) : nil
            )
        }
    }
}
