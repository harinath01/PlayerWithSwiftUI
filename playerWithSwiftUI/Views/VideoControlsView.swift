import SwiftUI

struct ControlsView: View {
    @State private var showControls = false
    @State private var hideTimer: Timer?
    
    var playerStatus: PlayerStatus
    var controlsDelegate: PlayerControlDelegate?
    
    var body: some View {
        VStack() {
            if showControls {
                HStack {
                    Spacer()
                    Button(action: rewind) {
                        Image("settings")
                            .resizable()
                            .frame(width: 18, height: 18)
                    }.padding()
                }
                Spacer()
                HStack(spacing: 80) {
                    Button(action: rewind) {
                        Image("rewind")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .brightness(-0.2)
                    }
                    Button(action: playPauseTapped) {
                        if self.playerStatus == .paused {
                            Image("play")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .brightness(-0.1)
                        } else {
                            Image("pause")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .brightness(-0.1)
                        }
                    }
                    Button(action: forward) {
                        Image("forward")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .brightness(-0.2)
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: rewind) {
                        Image("maximize")
                            .resizable()
                            .frame(width: 18, height: 18)
                    }.padding()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(showControls ? Color.black.opacity(0.2) : Color.black.opacity(0.001))
        .onTapGesture {
            showControls.toggle()
            if showControls {
                startHideTimer()
            }
        }
    }
    
    private func startHideTimer() {
        hideTimer?.invalidate()
        hideTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            showControls = false
        }
    }
    
    func playPauseTapped() {
        if playerStatus == .paused{
            controlsDelegate?.play()
        } else {
            controlsDelegate?.pause()
            
        }
    }
    
    func rewind(){
        
    }
    
    func forward(){
        
    }
}

protocol PlayerControlDelegate {
    func pause()
    func play()
}


struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        ControlsView(playerStatus: .playing)
            .background(Color.black)
    }
}

