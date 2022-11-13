import SwiftUI

struct ChatBubble: Shape {
  var cornerRadius: Double
  
  func path(in rect: CGRect) -> Path {
    Path { path in
      let tailSize = CGSize(
        width: cornerRadius / 2,
        height: cornerRadius / 2
      )
      
      path.addArc(
        center: CGPoint(
          x: rect.minX + cornerRadius,
          y: rect.minY + cornerRadius),
        radius: cornerRadius,
        startAngle: Angle(degrees: 180),
        endAngle: Angle(degrees: 279), clockwise: false)
      
      // 右上角丸
      path.addArc(
        center: CGPoint(
          x: rect.maxX - cornerRadius - tailSize.width,
          y: rect.minY + cornerRadius),
        radius: cornerRadius,
        startAngle: Angle(degrees: 270),
        endAngle: Angle(degrees: 270 + 45), clockwise: false)
      
      // しっぽ上部
      path.addQuadCurve(
        to: CGPoint(
          x: rect.maxX,
          y: rect.minY),
        control: CGPoint(
          x: rect.maxX - (tailSize.width / 2),
          y: rect.minY))
      
      // しっぽ下部
      path.addQuadCurve(
        to: CGPoint(
          x: rect.maxX - tailSize.width,
          y: rect.minY + (cornerRadius / 2) + tailSize.height),
        control: CGPoint(
          x: rect.maxX - (tailSize.width / 2),
          y: rect.minY))
      
      // 右下角丸
      path.addArc(
        center: CGPoint(
          x: rect.maxX - cornerRadius - tailSize.width,
          y: rect.maxY - cornerRadius),
        radius: cornerRadius,
        startAngle: Angle(degrees: 0),
        endAngle: Angle(degrees: 90), clockwise: false)
      
      // 左下角丸
      path.addArc(
        center: CGPoint(
          x: rect.minX + cornerRadius,
          y: rect.maxY - cornerRadius),
        radius: cornerRadius,
        startAngle: Angle(degrees: 90),
        endAngle: Angle(degrees: 180), clockwise: false)
    }
  }
}


struct ChatBubble_Preview: PreviewProvider {
  static var previews: some View {
    Text("Hello")
      .padding()
      .background {
        ChatBubble(cornerRadius: 17)
          .foregroundColor(.red.opacity(0.5))
      }
  }
}
