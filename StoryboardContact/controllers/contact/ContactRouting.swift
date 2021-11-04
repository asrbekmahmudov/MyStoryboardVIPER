
import Foundation

protocol ContactRoutingProtocol {
    func navigateCreateScreen()
    func navigateEditScreen(contact: Contact)
}

class ContactRouting: ContactRoutingProtocol {
    
    weak var viewController: ContactViewController!
    
    func navigateCreateScreen() {
        viewController.callCreateViewController()
    }
    
    func navigateEditScreen(contact: Contact) {
        viewController.callEditViewConroller(contact: contact)
    }
    
}
