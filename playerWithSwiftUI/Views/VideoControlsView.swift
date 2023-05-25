import SwiftUI

struct ControlsView: View {
    @State private var showControls = false
    @State private var hideTimer: Timer?
    
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
                        Image("play")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .brightness(-0.1)
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
        print("called")
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
        ControlsView()
            .background(Color.black)
    }
}

