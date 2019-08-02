import UIKit
import EasyAutoLayout

class ViewController: EasyAutoLayoutViewController {

    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    
    func setupLayout() {
        let layoutViews = view.subviews.compactMap({$0 as? EasyAutoLayoutView})
        for layoutView in layoutViews {
            setAutoLayout(targetView: layoutView)
        }
    }
}

