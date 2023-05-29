import SwiftUI

struct ControlsView: View {
    @State private var showControls = false
    @State private var hideTimer: Timer?
    
    var videoDuration: Float64
    var currentTime: Float64
    var bufferedDuration: Float64
    var playerStatus: PlayerStatus
    var controlsDelegate: PlayerControlDelegate?
    
    var body: some View {
        VStack {
            if showControls {
                HStack {
                    Spacer()
                    Button(action: rewind) {
                        Image("settings")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    .padding([.trailing, .top], 10)
                }
                
                Spacer()
                
                HStack(spacing: 80) {
                    Button(action: rewind) {
                        Image("rewind")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .brightness(-0.2)
                    }
                    if (playerStatus == .buffering){
                        ProgressView()
                            .scaleEffect(1.5)
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    } else {
                        Button(action: playPauseTapped) {
                            Image(playerStatus == .paused ? "play" : "pause")
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
                
                VStack {
                    HStack {
                        HStack {
                            Text(timeStringFromSeconds(currentTime))
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .font(.subheadline)
                            
                            Text("/")
                                .foregroundColor(Color.gray)
                                .fontWeight(.bold)
                            
                            Text(timeStringFromSeconds(videoDuration))
                                .foregroundColor(Color.gray)
                                .fontWeight(.bold)
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Button(action: rewind) {
                            Image("maximize")
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                    }
                    .padding([.leading, .trailing], 12)
                    
                    VideoSlider(
                        currentTime: currentTime,
                        bufferedDuration: bufferedDuration,
                        videoDuration: videoDuration,
                        onSliderChange: { value in
                            controlsDelegate?.goTo(seconds: value)
                        }
                    )
                    .frame(height: 3)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(showControls ? Color.black.opacity(0.4) : Color.black.opacity(0.001))
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
    
    private func playPauseTapped() {
        if playerStatus == .paused {
            controlsDelegate?.play()
        } else {
            controlsDelegate?.pause()
        }
    }
    
    private func rewind() {
        controlsDelegate?.rewind()
    }
    
    private func forward() {
        controlsDelegate?.forward()
    }
}

protocol PlayerControlDelegate {
    func pause()
    func play()
    func forward()
    func rewind()
    func goTo(seconds: Float64)
}


struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView(
            videoDuration: 20.0,
            currentTime: 10.0,
            bufferedDuration: 15.0,
            playerStatus: .playing)
            .background(Color.black)
    }
}

