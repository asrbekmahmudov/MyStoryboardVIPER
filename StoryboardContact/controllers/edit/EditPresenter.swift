
import Foundation

protocol EditPresenterProtocol: EditRequestProtocol {
    func apiContactEdit(contact: Contact)
    func closeEditScreen()
}

class EditPresenter: EditPresenterProtocol {
    
    var routing: EditRoutingProtocol!
    var interactor: EditInteractorProtocol!
    
    var controller: BaseViewController!
    
    func apiContactEdit(contact: Contact) {
        controller.showProgress()
        interactor.apiContactEdit(contact: contact)
    }
    
    func closeEditScreen() {
        routing.closeEditScreen()
    }
    
}
