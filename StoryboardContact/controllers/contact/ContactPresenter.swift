
import Foundation

protocol ContactPresenterProtocol: ContactRequestProtocol {
    func apiContactList()
    func apiContactDelete(contact: Contact)
    
    func navigateCreateScreen()
    func navigateEditScreen(contact: Contact)
}

class ContactPresenter: ContactPresenterProtocol {
    var routing: ContactRouting!
    var interactor: ContactInteractor!
    
    var controller: BaseViewController!
    
    func apiContactList() {
        controller.showProgress()
        interactor.apiContactList()
    }
    
    func apiContactDelete(contact: Contact) {
        controller.showProgress()
        interactor.apiContactDelete(contact: contact)
    }
    
    func navigateCreateScreen() {
        routing.navigateCreateScreen()
    }
    
    func navigateEditScreen(contact: Contact) {
        routing.navigateEditScreen(contact: contact)
    }
    
}
