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
        setEasyAutoLayout()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutConstraints.forEach({$0.forEach({$0.isActive = true})})
    }
    
    public func setEasyAutoLayout(distance: Distance = Distance()) {
        let subViewsOrderedByTop = view.subviews.sorted { $0.frame.origin.y < $1.frame.origin.y }
        for (index, view) in subViewsOrderedByTop.enumerated() {
            
            let top = \EasyAutoLayoutView.topAnchor as! WritableKeyPath<EasyAutoLayoutView, NSLayoutYAxisAnchor>
            let bottom = \EasyAutoLayoutView.bottomAnchor as! WritableKeyPath<EasyAutoLayoutView, NSLayoutYAxisAnchor>
            
            if subViewsOrderedByTop.last == view { // 一番下にあるビューに対しては親と.bottom, １つ上のビューとは.topを制約する。
                
                setLayout(target: view, from: self.view, attributes: (from: bottom, to: bottom), distance: (from: \EasyAutoLayoutView.frame.maxY, to: \EasyAutoLayoutView.frame.maxY), multiply: 1, isVerticle: true)
                
                setLayout(target: view, from: subViewsOrderedByTop[index-1], attributes: (from: bottom, to: top), distance: (from: \EasyAutoLayoutView.frame.maxY, to: \EasyAutoLayoutView.frame.origin.y), multiply: 1, isVerticle: true)
                
                continue
            } else if subViewsOrderedByTop.first == view { // 一番上にあるビューに対しては親と.top, １つ上のビューとは.bottomを制約する。
                
                setLayout(target: view, from: self.view, attributes: (from: top, to: top), distance: (from: \EasyAutoLayoutView.frame.origin.y, to: \EasyAutoLayoutView.frame.origin.y), multiply: 1, isVerticle: true)
                
                setLayout(target: view, from: subViewsOrderedByTop[index+1], attributes: (from: bottom, to: top), distance: (from: \EasyAutoLayoutView.frame.maxY, to: \EasyAutoLayoutView.frame.origin.y), multiply: 1, isVerticle: true)
                
                continue
            }
            // 何かに挟まれているビューの制約は.topと.bottom
            
            setLayout(target: view, from: subViewsOrderedByTop[index-1], attributes: (from: bottom, to: top), distance: (from: \EasyAutoLayoutView.frame.maxY, to: \EasyAutoLayoutView.frame.origin.y), multiply: 1, isVerticle: true)
            
            setLayout(target: view, from: subViewsOrderedByTop[index+1], attributes: (from: top, to: bottom), distance: (from: \EasyAutoLayoutView.frame.origin.y, to: \EasyAutoLayoutView.frame.maxY), multiply: 1, isVerticle: true)
        }
    }
    
    private func setLayout<T>(
        target: EasyAutoLayoutView,
        from: EasyAutoLayoutView,
        attributes: (from: WritableKeyPath<EasyAutoLayoutView, T>, to: WritableKeyPath<EasyAutoLayoutView, T>),
        distance: (from: KeyPath<EasyAutoLayoutView, CGFloat>, to: KeyPath<EasyAutoLayoutView, CGFloat>),
        multiply: CGFloat = 1,
        isVerticle: Bool
        ) {
        guard let constraint = target.setAutoLayout(merge: true, from: from, attributes: attributes, distance: distance, multiply: multiply, isVerticle: isVerticle) else { return }
        self.layoutConstraints.append([constraint])
    }
}
