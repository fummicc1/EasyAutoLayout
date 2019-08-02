import Foundation

open class EasyAutoLayoutViewController: UIViewController {
    
    private func fixLayout() {
        
    }
    
    open func setAutoLayout(targetView target: EasyAutoLayoutView, merge: Bool = false, _ parent: UIView? = nil) {
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

open class EasyAutoLayoutView: UIView {
    
    open var priority: EasyPriority
    
    public init(frame: CGRect, priority: EasyPriority = .center) {
        self.priority = priority
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        
        let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1.0, constant: topDistance)
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1.0, constant: bottomDistance)
        let leftConstraint = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: parentView, attribute: .left, multiplier: 1.0, constant: leftDistance)
        let rightConstraint = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: parentView, attribute: .right, multiplier: 1.0, constant: rightDistance)
        addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
        setNeedsLayout()
        layoutIfNeeded()
    }
}

public enum EasyPriority {
    case center
    case left
    case right
    case top
    case bottom
}
