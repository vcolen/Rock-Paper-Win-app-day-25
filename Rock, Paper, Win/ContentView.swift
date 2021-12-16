//
//  ContentView.swift
//  Rock, Paper, Win
//
//  Created by Victor Colen on 27/11/21.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    let winMoves = ["Paper", "Scissors", "Rock"]
    let loseMoves = ["Scissors", "Rock", "Paper"]
    
    @State private var appChoice = Int.random(in: 0...2)
    @State private var playerChoice = 0
    @State private var playerShouldWin = Bool.random()
    @State private var round = 1
    @State private var endOfGame = false
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    
    
    var body: some View {
        VStack(spacing: 60) {
            Text("App chooses: \(moves[appChoice])")
            HStack {
                Text("Choose an option to")
                Text("\(playerShouldWin ? "win" : "lose")")
                    .foregroundColor(.red)
                Text("the match")
            }
            HStack {
                ForEach(0..<3) { option in
                    Button {
                        optionTapped(option)
                    } label: {
                        Text("\(moves[option])")
                    }
                }
            }
            Text("Your score: \(score)/\(round - 1)")
        }
        .preferredColorScheme(.dark)
        
        .alert("The game has ended", isPresented: $endOfGame) {
            Button {
                restartGame()
            } label: {
                Text("Rematch!")
            }
        } message: {
            Text("This was the final round, your score was \(score)!")
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button {
                
            } label: {
                Text("Alright")
            }
        }
    }
    
    func optionTapped(_ option: Int) {
        if playerShouldWin {
            if moves[option] == winMoves[appChoice] {
                score += 1
                scoreTitle = "You got it right!"
            } else {
                scoreTitle = "Oh no! You lost!"
                score -= 1
            }
        }
        else {
            if moves[option] == loseMoves[appChoice] {
                scoreTitle = "You got it right!"
                score += 1
            } else {
                scoreTitle = "Oh no! You lost!"
                score -= 1
            }
        }
        nextMatch()
    }
    
    func nextMatch() {
        appChoice = Int.random(in: 0...2)
        playerShouldWin = Bool.random()
        round += 1
        
        if round == 11 {
            endOfGame = true
        } else {
            showingScore = true
        }
    }
    
    func restartGame() {
        score = 0
        round = 1
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
