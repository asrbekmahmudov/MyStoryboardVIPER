
import Foundation

protocol CreatePresenterProtocol: CreateRequestProtocol {
    func apiContactCreate(contact: Contact)
    
    func closeCreateScreen()
}

class CreatePresenter: CreatePresenterProtocol {
    
    var routing: CreateRoutingProtocol!
    var interactor: CreateInteractorProtocol!
    
    var controller: BaseViewController!
    
    func apiContactCreate(contact: Contact) {
        controller.showProgress()
        interactor.apiContactCreate(contact: contact)
    }
    
    func closeCreateScreen() {
        routing.closeCreateScreen()
    }
}
