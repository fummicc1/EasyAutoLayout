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
            if subViewsOrderedByTop.last == view { // 一番下にあるビューに対しては親と.bottom, １つ上のビューとは.topを制約する。
                layoutConstraints.append(
                    setLayout(target: view, parent: self.view, attributes: [.bottom])
                )                
                continue
            } else if subViewsOrderedByTop.first == view { // 一番上にあるビューに対しては親と.top, １つ上のビューとは.bottomを制約する。
                layoutConstraints.append(
                    setLayout(target: view, parent: self.view, attributes: [.top])
                )
                layoutConstraints.append(
                    setLayout(target: view, neighborhoodView: subViewsOrderedByTop[index+1], attributes: [.bottom])
                )
                continue
            }
            // 何かに挟まれているビューの制約は.topと.bottom
            layoutConstraints.append(contentsOf: [
                setLayout(target: view, neighborhoodView: subViewsOrderedByTop[index+1], attributes: [.bottom]),
                setLayout(target: view, neighborhoodView: subViewsOrderedByTop[index-1], attributes: [.top])
                ])
        }
    }
    
    private func setLayout(target: EasyAutoLayoutView, neighborhoodView: EasyAutoLayoutView, attributes: [(from: LayoutAnchor, to: LayoutAnchor)]) -> [NSLayoutConstraint] {
        return target.setAutoLayout(merge: true, neighborhoodView: neighborhoodView, attributes: attributes)
    }
    
    private func setLayout(target: EasyAutoLayoutView, parent: EasyAutoLayoutView, attributes: [(from: LayoutAnchor, to: LayoutAnchor)]) -> [NSLayoutConstraint] {
        return target.setAutoLayout(merge: true, parentView: parent, distanceController: Distance(), attributes: attributes)
    }
}
