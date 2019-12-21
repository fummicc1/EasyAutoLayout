import Foundation

extension EasyAutoLayout {
    
    public struct Info {
        
        public static let shared = Info()
        
        private let base: Device
        lazy var displayDevice: Device = {
            
            let size = UIScreen.main.bounds.size
            
            guard let display = EasyAutoLayout.allDevices.first(where: { $0.size == size }) else {
                fatalError("No matched device was found")
            }
            return display
        }()
        var widthMultiply: CGFloat = 1.0
        var heightMultiply: CGFloat = 1.0
        
        init(with name: Device.Name = .iPhoneX) {
            guard let base = Device(name) else {
                fatalError("No device whose name is \(name) was found")
            }
            self.base = base
        }
    }

    static let allDevices: [Device] = [
        .init(name: .iPhoneSE, size: iPhoneSESize),
        .init(name: .iPhone6, size: iPhone6KindSize),
        .init(name: .iPhone6Plus, size: iPhone6PlusKindSize),
        .init(name: .iPhone7, size: iPhone6KindSize),
        .init(name: .iPhone7Plus, size: iPhone6PlusKindSize),
        .init(name: .iPhone8, size: iPhone6KindSize),
        .init(name: .iPhone8Plus, size: iPhone6PlusKindSize),
        .init(name: .iPhoneX, size: iPhoneXKindSize),
        .init(name: .iPhoneXS, size: iPhoneXKindSize),
        .init(name: .iPhoneXR, size: iPhoneXRKindSize),
        .init(name: .iPhoneXSMax, size: iPhoneXSMaxKindSize),
        .init(name: .iPhone11, size: iPhoneXRKindSize),
        .init(name: .iPhone11Pro, size: iPhoneXKindSize),
        .init(name: .iPhone11ProMax, size: iPhoneXSMaxKindSize)
    ]
    
    static let iPhoneSESize = CGSize(width: 320, height: 568)
    static let iPhone6KindSize = CGSize(width: 375, height: 667)
    static let iPhone6PlusKindSize = CGSize(width: 414, height: 736)
    static let iPhoneXKindSize = CGSize(width: 375, height: 812)
    static let iPhoneXRKindSize = CGSize(width: 414, height: 896)
    static let iPhoneXSMaxKindSize = CGSize(width: 414, height: 896)

    public struct Device {
        /// e.g . "iPhoneX", "iPhone11"
        let name: Name
        /// e.g. (width: 414, height: 812)
        let size: CGSize
        
        public enum Name: String {
            case iPhoneSE
            case iPhone6
            case iPhone7
            case iPhone8
            case iPhone6Plus
            case iPhone7Plus
            case iPhone8Plus
            case iPhoneX
            case iPhoneXS
            case iPhoneXR
            case iPhoneXSMax
            case iPhone11
            case iPhone11Pro
            case iPhone11ProMax
        }
        
        public init?(_ name: Name) {
            self.name = name
            
            guard let size = EasyAutoLayout.allDevices.first(where: { $0.name == name })?.size else {
                return nil
            }
            
            self.size = size
        }
        
        init(name: Name, size: CGSize) {
            self.name = name
            self.size = size
        }
    }

}
