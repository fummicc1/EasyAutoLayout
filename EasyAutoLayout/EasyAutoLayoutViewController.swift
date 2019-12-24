import Foundation

public protocol EasyAutoLayoutDataSource: class {
    var info: EasyAutoLayout.Info { get }
    var subViews: [EasyAutoLayout.View] { get }
    
    func addConstraint(_ constraint: NSLayoutConstraint, to target: EasyAutoLayout.View)
    
    func beginLayout()
    func commitLayout()
}

protocol EasyAutoLayoutDelegate: class {
    func addSubView(_ view: EasyAutoLayout.View)
}

extension EasyAutoLayoutDataSource where Self: UIViewController {
    
    
    var subViews: [EasyAutoLayout.View] {
        return view.subviews
    }
    
}


extension EasyAutoLayoutDelegate where Self: UIViewController {
    func addSubView(_ view: EasyAutoLayout.View) {
        self.view.addSubview(view)
    }
}


open class EasyAutoLayoutViewController: UIViewController, EasyAutoLayoutDataSource, EasyAutoLayoutDelegate {
    public var info: EasyAutoLayout.Info
    
    public var subViews: [EasyAutoLayout.View] = []
    
    public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, info: EasyAutoLayout.Info) {
        self.info = info
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder: NSCoder) {
        self.info = EasyAutoLayout.Info()
        super.init(coder: coder)
    }
    
    public func addConstraint(_ constraint: NSLayoutConstraint, to target: EasyAutoLayout.View) {
        
    }
    
    public func beginLayout() {
        
    }
    
    public func commitLayout() {
        
    }
    
    func addSubView(_ view: EasyAutoLayout.View) {
        
    }
    
    
}
