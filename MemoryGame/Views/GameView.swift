//
//  GameView.swift
//  CardFlip
//
//  Created by Jasjeev on 8/5/21.
//

import SwiftUI


//  For custom image navigation back button https://stackoverflow.com/questions/56571349/custom-back-button-for-navigationviews-navigation-bar-in-swiftui


struct GameView: View {
    
    @EnvironmentObject  var viewModel: MemoryGameViewModel

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image("backNavButton")
                    .resizable()
                    .frame(width: 75.0, height: 75.0)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                    .onTapGesture {
                        self.viewModel.returnToLobby()
                    }
                }
            }
    }
    
    var liveScore : some View {
        Text("Score: " + String(self.viewModel.matches.count) + "/" + String(self.viewModel.maxMatches))
    }
    
    var body: some View {
        NavigationView {
                GeometryReader { geo in
                    ZStack {
                        VStack {
                                ForEach(viewModel.cards, id: \.self) { cardsRow in
                                    Spacer()
                                    HStack{
                                        ForEach(cardsRow, id: \.self) { card in
                                            Spacer()
                                        
                                             Image(card.displayImage)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: ((geo.size.width / CGFloat(cardsRow.count) - CGFloat(15.0) ) ))
                                                .onTapGesture {
                                                    self.viewModel.cardTapped(card.id)
                                                }
                                            
                                            Spacer()
                                        }
                                    }
                                    Spacer()
                                }
                        }
                        .alert(isPresented: $viewModel.gameWon) {
                                Alert(
                                    title: Text("Well done! You won in " + String(self.viewModel.winTime) + " seconds!"),
                                    message: Text("You can go back to the lobby to start a new game"),
                                    dismissButton: Alert.Button.default(
                                        Text("Ok"), action: { self.viewModel.acceptVictory() }
                                    )
                                )
                        }
                        .zIndex(1)
                        
                        Circle()
                            .fill(Color.blue)
                            .scaleEffect(2)
                            .opacity(0.3)
                            .animation(
                                Animation.easeOut(duration: 100)
                                    .repeatForever(autoreverses: true)
                            )
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: btnBack, trailing: liveScore)
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
