//
//  DestinationSelectionView.swift
//  Dm2
//
//  Created by Salvatore Attanasio on 19/05/24.
//

import SwiftUI

struct DestinationSelectionView: View {
    
    enum ScreenState{
        case scrollingToLeft
        case scrollingToRight
        case selectedLeft
        case selectedRight
        case selectedDirection
    }
    
    @State private var currentState : ScreenState = .scrollingToLeft
    @State private var translation : Double = 0.0
    @State private var opacity     : Double = 0.0
    @State private var screenSize  : CGSize = .zero
    
    private var customDrag: some Gesture{
        DragGesture()
            .onChanged{ drag in
                let totalTranslation = drag.location.x - drag.startLocation.x
                if(totalTranslation > 0){
                    currentState = .scrollingToRight
                    self.translation = drag.location.x - drag.startLocation.x
                    print(self.translation)
                    self.opacity = 0.8
                }else{
                    currentState = .scrollingToLeft
                    self.translation = drag.startLocation.x - drag.location.x
                    print(self.translation)
                    self.opacity = 0.8
                }
            }
            .onEnded { drag in
                let totalTranslation = abs(drag.location.x - drag.startLocation.x)
                if totalTranslation > 60{
                    completeTransition()
                }else{
                    resetState()
                }
            }
    }
    
    var body: some View {
        GeometryReader{ proxy in
            ZStack{
                switch self.currentState {
                case .scrollingToLeft:
                    SelectionSplitView(beetween: "Mergellina", and: "Mostra")
                        .colorInvert()
                        .opacity(0.0 + self.translation / (proxy.size.width / 1.5))
                    SelectionSplitView(beetween: "Linea 1", and: "Linea 6")
                        .opacity(1.0 - self.translation / (proxy.size.width / 1.5))
                case .scrollingToRight:
                    SelectionSplitView(beetween: "Garibaldi", and: "Piscinola")
                        .opacity(0.0 + self.translation / (proxy.size.width / 1.5))
                        .colorInvert()
                    SelectionSplitView(beetween: "Linea 1", and: "Linea 6")
                        .opacity(1.0 - self.translation / (proxy.size.width / 1.5))
                case .selectedLeft:
                    SelectionSplitView(beetween: "Mergellina", and: "Mostra")
                        .colorInvert()
                case .selectedRight:
                    SelectionSplitView(beetween: "Garibaldi", and: "Piscinola")
                        .colorInvert()
                default:
                    EmptyView()
                }
            }
            .onAppear(){
                self.screenSize = proxy.size
            }
            .background(
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                    switch(self.currentState){
                    case .scrollingToLeft, .selectedLeft:
                        Color.white
                        Color.black
                            .frame(width: proxy.size.width / 2)
                            .offset(x: proxy.size.width/2 - translation)
                    case .scrollingToRight, .selectedRight:
                        Color.black
                        Color.white
                            .frame(width: proxy.size.width / 2)
                            .offset(x: translation)
                    default:
                        Color.black
                    }
                })
                .ignoresSafeArea()
            )
            .gesture(customDrag)
        }
    }
    
    func resetState(){
        withAnimation{
            self.translation = 0.0
        }
    }
    
    func completeTransition(){
        if(currentState == .scrollingToLeft){
            withAnimation{
                translation = self.screenSize.width / 2
            } completion: {
                currentState = .selectedLeft
            }
        }else if (currentState == .scrollingToRight){
            withAnimation{
                translation = self.screenSize.width / 2
            } completion: {
                currentState = .selectedRight
            }
        }
    }
}

#Preview {
    DestinationSelectionView()
}
