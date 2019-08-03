import UIKit
import EasyAutoLayout

class ViewController: EasyAutoLayoutViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setEasyAutoLayout()
    }
}

