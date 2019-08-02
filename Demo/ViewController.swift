import UIKit
import EasyAutoLayout

class ViewController: EasyAutoLayoutViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.subviews.forEach({setAutoLayout(targetView: $0)})        
    }
}

