import SwiftUI

struct BottomRoundedRectangle: Shape {
    var radius: CGFloat = 6.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let tr = CGPoint(x: rect.maxX, y: rect.minY)
        let tl = CGPoint(x: rect.minX, y: rect.minY)
        let bl = CGPoint(x: rect.minX, y: rect.maxY)
        let br = CGPoint(x: rect.maxX, y: rect.maxY)
        
        path.move(to: tl)
        path.addLine(to: tr)
        path.addLine(to: CGPoint(x: br.x, y: br.y - radius))
        path.addArc(center: CGPoint(x: br.x - radius, y: br.y - radius),
                    radius: radius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
        path.addLine(to: CGPoint(x: bl.x + radius, y: bl.y))
        path.addArc(center: CGPoint(x: bl.x + radius, y: bl.y - radius),
                    radius: radius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)
        path.addLine(to: tl)
        
        return path
    }
}
