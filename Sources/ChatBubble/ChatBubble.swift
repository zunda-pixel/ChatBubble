import SwiftUI

public struct ChatBubble: Shape {
  var cornerRadius: Double
  
  public init(cornerRadius: Double) {
    self.cornerRadius = cornerRadius
  }
  
  public func path(in rect: CGRect) -> Path {
    Path { path in
      let tailSize = cornerRadius / 2
      
      // leading top corner
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
      
      // trailing top corner
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
      
      // tail top
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
      
      // tail bottom
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
      
      // trailing bottom corner
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
      
      // leading bottom corner
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
  public func chatBubble(position: ChatBubble.TailPosition, cornerRadius: Double, color: Color) -> some View {
    self
      .padding()
      .background {
        ChatBubble(cornerRadius: cornerRadius)
          .rotateChatBubble(position: position)
          .foregroundColor(color)
      }
      .padding(position.isLeading ? .leading : .trailing, cornerRadius / 2)
  }
  
  public func rotateChatBubble(position: ChatBubble.TailPosition) -> some View {
    switch position {
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
    let position: ChatBubble.TailPosition
  }
  
  static let chats: [Chat] = [
    .init(text: "In order to meet the deadline for delivery.", position: .trailingTop),
    .init(text: "The business results are above average.", position: .leadingTop),
    .init(text: "Handle phone calls.", position: .leadingTop),
    .init(text: "Notification of rescheduling of next week’s regular meeting.", position: .trailingTop),
    .init(text: "Request a customer to introduce other customers.", position: .trailingTop),
  ]
  
  static var previews: some View {
    ScrollView {
      ForEach(chats) { chat in
        HStack(alignment: .top) {
          if !chat.position.isLeading {
            Spacer()
          }
          
          Text(chat.text)
            .fixedSize(horizontal: false, vertical: true)
            .chatBubble(
              position: chat.position,
              cornerRadius: 17,
              color: .blue.opacity(0.5)
            )
            .frame(maxWidth: 250, alignment: chat.position.isLeading ? .leading : .trailing)
            //.border(.red)
          
          if chat.position.isLeading {
            Spacer()
          }
        }
      }
    }
  }
}

struct ShapePreview: PreviewProvider {
  static var previews: some View {
    ChatBubble(cornerRadius: 17)
      .frame(width: 300, height: 100)
      .foregroundColor(.cyan)
  }
}

struct SingleChatBubble: PreviewProvider {
  static var previews: some View {
    Text("Stanford Video Steve Jobs’ 2005 Stanford Commencement Address I am honored to be with you today at your commencement from one of the finest universities in the world.")
      .fixedSize(horizontal: false, vertical: true)
      .chatBubble(
        position: .leadingTop,
        cornerRadius: 17,
        color: .blue.opacity(0.5)
      )
  }
}

struct MultiDirectionChatBubble: PreviewProvider {
  static var previews: some View {
    ScrollView {
      Text("Sample Text.")
        .fixedSize(horizontal: false, vertical: true)
        .chatBubble(
          position: .leadingTop,
          cornerRadius: 17,
          color: .red.opacity(0.5)
        )
      Text("Sample Text.")
        .fixedSize(horizontal: false, vertical: true)
        .chatBubble(
          position: .leadingBottom,
          cornerRadius: 17,
          color: .yellow.opacity(0.5)
        )
      Text("Sample Text.")
        .fixedSize(horizontal: false, vertical: true)
        .chatBubble(
          position: .trailingTop,
          cornerRadius: 17,
          color: .blue.opacity(0.5)
        )
      Text("Sample Text.")
        .fixedSize(horizontal: false, vertical: true)
        .chatBubble(
          position: .trailingBottom,
          cornerRadius: 17,
          color: .green.opacity(0.5)
        )
    }
  }
}

struct RawChatBubble: PreviewProvider {
  static var previews: some View {
    Text("Sample Text.")
      .fixedSize(horizontal: false, vertical: true)
      .padding()
      .background {
        ChatBubble(cornerRadius: 17)
          .rotateChatBubble(position: .trailingBottom)
          .foregroundColor(.red.opacity(0.5))
      }
  }
}
