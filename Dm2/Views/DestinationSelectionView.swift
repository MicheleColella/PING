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
        case choosingDirection
        case selectedDirection
    }
    
    @State private var currentState : ScreenState = .scrollingToLeft
    @State private var selection : String = ""
    @State private var translation : Double = 0.0
    @State private var opacity     : Double = 0.0
    
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
            .onEnded { value in
                currentState = .scrollingToLeft
                self.translation = 0.0
            }
    }
    
    var body: some View {
        GeometryReader{ proxy in
            ZStack{
                switch self.currentState {
                case .scrollingToLeft:
                    SelectionView(selection: $selection, beetween: "Mergellina", and: "Mostra")
                        .colorInvert()
                        .opacity(0.0 + self.translation / (proxy.size.width / 1.5))
                    SelectionView(selection: $selection, beetween: "Linea 1", and: "Linea 6")
                        .opacity(1.0 - self.translation / (proxy.size.width / 1.5))
                        .onAppear(){
                            print(proxy.size.width)
                        }
                case .scrollingToRight:
                    SelectionView(selection: $selection, beetween: "Garibaldi", and: "Piscinola")
                        .opacity(0.0 + self.translation / (proxy.size.width / 1.5))
                        .colorInvert()
                    SelectionView(selection: $selection, beetween: "Linea 1", and: "Linea 6")
                        .opacity(1.0 - self.translation / (proxy.size.width / 1.5))
                case .choosingDirection:
                    SelectionView(selection: $selection, beetween: "Option 1", and: "Option 2")
                default:
                    EmptyView()
                }
            }
            .background(
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                    if self.currentState == .scrollingToLeft{
                        Color.white
                        Color.black
                            .frame(width: proxy.size.width / 2)
                            .offset(x: proxy.size.width/2 - translation)
                    }
                    else if self.currentState == .scrollingToRight{
                        Color.black
                        Color.white
                            .frame(width: proxy.size.width / 2)
                            .offset(x: translation)
                    }
                })
                .ignoresSafeArea()
            )
            .onChange(of: selection) { oldValue, newValue in
                print("selection change from \(oldValue) to \(newValue)")
            }
            .gesture(customDrag)
        }
    }
}

#Preview {
    DestinationSelectionView()
}
