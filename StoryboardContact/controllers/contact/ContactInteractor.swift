
import Foundation

protocol ContactInteractorProtocol {
    func apiContactList()
    func apiContactDelete(contact: Contact)
}

class ContactInteractor: ContactInteractorProtocol {
    var manager: HttpManagerProtocol!
    var response: ContactResponseProtocol!
    
    func apiContactList() {
        manager.apiContactList(completion: { [self] result in
            response.onLoadContact(contacts: result)
        })
    }
    
    func apiContactDelete(contact: Contact) {
        manager.apiContactDelete(contact: contact, completion: { [self] result in
            response.onDeleteContact(isDeleted: result)
        })
    }
    
}
