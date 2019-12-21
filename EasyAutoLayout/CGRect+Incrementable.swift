import Foundation

extension CGRect {
    public static func +(lhs: CGRect, rhs: CGRect) -> CGRect {
        let newRect = CGRect(x: lhs.origin.x + rhs.origin.x, y: lhs.origin.y + rhs.origin.y, width: lhs.width + rhs.width, height: lhs.width + rhs.width)
        return newRect
    }
}
