//  LineSelectionView.swift
//  Dm2
//
//  Created by Michele Colella on 18/05/24.
//

import SwiftUI

struct LineSelectionView: View {
    @ObservedObject var viewModel: PathViewModel

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(viewModel.lines, id: \.self) { line in
                    Text(line.name)
                        .frame(width: geometry.size.width / 2, height: geometry.size.height)
                        .foregroundColor(.white)
                        .background(viewModel.selectedLine == line ? Color.gray : Color.black)
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let selectedLine = value.translation.width < 0 ? viewModel.lines.first : viewModel.lines.last
                        if let line = selectedLine {
                            viewModel.selectLine(line)
                        }
                    }
            )
            .background(
                NavigationLink(
                    destination: StationSelectionView(viewModel: viewModel, line: viewModel.selectedLine ?? viewModel.lines.first!),
                    isActive: $viewModel.shouldNavigateToStations,
                    label: { EmptyView() }
                )
            )
        }
    }
}
