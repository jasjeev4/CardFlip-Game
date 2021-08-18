//
//  ManualView.swift
//  MemoryGame
//
//  Created by Jasjeev on 8/8/21.
//

import SwiftUI

struct ManualView: View {
    var body: some View {
        NavigationView {
            ScrollView{
                Group {
                    Text("Instructions").font(.system(size: 40))
                        .padding(25)
                    Text("Flip a pair of cards over and try to find a match.")
                        .padding([.leading, .trailing], 50)
                        .padding([.top, .bottom], 20)
                    Text("Flip all the pairs of matching cards to win!")
                        .padding([.leading, .trailing], 50)
                        .padding([.top, .bottom], 20)
                }.padding(50)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ManualView_Previews: PreviewProvider {
    static var previews: some View {
        ManualView()
    }
}
