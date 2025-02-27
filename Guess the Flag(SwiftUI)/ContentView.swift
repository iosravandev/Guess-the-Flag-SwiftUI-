//
//  ContentView.swift
//  Guess the Flag(SwiftUI)
//
//  Created by Ravan on 27.02.25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Argentina", "Russia", "Sweden", "Greece", "USA", "Canada", "Bangladesh", "Brazil", "United Kingdom", "Germany"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 20) {
                VStack{
                    Text("Choose a flag for: \(countries[correctAnswer])")
                        .foregroundColor(.black)
                        .font(.system(size: 25))
                        .fontWeight(.black)
                }
                
                Spacer(minLength: 20)
                
                ForEach(0..<3) { number in
                    
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 130)
                            .clipShape(.capsule)
                            .overlay(Capsule() .stroke(Color.black, lineWidth: 3))
                            .shadow(color: .black, radius: 2)
                    }
                    
                }
                
                Spacer()
                
                Text("Total Score: \(score)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
                
            } .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Total score: \(score)"), dismissButton: .default(Text("Play again")) {
                    self.askQuestion()
                })
            }
        }
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct Answer"
            score += 1
        } else {
            scoreTitle = "Incorrect Answer, the answer is \(countries[number])"
            score -= 1
        }
    }
    
}

#Preview {
    ContentView()
}
