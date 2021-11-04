
import Foundation

protocol CreateRoutingProtocol {
    func closeCreateScreen()
}

class CreateRouting: CreateRoutingProtocol {
    
    weak var viewController: CreateViewController!
    
    func closeCreateScreen() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
