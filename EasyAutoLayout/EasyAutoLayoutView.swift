import Foundation

extension EasyAutoLayoutView {
    func getAnchor(from layoutAnchor: LayoutAnchor, top: ((NSLayoutYAxisAnchor) -> ())?, bottom: ((NSLayoutYAxisAnchor) -> ())?, left: ((NSLayoutXAxisAnchor) -> ())?, right: ((NSLayoutXAxisAnchor) -> ())?, width: ((NSLayoutDimension) -> ())?, height: ((NSLayoutDimension) -> ())?) {
        switch layoutAnchor {
        case .top:
            top?(topAnchor)
        case .bottom:
            bottom?(bottomAnchor)
        case .left:
            left?(leftAnchor)
        case .right:
            right?(rightAnchor)
        case .width:
            width?(widthAnchor)
        case .height:
            height?(heightAnchor)
        }
    }
}

extension EasyAutoLayoutView {
    
    func setAutoLayout(merge: Bool, neighborhoodView: EasyAutoLayoutView, attributes: [(from: LayoutAnchor, to: LayoutAnchor)] ) -> [NSLayoutConstraint] {
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
        
        var constraintList: [NSLayoutConstraint] = []
        
        for attribute in attributes {
            getAnchor(from: attribute.from, top: { (anchor) in
                
                neighborhoodView.getAnchor(from: attribute.to, top: { (neighborAnchor) in
                    constraintList.append(anchor.constraint(equalTo: neighborAnchor, constant: topDistance))
                }, bottom: { (neighborAnchor) in
                    constraintList.append(anchor.constraint(equalTo: neighborAnchor, constant: topDistance))
                }, left: nil, right: nil, width: nil, height: nil)
            }, bottom: { (anchor) in
                constraintList.append(anchor.constraint(equalTo: neighborhoodView.bottomAnchor, constant: -bottomDistance))
            }, left: { (anchor) in
                constraintList.append(anchor.constraint(equalTo: neighborhoodView.leftAnchor, constant: leftDistance))
            }, right: { (anchor) in
                constraintList.append(anchor.constraint(equalTo: neighborhoodView.rightAnchor, constant: -rightDistance))
            }, width: { (anchor) in
                assert(false) // not implemented
            }, height: { (anchor) in
                assert(false) // not implemented
            })
        }
        return constraintList
    }
    
    
    func setAutoLayout(merge: Bool, parentView: EasyAutoLayoutView, distanceController: Distance, attributes: [(from: LayoutAnchor, to: LayoutAnchor)]) -> [NSLayoutConstraint] {
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
        
        var constraintList: [NSLayoutConstraint] = []
        
        for attribute in attributes {
            getAnchor(from: attribute, top: { (anchor) in
                        constraintList.append(anchor.constraint(equalTo: parentView.topAnchor, constant: topDistance))
            }, bottom: { (anchor) in
                constraintList.append(anchor.constraint(equalTo: parentView.bottomAnchor, constant: -bottomDistance))
            }, left: { (anchor) in
                constraintList.append(anchor.constraint(equalTo: parentView.leftAnchor, constant: leftDistance))
            }, right: { (anchor) in
                constraintList.append(anchor.constraint(equalTo: parentView.rightAnchor, constant: -rightDistance))
            }, width: { (anchor) in
                assert(false) // not implemented
            }, height: { (anchor) in
                assert(false) // not implemented
            })
        }
        return constraintList
    }
}

