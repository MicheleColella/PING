//
//  ContentView.swift
//  Dm2
//
//  Created by Salvatore Attanasio on 07/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PathFindView()
    }
    
    ///Controllo del font nel sistema
    /*
    init(){
        for familyName in UIFont.familyNames {
            print(familyName)
            
            for fontName in UIFont.fontNames(forFamilyName: familyName){
                print("--\(fontName)")
            }
        }
    }
     */
}

#Preview {
    ContentView()
}
