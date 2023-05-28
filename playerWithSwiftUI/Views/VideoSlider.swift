import SwiftUI

struct VideoSlider: View {
    var currentTime: Float64
    @State private var isDragging = false
    @State private var draggedLocation: Float64?

    var videoDuration: Float64
    var onSliderChange: ((Float64) -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.5))
                    .frame(width: geometry.size.width, height: 2.5)
                
                Rectangle()
                    .foregroundColor(Color.red)
                    .frame(width: CGFloat(self.calculateWatchedDurationWidth(geometry: geometry)), height: 2.5)
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 10, height: 10)
                    .scaleEffect(isDragging ? 2.0 : 1.0)
                    .offset(x: isDragging ? self.draggedLocation! : self.calculateWatchedDurationWidth(geometry: geometry), y: 0)
                    .gesture(DragGesture()
                        .onChanged { value in
                            handleThumbDrag(value: value, geometry: geometry)
                        }
                        .onEnded { value in
                            isDragging = false
                            onSliderChange?(calculateDraggedDuration(geometry: geometry))
                        }
                    )
            }
            .frame(height: 3)
        }
    }
    
    private func calculateWatchedDurationWidth(geometry: GeometryProxy) -> CGFloat {
        let totalWidth = geometry.size.width
        let percentage = CGFloat(currentTime / videoDuration)
        return totalWidth * percentage
    }
    
    private func calculateDraggedDuration(geometry: GeometryProxy) -> Float64 {
        guard let draggedLocation = draggedLocation else {
            return currentTime
        }
        
        let totalWidth = Float64(geometry.size.width)
        let percentage = draggedLocation / totalWidth
        let draggedDuration = videoDuration * percentage
        return draggedDuration
    }
    
    private func handleThumbDrag(value: DragGesture.Value, geometry: GeometryProxy) {
        isDragging = true
        draggedLocation = Double(value.location.x)
    }
}


struct CustomSlider_Previews: PreviewProvider {
    static var previews: some View {
        VideoSlider(
            currentTime: 90.0,
            videoDuration: 120.0)
        .frame(height: 2)
    }
}
