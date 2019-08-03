import Foundation

public struct Distance {
    var defaultTop: CGFloat
    var defaultBottom: CGFloat
    var defaultLeft: CGFloat
    var defaultRight: CGFloat
    
    public init(
        defaultTop: CGFloat = 32,
        defaultBottom: CGFloat = 32,
        defaultLeft: CGFloat = 32,
        defaultRight: CGFloat = 32
        ) {
        self.defaultTop = defaultTop
        self.defaultBottom = defaultBottom
        self.defaultLeft = defaultLeft
        self.defaultRight = defaultRight
    }
    
    public init(distance: CGFloat = 32) {
        self.defaultTop = distance
        self.defaultBottom = distance
        self.defaultLeft = distance
        self.defaultRight = distance
    }
}
