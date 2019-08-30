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
    
    func setAutoLayout<T>(
        merge: Bool,
        from: EasyAutoLayoutView,
        attributes: (from: WritableKeyPath<EasyAutoLayoutView, T>, to: WritableKeyPath<EasyAutoLayoutView, T>),
        distance: (from: KeyPath<EasyAutoLayoutView, CGFloat>, to: KeyPath<EasyAutoLayoutView, CGFloat>),
        multiply: CGFloat,        
        isVerticle: Bool = true
        ) -> NSLayoutConstraint? {
        guard self.superview == from.superview else { return nil }
        
        translatesAutoresizingMaskIntoConstraints = false
        from.translatesAutoresizingMaskIntoConstraints = false
        
        if !merge {
            // delete previous constraints.
            removeConstraints(constraints)
        }

        var distance = (from[keyPath: distance.from] - self[keyPath: distance.to])
        
        distance = isVerticle ? distance * DeviceAdjustMent.heightMultiply : DeviceAdjustMent.widthMultiply
        var constraint: NSLayoutConstraint
        let from = from[keyPath: attributes.from]
        let to = self[keyPath: attributes.to]
        
        if case let (from?, to?) = (from as? NSLayoutDimension, to as? NSLayoutDimension)  {
            constraint = from.constraint(equalTo: to, multiplier: multiply)
            return constraint
        } else if case let (from?, to?) = (from as? NSLayoutXAxisAnchor, to as? NSLayoutXAxisAnchor) {
            constraint = from.constraint(equalTo: to, constant: distance)
            return constraint
        } else if case let (from?, to?) = (from as? NSLayoutYAxisAnchor, to as? NSLayoutYAxisAnchor) {
            constraint = from.constraint(equalTo: to, constant: distance)
            return constraint
        }
        return nil
    }
}

