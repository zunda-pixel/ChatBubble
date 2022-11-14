import SwiftUI

public struct ChatBubble: Shape {
  var cornerRadius: Double
  
  public init(cornerRadius: Double) {
    self.cornerRadius = cornerRadius
  }
  
  public func path(in rect: CGRect) -> Path {
    Path { path in
      let tailSize = cornerRadius / 2
      
      // 左上角丸
      path.addArc(
        center: CGPoint(
          x: rect.minX + cornerRadius,
          y: rect.minY + cornerRadius
        ),
        radius: cornerRadius,
        startAngle: Angle(degrees: 180),
        endAngle: Angle(degrees: 270),
        clockwise: false
      )
      
      // 右上角丸
      path.addArc(
        center: CGPoint(
          x: rect.maxX - cornerRadius,
          y: rect.minY + cornerRadius
        ),
        radius: cornerRadius,
        startAngle: Angle(degrees: 270),
        endAngle: Angle(degrees: 270 + 45),
        clockwise: false
      )
      
      // しっぽ上部
      path.addQuadCurve(
        to: CGPoint(
          x: rect.maxX + tailSize,
          y: rect.minY
        ),
        control: CGPoint(
          x: rect.maxX,
          y: rect.minY
        )
      )
      
      // しっぽ下部
      path.addQuadCurve(
        to: CGPoint(
          x: rect.maxX,
          y: rect.minY + tailSize * 2
        ),
        control: CGPoint(
          x: rect.maxX,
          y: rect.minY + tailSize
        )
      )
      
      // 右下角丸
      path.addArc(
        center: CGPoint(
          x: rect.maxX - cornerRadius,
          y: rect.maxY - cornerRadius
        ),
        radius: cornerRadius,
        startAngle: Angle(degrees: 0),
        endAngle: Angle(degrees: 90),
        clockwise: false
      )
      
      // 左下角丸
      path.addArc(
        center: CGPoint(
          x: rect.minX + cornerRadius,
          y: rect.maxY - cornerRadius
        ),
        radius: cornerRadius,
        startAngle: Angle(degrees: 90),
        endAngle: Angle(degrees: 180),
        clockwise: false
      )
    }
  }
}

extension View {
  public func chatBubble(direction: ChatBubble.Direction, cornerRadius: Double, color: Color) -> some View {
    self
      .padding()
      .background {
        ChatBubble(cornerRadius: cornerRadius)
          .rotateChatBubble(direction: direction)
          .foregroundColor(color)
      }
      .padding(direction.isLeading ? .leading : .trailing, cornerRadius / 2)
  }
  
  func rotateChatBubble(direction: ChatBubble.Direction) -> some View {
    switch direction {
    case .trailingTop:
      return self.rotation3DEffect(.init(degrees: 180), axis: (0, 0, 0))
    case .trailingBottom:
      return self.rotation3DEffect(.init(degrees: 180), axis: (1, 0, 0))
    case .leadingTop:
      return self.rotation3DEffect(.init(degrees: 180), axis: (0, 1, 0))
    case .leadingBottom:
      return self.rotation3DEffect(.init(degrees: 180), axis: (0, 0, 1))
    }
  }
}


struct ChatBubble_Preview: PreviewProvider {
  struct Chat: Identifiable {
    let id = UUID()
    let text: String
    let direction: ChatBubble.Direction
  }
  
  static let chats: [Chat] = [
    .init(text: "In order to meet the deadline for delivery.", direction: .trailingTop),
    .init(text: "The business results are above average.", direction: .leadingTop),
    .init(text: "Handle phone calls.", direction: .leadingTop),
    .init(text: "Notification of rescheduling of next week’s regular meeting.", direction: .trailingTop),
    .init(text: "Request a customer to introduce other customers.", direction: .trailingTop),
  ]
  
  static var previews: some View {
    ScrollView {
      ForEach(chats) { chat in
        HStack(alignment: .top) {
          if !chat.direction.isLeading {
            Spacer()
          }
          
          Text(chat.text)
            .fixedSize(horizontal: false, vertical: true)
            .chatBubble(
              direction: chat.direction,
              cornerRadius: 17,
              color: .blue.opacity(0.5)
            )
            .frame(maxWidth: 250, alignment: chat.direction.isLeading ? .leading : .trailing)
            //.border(.red)
          
          if chat.direction.isLeading {
            Spacer()
          }
        }
      }
    }
  }
}

struct SingleChatBubble: PreviewProvider {
  static var previews: some View {
    Text("Request a customer to introduce other customers. Request a customer to introduce other customers")
      .chatBubble(
        direction: .leadingTop,
        cornerRadius: 17,
        color: .blue.opacity(0.5)
      )
  }
}
