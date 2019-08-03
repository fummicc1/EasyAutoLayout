import Foundation

struct ConstraintStatus {
    var me: EasyAutoLayoutView?
    var target: EasyAutoLayoutView?
    var isIntersecting: Bool
}

extension UIView {
    
    func setAutoLayout(merge: Bool, parentView: EasyAutoLayoutView, distanceController: Distance) {
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
        let topAnchor = parentView.topAnchor.constraint(equalTo: self.topAnchor, constant: -topDistance)
        let bottomAnchor = parentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomDistance)
        let leftAnchor = parentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -leftDistance)
        let rightAnchor = parentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightDistance)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topAnchor, bottomAnchor, leftAnchor, rightAnchor])
    }
}

