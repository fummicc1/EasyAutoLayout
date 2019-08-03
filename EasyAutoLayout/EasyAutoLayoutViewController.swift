import Foundation

open class EasyAutoLayoutViewController: UIViewController {
    
    var easyLayoutSubViews: [EasyAutoLayoutView] {
        return view.subviews
    }
    
    var easyAutoLayoutCollisionStatusList: [ConstraintStatus] {
        return checkIsSubViewsIntersecting()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public func setEasyAutoLayout() {
        for view in easyLayoutSubViews {
            if view.subviews.isNotEmpty {
                for childSubView in view.subviews {
                    setLayout(target: childSubView, parent: view)
                }
            }
            setLayout(target: view, parent: self.view)
        }
        let isIntersectinfConstraintStatusList = easyAutoLayoutCollisionStatusList.filter({$0.isIntersecting})
        for easyAutoLayoutCollisionStatus in isIntersectinfConstraintStatusList {
            guard let me = easyAutoLayoutCollisionStatus.me, let target = easyAutoLayoutCollisionStatus.target else { return }
            me.frame.origin.y += me.frame.origin.y < target.frame.origin.y ? -32 : 32
            me.frame.origin.x += me.frame.origin.x < target.frame.origin.x ? -32 : 32
        }
    }
    
    private func setLayout(target: EasyAutoLayoutView, parent: EasyAutoLayoutView) {
        target.setAutoLayout(merge: true, parentView: parent, distanceController: Distance())
    }
    
    func checkIsSubViewsIntersecting() -> [ConstraintStatus] {
        
        let subViewsSortedByY = easyLayoutSubViews.sorted(by: {$0.frame.minY < $1.frame.minY})
        
        var resultList: [ConstraintStatus] = []
        
        for (index, subView) in subViewsSortedByY.enumerated() {
            let compareView: EasyAutoLayoutView
            if index == subViewsSortedByY.count - 1 {
                compareView = subViewsSortedByY[index - 1]
            } else {
                compareView = subViewsSortedByY[(index + 1)]
            }
            if subView.superview != compareView.superview { continue }
            let collisionStatus = ConstraintStatus(me: subView, target: compareView, isIntersecting: subView.frame.intersects(compareView.frame))
            resultList.append(collisionStatus)
        }
        return resultList
    }
}
