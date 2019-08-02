import Foundation

open class EasyAutoLayoutViewController: UIViewController {
    
    open func setAutoLayout(targetView target: UIView, merge: Bool = false, _ parent: UIView? = nil) {
        var parent = parent
        if parent == nil {
            parent = target.superview
        }
        guard let _parent = parent else {
            fatalError("no superView founded!")
        }
        target.setAutoLayout(merge: merge, parentView: _parent)
    }
}

extension UIView {
    
    func setAutoLayout(merge: Bool, parentView: UIView) {
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
            bottomDistance += -topDistance + 32
            topDistance = 32
        }
        if bottomDistance < 0 {
            topDistance -= -bottomDistance + 32
            bottomDistance = 32
        }
        if leftDistance < 0 {
            rightDistance = -leftDistance + 32
            leftDistance = 32
        }
        if rightDistance < 0 {
            leftDistance = -rightDistance + 32
            rightDistance = 32
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
