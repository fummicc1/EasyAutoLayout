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
    
    var layoutConstraints: [NSLayoutConstraint] = []
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if let displayDeviceType = deviceAdjustment.displayDeviceType {
            switch displayDeviceType {
                
            case .iPhone6, .iPhone6s, .iPhone7, .iPhone8:
                DeviceAdjustMent.widthMultiply = DeviceAdjustMent.iPhone6KindFrame.width / DeviceAdjustMent.iPhoneXKindFrame.width
                DeviceAdjustMent.heightMultiply = DeviceAdjustMent.iPhone6KindFrame.height / DeviceAdjustMent.iPhoneXKindFrame.height
                
            case .iPhone6Plus, .iPhone7Plus, .iPhone8Plus, .iPhone6sPlus:
                DeviceAdjustMent.widthMultiply = DeviceAdjustMent.iPhone6PlusKindFrame.width / DeviceAdjustMent.iPhoneXKindFrame.width
                DeviceAdjustMent.heightMultiply = DeviceAdjustMent.iPhone6PlusKindFrame.height / DeviceAdjustMent.iPhoneXKindFrame.height
                
            case .iPhoneX, .iPhoneXS:
                DeviceAdjustMent.widthMultiply = 1.0
                DeviceAdjustMent.heightMultiply = 1.0
                
            case .iPhoneXR, .iPhoneXSMAX:
                DeviceAdjustMent.widthMultiply = DeviceAdjustMent.iPhoneXRKindFrame.width / DeviceAdjustMent.iPhoneXKindFrame.width
                DeviceAdjustMent.heightMultiply = DeviceAdjustMent.iPhoneXRKindFrame.height / DeviceAdjustMent.iPhoneXKindFrame.height
                
            case .iPhoneSE:
                DeviceAdjustMent.widthMultiply = DeviceAdjustMent.iPhoneSEFrame.width / DeviceAdjustMent.iPhoneXKindFrame.width
                DeviceAdjustMent.heightMultiply = DeviceAdjustMent.iPhoneSEFrame.height / DeviceAdjustMent.iPhoneXKindFrame.height
            }
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setEasyAutoLayout()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setEasyAutoLayout() {
        
        let subViewsOrderedByTop = view.subviews.sorted { $0.frame.origin.y < $1.frame.origin.y }
        let subViewsSizeOrderedByTop = subViewsOrderedByTop.map { $0.frame }
        for (index, subview) in subViewsOrderedByTop.enumerated() {
            
            let top = \EasyAutoLayoutView.topAnchor
            let bottom = \EasyAutoLayoutView.bottomAnchor
            let height = \EasyAutoLayoutView.heightAnchor
            
            if subViewsOrderedByTop.last == subview { // 一番下にあるビューに対しては親と.bottom, １つ上のビューとは.topを制約する。
                
                setLayout(
                    target: subview,
                    from: self.view,
                    attributes: (from: bottom, to: bottom),
                    distance: (-self.view.frame.maxY + subViewsSizeOrderedByTop[index].maxY * DeviceAdjustMent.heightMultiply),
                    isVerticle: true
                )
                
                setLayout(
                    target: subview,
                    from: subViewsOrderedByTop[index-1],
                    attributes: (from: bottom, to: top),
                    distance: (subViewsSizeOrderedByTop[index].origin.y - subViewsOrderedByTop[index-1].frame.maxY),
                    isVerticle: true
                )
                setLayout(
                    target: subview,
                    from: subview,
                    attributes: (from: height, to: height),
                    distance: subViewsSizeOrderedByTop[index].height,
                    isVerticle: true
                )
                continue
            } else if subViewsOrderedByTop.first == subview { // 一番上にあるビューに対しては親と.top, １つ上のビューとは.bottomを制約する。
                
                setLayout(
                    target: subview,
                    from: self.view,
                    attributes: (from: top, to: top),
                    distance: (subViewsSizeOrderedByTop[index].origin.y * DeviceAdjustMent.heightMultiply - self.view.frame.origin.y),
                    isVerticle: true
                )
                
                setLayout(
                    target: subview,
                    from: subViewsOrderedByTop[index+1],
                    attributes: (from: top, to: bottom),
                    distance: (subViewsSizeOrderedByTop[index].maxY - subViewsOrderedByTop[index+1].frame.origin.y),
                    isVerticle: true
                )
                
                setLayout(target: subview,
                          from: subview,
                          attributes: (from: height, to: height),
                          distance: subViewsSizeOrderedByTop[index].height,
                          isVerticle: true
                )
                continue
            }
            // 何かに挟まれているビューの制約は.topと.bottom
            
            setLayout(
                target: subview,
                from: subViewsOrderedByTop[index-1],
                attributes: (from: bottom, to: top),
                distance: (subViewsSizeOrderedByTop[index].origin.y - subViewsOrderedByTop[index-1].frame.maxY),
                isVerticle: true
            )
            
            setLayout(
                target: subview,
                from: subViewsOrderedByTop[index+1],
                attributes: (from: top, to: bottom),
                distance: (subViewsSizeOrderedByTop[index].maxY - subViewsOrderedByTop[index+1].frame.origin.y),
                isVerticle: true
            )
            
            setLayout(
                target: subview,
                from: subview,
                attributes: (from: height, to: height),
                distance: subViewsSizeOrderedByTop[index].height,
                isVerticle: true
            )
        }
        
        let subViewsOrderedByLeft = view.subviews.sorted { $0.frame.origin.x < $1.frame.origin.x }
        let subViewsSizeOrderedByLeft = subViewsOrderedByLeft.map { $0.frame }
        
        for (index, subview) in subViewsOrderedByLeft.enumerated() {
            
            let left = \EasyAutoLayoutView.leftAnchor
            let right = \EasyAutoLayoutView.rightAnchor
            let width = \EasyAutoLayoutView.widthAnchor
            
            if subViewsOrderedByLeft.last == subview { // 一番右にあるビューに対しては親のrightと自分のright, １つ左のビューのrightと自分のleftを制約する。
                
                setLayout(
                    target: subview,
                    from: self.view,
                    attributes: (from: right, to: right),
                    distance: (subViewsSizeOrderedByLeft[index].maxX * DeviceAdjustMent.widthMultiply - self.view.frame.maxX),
                    isVerticle: false
                )
                
                setLayout(
                    target: subview,
                    from: subViewsOrderedByLeft[index-1],
                    attributes: (from: right, to: left),
                    distance: (subViewsSizeOrderedByLeft[index].origin.x - subViewsOrderedByLeft[index-1].frame.maxX),
                    isVerticle: false
                )
                
                setLayout(target: subview,
                          from: subview,
                          attributes: (from: width, to: width),
                          distance: subViewsSizeOrderedByLeft[index].width,
                          isVerticle: false
                )
                continue
            } else if subViewsOrderedByLeft.first == subview { //  一番左にあるビューに対しては親のleftと自分のleft, １つ右のビューのleftと自分のrightを制約する。
                
                setLayout(
                    target: subview,
                    from: self.view,
                    attributes: (from: left, to: left),
                    distance: (subViewsSizeOrderedByLeft[index].origin.x * DeviceAdjustMent.widthMultiply - self.view.frame.origin.x),
                    isVerticle: false
                )
                
                setLayout(
                    target: subview,
                    from: subViewsOrderedByLeft[index+1],
                    attributes: (from: left, to: right),
                    distance: (subViewsSizeOrderedByLeft[index].maxX - subViewsOrderedByLeft[index+1].frame.origin.x),
                    isVerticle: false
                )
                
                setLayout(target: subview,
                          from: subview,
                          attributes: (from: width, to: width),
                          distance: subViewsSizeOrderedByLeft[index].width,
                          isVerticle: false
                )
                continue
            }
            
//            subview.setContentCompressionResistancePriority(.init(699), for: .horizontal)
            
            // 何かに挟まれているビューの制約は.leftと.right
            setLayout(
                target: subview,
                from: subViewsOrderedByLeft[index-1],
                attributes: (from: right, to: left),
                distance: (subview.frame.origin.x - subViewsOrderedByLeft[index-1].frame.maxX),
                isVerticle: false
            )
            setLayout(
                target: subview,
                from: subViewsOrderedByLeft[index+1],
                attributes: (from: left, to: right),
                distance: (subview.frame.maxX - subViewsOrderedByLeft[index+1].frame.origin.x),
                isVerticle: false
            )
            setLayout(
                target: subview,
                from: subview,
                attributes: (from: width, to: width),
                distance: subViewsSizeOrderedByLeft[index].width,
                isVerticle: false
            )
        }        
        layoutConstraints.forEach({$0.isActive = true})
    }
    
    private func setLayout<T>(
        target: EasyAutoLayoutView,
        from: EasyAutoLayoutView,
        attributes: (from: KeyPath<EasyAutoLayoutView, T>, to: KeyPath<EasyAutoLayoutView, T>),
        distance: CGFloat,
        multiply: CGFloat = 1,
        isVerticle: Bool,
        priority: UILayoutPriority = .required
        ) {
        guard let constraint = target.setAutoLayout(merge: true, from: from, attributes: attributes, distance: distance, multiply: multiply, isVerticle: isVerticle, priority: priority) else {
            return        
        }
        self.layoutConstraints.append(constraint)
    }
}
