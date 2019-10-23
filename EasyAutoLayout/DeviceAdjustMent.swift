import Foundation

struct DeviceAdjustMent {
    
    var defaultDeviceType: DeviceType
    var displayDeviceType: DeviceType?
    static var widthMultiply: CGFloat = 1.0
    static var heightMultiply: CGFloat = 1.0
    
    init(defaultDeviceType: DeviceType = .iPhoneX, displayDeviceType: DeviceType?) {
        self.defaultDeviceType = defaultDeviceType
        self.displayDeviceType = displayDeviceType
    }
}

extension DeviceAdjustMent {
    
    static var allDeviceFrameList: [(type: DeviceType, frame: CGRect)] {
        return [
            (DeviceType.iPhoneSE, DeviceAdjustMent.iPhoneSEFrame),
            (DeviceType.iPhone6, DeviceAdjustMent.iPhone6KindFrame),
            (DeviceType.iPhone6s, DeviceAdjustMent.iPhone6KindFrame),
            (DeviceType.iPhone7, DeviceAdjustMent.iPhone6KindFrame),
            (DeviceType.iPhone8, DeviceAdjustMent.iPhone6KindFrame),
            (DeviceType.iPhone6Plus, DeviceAdjustMent.iPhone6PlusKindFrame),
            (DeviceType.iPhone6sPlus, DeviceAdjustMent.iPhone6PlusKindFrame),
            (DeviceType.iPhone7Plus, DeviceAdjustMent.iPhone6PlusKindFrame),
            (DeviceType.iPhone8Plus, DeviceAdjustMent.iPhone6PlusKindFrame),
            (DeviceType.iPhoneX, DeviceAdjustMent.iPhoneXKindFrame),
            (DeviceType.iPhoneXS, DeviceAdjustMent.iPhoneXKindFrame),
            (DeviceType.iPhoneXSMAX, DeviceAdjustMent.iPhoneXRKindFrame),
            (DeviceType.iPhoneXR, DeviceAdjustMent.iPhoneXRKindFrame),
        ]
    }
    
    static let iPhoneSEFrame = CGRect(origin: .zero, size: .init(width: 320, height: 568))
    static let iPhone6KindFrame = CGRect(origin: .zero, size: .init(width: 375, height: 667))
    static let iPhone6PlusKindFrame = CGRect(origin: .zero, size: .init(width: 414, height: 736))
    static let iPhoneXKindFrame = CGRect(origin: .zero, size: .init(width: 375, height: 812))
    static let iPhoneXRKindFrame = CGRect(origin: .zero, size: .init(width: 414, height: 896))
}
