//
//  LobbyView.swift
//  CardFlip
//
//  Created by Jasjeev on 8/5/21.
//

import SwiftUI


struct LobbyView: View {
    
    @EnvironmentObject  var viewModel: MemoryGameViewModel
    
    var homeThemeColor = Color(red: 5 / 255, green: 39 / 255, blue: 100 / 255)

    let columns = [
            GridItem(.adaptive(minimum: 60))
    ]
    
    var manual: some View {
        NavigationLink(destination: ManualView()) {
            Text("Instructions")
        }
    }
    
    var credits: some View {
        NavigationLink(destination: self.viewModel.showParental ? AnyView(ParentalGateView()) : AnyView(CreditsView())) {
            Text("Credits")
        }
    }
    
    
    var body: some View {
        NavigationView{
            ZStack {
                LazyHGrid(rows: columns, spacing: 10){
                    
                    Spacer()
                    
                    Button("3x4") {
                        viewModel.setGameBoard(3, 4)
                        print("3x4 Button tapped!")
                    }.padding()
                    .background(homeThemeColor)
                    .foregroundColor(.white)
                    .font(.system(size: 50))
                    
                    Spacer()
                    
                    Button("5x2") {
                        print("5x2 Button tapped!")
                        viewModel.setGameBoard(5, 2)
                    }.padding()
                    .background(homeThemeColor)
                    .foregroundColor(.white)
                    .font(.system(size: 50))
                    
                    Spacer()
                    
                    Button("4x4") {
                        print("4x4 Button tapped!")
                        viewModel.setGameBoard(4, 4)
                    }.padding()
                    .background(homeThemeColor)
                    .foregroundColor(.white)
                    .font(.system(size: 50))
                    
                    Spacer()
                    
                    Button("4x5") {
                        viewModel.setGameBoard(4, 5)
                        print("4x5 Button tapped!")
                    }.padding()
                    .background(homeThemeColor)
                    .foregroundColor(.white)
                    .font(.system(size: 50))
                    
                    Spacer()
                    
                }.padding(.vertical)
                 .zIndex(1)
                
                Circle()
                    .fill(Color.yellow)
                    .scaleEffect(2)
                    .opacity(0.8)
                    .animation(
                        Animation.easeOut(duration: 100)
                            .repeatForever(autoreverses: true)
                    )
                
            }.navigationBarTitle(Text("Memory Game"))
            .navigationBarItems(leading: manual, trailing: credits)
            
        }.navigationViewStyle(StackNavigationViewStyle())
        .onAppear() {
            self.viewModel.shouldShowParental()
        }
    }
}

struct LobbyView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyView()
    }
}
