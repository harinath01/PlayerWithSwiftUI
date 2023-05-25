import SwiftUI

struct ControlsView: View {
    @State private var showControls = false
    
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
                    }
                    Button(action: playPauseTapped) {
                        Image("play")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Button(action: forward) {
                        Image("forward")
                            .resizable()
                            .frame(width: 40, height: 40)
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
      .background(Color.black)
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    print("called", showControls)
                    showControls = true
                    startHideTimer()
                }
        )
    }
    
    private func startHideTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
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

