import Foundation

open class EasyAutoLayoutViewController: UIViewController {
    
//    var computedLayout: (Bool, [UIView]?) {
//        let subViews = view.subviews
//        for view in subViews {
//            if view.subviews.isNotEmpty {
//                let childSubViews = view.superview
//            }
//        }
//        return (true, nil)
//    }
    
    open func setAutoLayout(targetView target: UIView, merge: Bool = false, _ parent: UIView? = nil, distanceController: DistanceController = DistanceController()) {
        var parent = parent
        if parent == nil {
            parent = target.superview
        }
        guard let _parent = parent else {
            fatalError("no superView founded!")
        }
        target.setAutoLayout(merge: merge, parentView: _parent, distanceController: distanceController)
    }
}

extension UIView {
    
    func setAutoLayout(merge: Bool, parentView: UIView, distanceController: DistanceController) {
        if !merge {
            // delete previous constraints unless merge.
            removeConstraints(constraints)
        }
        // current support constraints are 4 attributes (top, bottom, left, right)
        var topDistance = frame.origin.y
        var bottomDistance = parentView.bounds.height - frame.origin.y - frame.height
        var leftDistance = frame.origin.x
        var rightDistance = parentView.bounds.width - frame.origin.x - frame.width
        
        if topDistance < 0 {
            bottomDistance += -topDistance + distanceController.defaultTop
            topDistance = distanceController.defaultTop
        }
        if bottomDistance < 0 {
            topDistance -= -bottomDistance + distanceController.defaultBottom
            bottomDistance = distanceController.defaultBottom
        }
        if leftDistance < 0 {
            rightDistance = -leftDistance + distanceController.defaultLeft
            leftDistance = distanceController.defaultLeft
        }
        if rightDistance < 0 {
            leftDistance = -rightDistance + distanceController.defaultRight
            rightDistance = distanceController.defaultRight
        }
        
        let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1.0, constant: topDistance)
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1.0, constant: -bottomDistance)
        let leftConstraint = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: parentView, attribute: .left, multiplier: 1.0, constant: leftDistance)
        let rightConstraint = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: parentView, attribute: .right, multiplier: 1.0, constant: -rightDistance)
        translatesAutoresizingMaskIntoConstraints = false
        parentView.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
        parentView.setNeedsLayout()
    }
}

public struct DistanceController {
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
}
