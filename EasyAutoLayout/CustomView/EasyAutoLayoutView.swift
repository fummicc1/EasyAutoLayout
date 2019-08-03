import Foundation

struct ConstraintStatus {
    var me: EasyAutoLayoutView?
    var target: EasyAutoLayoutView?
    var isIntersecting: Bool
}

extension UIView {
    
    func setAutoLayout(merge: Bool, parentView: EasyAutoLayoutView, distanceController: Distance) -> [NSLayoutConstraint] {
        if !merge {
            // delete previous constraints unless merge.
            removeConstraints(constraints)
        }
        // current support constraints are 4 attributes (top, bottom, left, right)
        let topDistance = frame.origin.y * DeviceAdjustMent.heightMultiply
        let bottomDistance = (DeviceAdjustMent.iPhoneXKindFrame.maxY - frame.maxY) * DeviceAdjustMent.heightMultiply
        let leftDistance = frame.origin.x * DeviceAdjustMent.widthMultiply
        let rightDistance = (DeviceAdjustMent.iPhoneXKindFrame.maxX - frame.maxX) * DeviceAdjustMent.widthMultiply
        
        let topConstraint = self.topAnchor.constraint(equalTo: parentView.topAnchor, constant: topDistance)
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -bottomDistance)
        let leftConstraint = self.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: leftDistance)
        let rightConstraint = self.rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: -rightDistance)
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: frame.width * DeviceAdjustMent.widthMultiply)
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: frame.height * DeviceAdjustMent.heightMultiply)
        
        for constraint in [topConstraint, bottomConstraint] {
            if constraint.constant > UIScreen.main.bounds.height / 2 {
                constraint.priority = .defaultLow
            }
        }
        
        for constraint in [rightConstraint, leftConstraint] {
            if constraint.constant > UIScreen.main.bounds.width / 2 {
                constraint.priority = .defaultLow
            }
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        return [topConstraint, bottomConstraint, leftConstraint, rightConstraint, widthConstraint, heightConstraint]
    }
}

