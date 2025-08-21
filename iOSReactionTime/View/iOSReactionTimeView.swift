//
//  iOSReactionTimeView.swift
//  iOSReactionTime
//
//  Created by Yosup Cheon on 2025-08-20.
//

 import SwiftUI

struct iOSReactionTimeView: View {
    @StateObject private var viewModel = ReactionViewModel()
    
    var body: some View {
        ZStack {
            (viewModel.colorChanged ? Color.green : Color.red)
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.stopGame()
                }
            
            VStack(spacing: 20) {
                Text(viewModel.message)
                    .font(.title2)
                    .foregroundColor(.white)
                
                if let reaction = viewModel.reactionTime {
                    Text(String(format: "Reaction: %.3f s", reaction))
                        .font(.headline)
                        .foregroundColor(.yellow)
                }
                
                if let best = viewModel.bestTime {
                    Text(String(format: "Best: %.3f s", best))
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Button(action: {
                    viewModel.startGame()
                }) {
                    Text("Start")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                }
                .padding(.top, 30)
            }
        }
    }
}
 
