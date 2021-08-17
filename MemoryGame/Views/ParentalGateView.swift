//
//  ParentalGateView.swift
//  MemoryGame
//
//  Created by Jasjeev on 8/8/21.
//

import SwiftUI

struct ParentalGateView: View {
    
    @EnvironmentObject  var viewModel: MemoryGameViewModel
    
    @State var result: String = ""

    var homeThemeColor = Color(red: 5 / 255, green: 39 / 255, blue: 100 / 255)
    
    var body: some View {
        Text("Please ask your parent to help you with this").font(.title).padding()
        
        Text(viewModel.parentalQ).font(.system(size: 30)).padding()
        
        TextField("Username", text: $result)
            .padding(100)
            .font(Font.system(size: 60, design: .default))
            .multilineTextAlignment(.center)
        
        Button("Submit") {
            self.viewModel.checkParental(result)
        }.padding()
        .background(homeThemeColor)
        .foregroundColor(.white)
        .font(.system(size: 50))

    }
}

struct ParentalGateView_Previews: PreviewProvider {
    static var previews: some View {
        ParentalGateView()
    }
}
