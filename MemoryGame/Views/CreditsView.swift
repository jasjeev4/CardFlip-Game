//
//  CreditsView.swift
//  MemoryGame
//
//  Created by Jasjeev on 8/8/21.
//

import SwiftUI

struct CreditsView: View {
    
    @EnvironmentObject  var viewModel: MemoryGameViewModel
    
    var body: some View {
        NavigationView {
            ScrollView{
                Group {
                    Text("Music").font(.system(size: 30))
                    Link("Music: Chill Out by Dee Yan-Kay", destination: URL(string: "https://freemusicarchive.org/music/Dee_Yan-Key/Jazzz/05--Dee_Yan-Key-Chill_Out")!)
                    Link("Creative Commons License", destination: URL(string: "https://creativecommons.org/licenses/by-nc-sa/4.0/")!)

                }.padding()
                
                Group {
                    Text("Images").font(.system(size: 30))
                    Link("OpenClipArt Project", destination: URL(string: "https://openclipart.org/")!)
                    Link("Creative Commons License", destination: URL(string: "https://creativecommons.org/publicdomain/zero/1.0/")!)

                }.padding()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
