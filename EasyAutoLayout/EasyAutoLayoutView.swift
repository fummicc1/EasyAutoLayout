import Foundation

extension EasyAutoLayoutView {
    
    func setAutoLayout<T>(
        merge: Bool,
        from: EasyAutoLayoutView,
        attributes: (from: KeyPath<EasyAutoLayoutView, T>, to: KeyPath<EasyAutoLayoutView, T>),
        distance: CGFloat,
        multiply: CGFloat,        
        isVerticle: Bool = true,
        priority: UILayoutPriority
        ) -> NSLayoutConstraint? {
        
        if self.superview != from.superview, from != self.superview {
            return nil
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if !merge {
            // delete previous constraints.
            removeConstraints(constraints)
        }
        
        let distance = isVerticle ? distance * DeviceAdjustMent.heightMultiply : distance * DeviceAdjustMent.widthMultiply
        let constraint: NSLayoutConstraint
        let fromAnchor = from[keyPath: attributes.from]
        let toAnchor = self[keyPath: attributes.to]
        if case let (_?, toAnchor?) = (fromAnchor as? NSLayoutDimension, toAnchor as? NSLayoutDimension)  {
            constraint = toAnchor.constraint(equalToConstant: distance)
            constraint.priority = priority
            return constraint
        } else if case let (fromAnchor?, toAnchor?) = (fromAnchor as? NSLayoutXAxisAnchor, toAnchor as? NSLayoutXAxisAnchor) {
            constraint = toAnchor.constraint(equalTo: fromAnchor, constant: distance)
            constraint.priority = priority
            return constraint
        } else if case let (fromAnchor?, toAnchor?) = (fromAnchor as? NSLayoutYAxisAnchor, toAnchor as? NSLayoutYAxisAnchor) {
            constraint = toAnchor.constraint(equalTo: fromAnchor, constant: distance)
            constraint.priority = priority
            return constraint
        }
        return nil
    }
}
