import Foundation

protocol LayoutAnchorInterface {}

extension NSLayoutYAxisAnchor: LayoutAnchorInterface {}
extension NSLayoutXAxisAnchor: LayoutAnchorInterface {}
extension NSLayoutDimension: LayoutAnchorInterface {}

extension EasyAutoLayoutView {
    func getAnchor(from layoutAnchor: LayoutAnchor) -> LayoutAnchorInterface {
        switch layoutAnchor {
        case .top:
            return topAnchor
        case .bottom:
            return bottomAnchor
        case .left:
            return leftAnchor
        case .right:
            return rightAnchor
        case .width:
            return widthAnchor
        case .height:
            return heightAnchor
        }
    }
}

extension EasyAutoLayoutView {
    
    func setAutoLayout(merge: Bool, neighborhoodView: EasyAutoLayoutView) -> [NSLayoutConstraint] {
        guard self.superview == neighborhoodView.superview else { return [] }
        
        translatesAutoresizingMaskIntoConstraints = false
        neighborhoodView.translatesAutoresizingMaskIntoConstraints = false
        
        if !merge {
            // delete previous constraints.
            removeConstraints(constraints)
        }
        
        let topDistance = (neighborhoodView.frame.origin.y - frame.origin.y) * DeviceAdjustMent.heightMultiply
        let bottomDistance = (neighborhoodView.frame.maxY - frame.maxY) * DeviceAdjustMent.heightMultiply
        let leftDistance = (neighborhoodView.frame.origin.x - frame.origin.x) * DeviceAdjustMent.widthMultiply
        let rightDistance = (neighborhoodView.frame.maxX - neighborhoodView.frame.maxX) * DeviceAdjustMent.widthMultiply
        
        let topConstraint = topAnchor.constraint(equalTo: neighborhoodView.topAnchor, constant: topDistance)
        let bottomConstraint = bottomAnchor.constraint(equalTo: neighborhoodView.bottomAnchor, constant: bottomDistance)
        let leftConstraint = leftAnchor.constraint(equalTo: neighborhoodView.leftAnchor, constant: leftDistance)
        let rightConstraint = rightAnchor.constraint(equalTo: neighborhoodView.rightAnchor, constant: rightDistance)
        
        return [
            topConstraint, bottomConstraint, leftConstraint, rightConstraint
        ]
    }
    
    
    func setAutoLayout(merge: Bool, parentView: EasyAutoLayoutView, distanceController: Distance, attributes: [LayoutAnchor]) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        if !merge {
            // delete previous constraints.
            removeConstraints(constraints)
        }
        // current support constraints are 4 attributes (top, bottom, left, right)
        let topDistance = frame.origin.y * DeviceAdjustMent.heightMultiply
        let bottomDistance = (DeviceAdjustMent.iPhoneXKindFrame.maxY - frame.maxY) * DeviceAdjustMent.heightMultiply
        let leftDistance = frame.origin.x * DeviceAdjustMent.widthMultiply
        let rightDistance = (DeviceAdjustMent.iPhoneXKindFrame.maxX - frame.maxX) * DeviceAdjustMent.widthMultiply
        
        for attribute in attributes {
            let anchor = getAnchor(from: attribute)
            if let anchorY = anchor as? NSLayoutAnchor<NSLayoutYAxisAnchor> {
                
            } else if let anchorX = anchor as? NSLayoutAnchor<NSLayoutXAxisAnchor> {
                
            } else if let widthOrHeightAnchor = anchor as? NSLayoutAnchor<NSLayoutDimension> {
                widthOrHeightAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutDimension>#>)
            }
        }
    }
}

