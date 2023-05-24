//
//  VideoPlayerControlsView.swift
//  playerWithSwiftUI
//
//  Created by Testpress on 24/05/23.
//

import SwiftUI

struct VideoPlayerControlsView: View {
    @State private var playbackSliderValue: Double = 0.7
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button(action: playPauseTapped) {
                    Image(systemName: "play")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                
                Slider(value: $playbackSliderValue, in: 0...1) { _ in
                    playbackSliderChanged()
                }
                
                Button(action: forward) {
                    Image(systemName: "forward")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(.systemRed))
                }
                
                Button(action: rewind) {
                    Image(systemName: "rewind")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(.systemRed))
                }
                
                Spacer()
                
                Button(action: toggleFullscreen) {
                    Image(systemName: "maximize")
                        .resizable()
                        .frame(width: 18, height: 18)
                }
                
                Button(action: showOptionsMenu) {
                    Image(systemName: "settings")
                        .resizable()
                        .frame(width: 22, height: 22)
                }
            }
            .padding()
        }
    }
    
    func playPauseTapped() {
        // Handle play/pause button tap
    }
    
    func playbackSliderChanged() {
        // Handle playback slider value change
    }
    
    func forward() {
        // Handle forward button tap
    }
    
    func rewind() {
        // Handle rewind button tap
    }
    
    func toggleFullscreen() {
        // Handle fullscreen button tap
    }
    
    func showOptionsMenu() {
        // Handle options menu button tap
    }
}

struct ContentView1: View {
    var body: some View {
        VideoPlayerControlsView()
            .frame(width: 667, height: 375)
            .background(Color.white)
    }
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}

