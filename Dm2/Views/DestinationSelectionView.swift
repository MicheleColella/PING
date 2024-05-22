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
                switch(self.currentState){
                case .scrollingToLeft, .scrollingToRight:
                    lineDragHandle(translation: totalTranslation)
                case .selectedLeft, .selectedRight:
                    stationDragHandle(translation: totalTranslation)
                default:
                    return
                }
            }
            .onEnded { drag in
                let totalTranslation = drag.location.x - drag.startLocation.x
                if abs(totalTranslation) > 60{
                    switch(self.currentState){
                    case .scrollingToLeft:
                        completeTransition(to: .selectedRight)
                    case .scrollingToRight:
                        completeTransition(to: .selectedLeft)
                    case .selectedLeft, .selectedRight:
                        completeTransition(to: .selectedDirection)
                    default:
                        return
                    }
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
                        .opacity(0.0 + self.opacity)
                    SelectionSplitView(beetween: "Linea 1", and: "Linea 6")
                        .opacity(1.0 - self.opacity)
                case .scrollingToRight:
                    SelectionSplitView(beetween: "Garibaldi", and: "Piscinola")
                        .opacity(0.0 + self.opacity)
                        .colorInvert()
                    SelectionSplitView(beetween: "Linea 1", and: "Linea 6")
                        .opacity(1.0 - opacity)
                case .selectedRight:
                    SelectionSplitView(beetween: "Mergellina", and: "Mostra")
                        .colorInvert()
                    CustomBackButton(){
                        resetState()
                    }
                case .selectedLeft:
                    SelectionSplitView(beetween: "Garibaldi", and: "Piscinola")
                        .colorInvert()
                    CustomBackButton(){
                        resetState()
                    }
                case .selectedDirection:
                    PathFindView(destination: "Garibaldi")
                }
            }
            .onAppear(){
                self.screenSize = proxy.size
            }
            .background(
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                    switch(self.currentState){
                    case .scrollingToLeft:
                        Color.white
                        Color.black
                            .frame(width: proxy.size.width / 2)
                            .offset(x: proxy.size.width/2 - self.translation)
                    case .scrollingToRight:
                        Color.black
                        Color.white
                            .frame(width: proxy.size.width / 2)
                            .offset(x: self.translation)
                    case .selectedRight:
                        Color.white
                        Color.black
                            .frame(width: proxy.size.width / 2 + self.translation)
                            .offset(x: 0)
                    case .selectedLeft:
                        Color.black
                        Color.white
                            .frame(width: proxy.size.width / 2 - self.translation)
                            .offset(x: proxy.size.width / 2 + self.translation)
                    default:
                        EmptyView()
                    }
                })
                .ignoresSafeArea()
            )
            .gesture(self.customDrag)
        }
    }
    
    func lineDragHandle(translation: Double){
        if(translation > 0){
            currentState = .scrollingToRight
            self.translation = translation
            print(self.translation)
        }else{
            currentState = .scrollingToLeft
            self.translation = -translation
            print(self.translation)
        }
        self.opacity = self.translation / (self.screenSize.width / 1.5)
    }
    
    func stationDragHandle(translation: Double){
        self.translation = translation
    }
    
    func resetState(){
        withAnimation{
            self.translation = 0.0
            opacity = 0.0
        } completion: {
            currentState = .scrollingToLeft
        }
    }
    
    func completeTransition(to finalState: ScreenState){
        switch(finalState){
        case .selectedLeft, .selectedRight:
            withAnimation{
                self.translation = self.screenSize.width / 2
                self.opacity = 1.0
            } completion: {
                if(currentState == .scrollingToLeft){
                    self.currentState = .selectedRight
                }else if(currentState == .scrollingToRight){
                    self.currentState = .selectedLeft
                }
                self.translation = 0.0
            }
        case .selectedDirection:
            if (self.translation > 0){
                withAnimation{
                    self.translation = self.screenSize.width / 2
                    self.opacity = 1.0
                } completion: {
                    self.currentState = .selectedDirection
                }
            }else{
                withAnimation{
                    self.translation = -self.screenSize.width / 2
                    self.opacity = 1.0
                } completion: {
                    self.currentState = .selectedDirection
                }
            }
        default:
            return
        }
    }
}

#Preview {
    DestinationSelectionView()
}
