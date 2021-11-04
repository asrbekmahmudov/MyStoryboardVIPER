
import Foundation

protocol EditInteractorProtocol {
    func apiContactEdit(contact: Contact)
}

class EditInteractor: EditInteractorProtocol {
    
    var manager: HttpManagerProtocol!
    var response: EditResponseProtocol!
    
    func apiContactEdit(contact: Contact) {
        manager.apiContactEdit(contact: contact, completion: { [self] result in
            response.onContactEdit(isEdited: result)
        })
    }
}
