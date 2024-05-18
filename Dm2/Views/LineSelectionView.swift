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
                        .onTapGesture {
                            viewModel.selectLine(line)
                        }
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let line = value.translation.width < 0 ? viewModel.lines.first : viewModel.lines.last
                        if let safeLine = line {
                            viewModel.selectLine(safeLine)
                        }
                    }
            )
            // Usa l'opzionale per la navigazione
            .background(
                viewModel.selectedLine != nil ?
                NavigationLink(
                    destination: StationSelectionView(viewModel: viewModel, line: viewModel.selectedLine!),
                    isActive: $viewModel.navigationTrigger,
                    label: { EmptyView() }
                ) : nil
            )
        }
    }
}
