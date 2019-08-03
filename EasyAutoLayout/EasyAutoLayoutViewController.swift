import Foundation

open class EasyAutoLayoutViewController: UIViewController {
    
    lazy var deviceAdjustment: DeviceAdjustMent = {
        let bounds = UIScreen.main.bounds
        var deviceAdjustment: DeviceAdjustMent = DeviceAdjustMent(displayDeviceType: nil)
        
        for deviceType in DeviceAdjustMent.allDeviceFrameList {
            if deviceType.frame == bounds {
                deviceAdjustment = DeviceAdjustMent(displayDeviceType: deviceType.type)
            }
        }
        
        return deviceAdjustment
    }()
    
    var easyLayoutSubViews: [EasyAutoLayoutView] {
        return view.subviews
    }
    
    var easyAutoLayoutCollisionStatusList: [ConstraintStatus] {
        return checkIsSubViewsIntersecting()
    }
    
    var layoutConstraints: [[NSLayoutConstraint]] = []
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if let displayDeviceType = deviceAdjustment.displayDeviceType {
            switch displayDeviceType {
                
            case .iPhone6, .iPhone6s, .iPhone7, .iPhone8:
                DeviceAdjustMent.widthMultiply = DeviceAdjustMent.iPhone6KindFrame.width / DeviceAdjustMent.iPhoneXKindFrame.width
                DeviceAdjustMent.heightMultiply = DeviceAdjustMent.widthMultiply
                
            case .iPhone6Plus, .iPhone7Plus, .iPhone8Plus, .iPhone6sPlus:
                DeviceAdjustMent.widthMultiply = DeviceAdjustMent.iPhone6PlusKindFrame.width / DeviceAdjustMent.iPhoneXKindFrame.width
                DeviceAdjustMent.heightMultiply = DeviceAdjustMent.widthMultiply
                
            case .iPhoneX, .iPhoneXS:
                DeviceAdjustMent.widthMultiply = DeviceAdjustMent.iPhoneXKindFrame.width / DeviceAdjustMent.iPhoneXKindFrame.width
                DeviceAdjustMent.heightMultiply = DeviceAdjustMent.widthMultiply
                
            case .iPhoneXR, .iPhoneXSMAX:
                DeviceAdjustMent.widthMultiply = DeviceAdjustMent.iPhoneXRKindFrame.width / DeviceAdjustMent.iPhoneXKindFrame.width
                DeviceAdjustMent.heightMultiply = DeviceAdjustMent.iPhoneXRKindFrame.height / DeviceAdjustMent.iPhoneXKindFrame.height
                
            case .iPhoneSE:
                DeviceAdjustMent.widthMultiply = DeviceAdjustMent.iPhoneSEFrame.width / DeviceAdjustMent.iPhoneXKindFrame.width
                DeviceAdjustMent.heightMultiply = DeviceAdjustMent.widthMultiply
            }
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutConstraints.forEach({$0.forEach({$0.isActive = true})})
    }
    
    public func setEasyAutoLayout(distance: Distance = Distance()) {
        for view in easyLayoutSubViews {
            if view.subviews.isNotEmpty {
                for childSubView in view.subviews {
                    layoutConstraints.append(setLayout(target: childSubView, parent: view))
                }
            }
            layoutConstraints.append(setLayout(target: view, parent: self.view))
        }
//        let isIntersectinfConstraintStatusList = easyAutoLayoutCollisionStatusList.filter({$0.isIntersecting})
//        for easyAutoLayoutCollisionStatus in isIntersectinfConstraintStatusList {
//            guard let me = easyAutoLayoutCollisionStatus.me, let target = easyAutoLayoutCollisionStatus.target else { return }
//            me.frame.origin.y += me.frame.origin.y < target.frame.origin.y ? -distance.defaultTop : distance.defaultTop
//            me.frame.origin.x += me.frame.origin.x < target.frame.origin.x ? -distance.defaultLeft : distance.defaultLeft
//        }
    }
    
    private func setLayout(target: EasyAutoLayoutView, parent: EasyAutoLayoutView) -> [NSLayoutConstraint] {
        return target.setAutoLayout(merge: true, parentView: parent, distanceController: Distance())
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
