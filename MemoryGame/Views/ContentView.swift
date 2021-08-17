//
//  ContentView.swift
//  MemoryGame
//
//  Created by Jasjeev on 8/7/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MemoryGameViewModel()
    
    var body: some View {
        if(viewModel.showGame) {
            return AnyView(GameView().environmentObject(viewModel))
        }
        else{
            return AnyView(LobbyView().environmentObject(viewModel))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
