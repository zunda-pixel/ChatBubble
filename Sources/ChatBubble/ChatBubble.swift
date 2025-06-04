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
          x: rect.maxX + tailSize / 2,
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
  public func chatBubble(
    position: ChatBubble.TailPosition,
    cornerRadius: Double,
    color: Color
  ) -> some View {
    self
      .padding(cornerRadius / 2)
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

#Preview {
  ChatBubble(cornerRadius: 18)
    .frame(width: 300, height: 100)
    .foregroundColor(.cyan)
}

#Preview {
  Text("Sample Text.")
    .fixedSize(horizontal: false, vertical: true)
    .padding(8)
    .background {
      ChatBubble(cornerRadius: 18)
        .rotateChatBubble(position: .trailingBottom)
        .foregroundColor(.red.opacity(0.5))
    }
}

#Preview {
  Text(
    "Stanford Video Steve Jobs’ 2005 Stanford Commencement Address I am honored to be with you today at your commencement from one of the finest universities in the world."
  )
  .fixedSize(horizontal: false, vertical: true)
  .chatBubble(
    position: .leadingTop,
    cornerRadius: 18,
    color: .blue.opacity(0.5)
  )
}

#Preview {
  ScrollView {
    Text("Sample Text.")
      .fixedSize(horizontal: false, vertical: true)
      .chatBubble(
        position: .leadingTop,
        cornerRadius: 18,
        color: .red.opacity(0.5)
      )
    Text("Sample Text.")
      .fixedSize(horizontal: false, vertical: true)
      .chatBubble(
        position: .leadingBottom,
        cornerRadius: 18,
        color: .yellow.opacity(0.5)
      )
    Text("Sample Text.")
      .fixedSize(horizontal: false, vertical: true)
      .chatBubble(
        position: .trailingTop,
        cornerRadius: 18,
        color: .blue.opacity(0.5)
      )
    Text("Sample Text.")
      .fixedSize(horizontal: false, vertical: true)
      .chatBubble(
        position: .trailingBottom,
        cornerRadius: 18,
        color: .green.opacity(0.5)
      )
  }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, *)
#Preview {
  struct Chat: Identifiable {
    let id = UUID()
    let text: String
    let position: ChatBubble.TailPosition
  }

  let chats: [Chat] = [
    .init(text: "In order to meet the deadline for delivery.", position: .trailingTop),
    .init(text: "The business results are above average.", position: .leadingTop),
    .init(text: "Handle phone calls.", position: .leadingTop),
    .init(text: "Request a customer to introduce other customers.", position: .trailingTop),
    .init(text: "In order to meet the deadline for delivery.", position: .trailingTop),
    .init(text: "The business results are above average.", position: .leadingTop),
    .init(text: "Handle phone calls.", position: .leadingTop),
    .init(text: "Request a customer to introduce other customers.", position: .trailingTop),
  ]

  return NavigationStack {
    List(chats) { chat in
      HStack(alignment: .top) {
        if !chat.position.isLeading {
          Spacer()
        }

        Text(chat.text)
          .fixedSize(horizontal: false, vertical: true)
          .chatBubble(
            position: chat.position,
            cornerRadius: 18,
            color: .blue.opacity(0.5)
          )
          .frame(maxWidth: 250, alignment: chat.position.isLeading ? .leading : .trailing)

        if chat.position.isLeading {
          Spacer()
        }
      }

      .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
    .navigationTitle("Chats")
    #if !os(macOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}
