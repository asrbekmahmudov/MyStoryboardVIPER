
import UIKit

protocol EditRequestProtocol {
    func apiContactEdit(contact: Contact)
    func closeEditScreen()
}

protocol EditResponseProtocol {
    func onContactEdit(isEdited: Bool)
}

class EditViewController: BaseViewController, EditResponseProtocol {
    func onContactEdit(isEdited: Bool) {
        hideProgress()
    }
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    
    var contact = Contact()
    var presenter: EditRequestProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }

    // MARK: - Method
    func initViews() {
        initNavigation()
        nameTextField.text = contact.name
        phoneTextField.text = contact.phone
        editButton.layer.cornerRadius = 5
        editButton.layer.borderWidth = 0.5
        configureViper()
    }
    
    func configureViper() {
        let manager = HttpManager()
        let presenter = EditPresenter()
        let routing = EditRouting()
        let interactor = EditInteractor()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.routing = routing
        presenter.interactor = interactor
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
    }
    
    func initNavigation() {
        title = "Edit Contact"
    }
    
    // MARK: - Action
    @IBAction func editContact(_ sender: Any) {
        contact.name = nameTextField.text
        contact.phone = phoneTextField.text
        presenter.apiContactEdit(contact: contact)
        presenter.closeEditScreen()
    }
    
}
