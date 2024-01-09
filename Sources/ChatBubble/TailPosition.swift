//
//  TailPosition.swift
//

extension ChatBubble {
  public enum TailPosition {
    case trailingTop
    case trailingBottom
    case leadingTop
    case leadingBottom
    
    var isLeading: Bool {
      switch self {
      case .trailingTop:
        return false
      case .trailingBottom:
        return false
      case .leadingTop:
        return true
      case .leadingBottom:
        return true
      }
    }
  }
}
