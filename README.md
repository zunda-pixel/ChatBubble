# ChatBubble

<img height="300" alt="スクリーンショット 2022-11-15 0 32 34" src="https://user-images.githubusercontent.com/47569369/201700410-c4035784-f678-4aa0-90e4-f7561f6a3893.png"><img height="300" alt="スクリーンショット 2022-11-15 0 47 58" src="https://user-images.githubusercontent.com/47569369/201703849-e02e919b-1916-49b2-9121-f6ecb7268df9.png">

```swift
struct SingleChatBubble: PreviewProvider {
  static var previews: some View {
    Text("Stanford Video Steve Jobs’ 2005 Stanford Commencement Address I am honored to be with you today at your commencement from one of the finest universities in the world.")
      .fixedSize(horizontal: false, vertical: true)
      .chatBubble(
        direction: .leadingTop,
        cornerRadius: 17,
        color: .blue.opacity(0.5)
      )
  }
}
```

```swift
struct ShapePreview: PreviewProvider {
  static var previews: some View {
    ChatBubble(cornerRadius: 17)
      .frame(width: 300, height: 100)
      .foregroundColor(.cyan)
  }
}
```

```swift
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
```

## 参考にしたもの

https://qiita.com/yuppejp/items/92429a0fc8440f9da487
