//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Kathryn Elrod on 3/2/21.
//

import SwiftUI

struct ContentView: View {
    let objects = ["scalemass", "doc", "scissors"]
    @State private var promptObject = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    
    var promptText: String {
        if shouldWin {
            return "Win against"
        } else {
            return "Lose to"
        }
    }
    
    var promptIcon: String {
        let icons = ["scalemass.fill", "doc.fill", "scissors"]
        return icons[promptObject]
    }
    
    var body: some View {
        ZStack {
            Color.blue
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // upper black section
                VStack {
                    Text(promptText)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Button {
                        self.score = 0
                    } label: {
                        Image(systemName: promptIcon)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(maxWidth: 150, maxHeight: 150, alignment: .top)
                            .padding(10)
                    }
                    
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.medium)
                }
                .padding(10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.edgesIgnoringSafeArea(.top))
                
                // lower blue section - 3 buttons
                ForEach(0 ..< 3) { number in // doesn't work with '0 ... 2' for some reason
                    Button {
                        pressButton(number)
                    } label: {
                        Image(systemName: objects[number])
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .padding(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white, lineWidth: 7)
                            )
                            .padding(10)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    func pressButton(_ id: Int) {
        if didWin(threw: id) {
            self.score += 1
        } else {
            self.score = 0
        }
        promptObject = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func didWin(threw: Int) -> Bool {
        let losers = [2, 0, 1]
        let winners = [1, 2, 0]
        
        return (shouldWin && promptObject == losers[threw]) || (!shouldWin && promptObject == winners[threw])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
