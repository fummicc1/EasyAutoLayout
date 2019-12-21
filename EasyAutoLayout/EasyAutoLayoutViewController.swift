import Foundation

public protocol EasyAutoLayoutDataSource: class {
    var _info: EasyAutoLayout.Info { get }
    var _subViews: [EasyAutoLayout.View] { get }
}

protocol EasyAutoLayoutDelegate: class {
    func _addSubView(_ view: EasyAutoLayout.View)
}

extension EasyAutoLayoutDataSource where Self: UIViewController {
    
    
    var _subViews: [EasyAutoLayout.View] {
        return view.subviews
    }
    
}


extension EasyAutoLayoutDelegate where Self: UIViewController {
    func _addSubView(_ view: EasyAutoLayout.View) {
        self.view.addSubview(view)
    }
}
