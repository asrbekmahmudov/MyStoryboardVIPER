
import Foundation

protocol EditRoutingProtocol {
    func closeEditScreen()
}

class EditRouting: EditRoutingProtocol {
    weak var viewController: EditViewController!
    
    func closeEditScreen() {
        viewController.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
