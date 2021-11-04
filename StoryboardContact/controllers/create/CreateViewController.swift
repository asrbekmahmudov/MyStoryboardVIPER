
import UIKit

protocol CreateRequestProtocol {
    func apiContactCreate(contact: Contact)
    
    func closeCreateScreen()
}

protocol CreateResponseProtocol {
    func onContactCreate(isCreated: Bool)
}

class CreateViewController: BaseViewController, CreateResponseProtocol {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    private var contact = Contact()
    var presenter: CreateRequestProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    // MARK: - Method
    
    func onContactCreate(isCreated: Bool) {
        hideProgress()
    }
    
    func initViews() {
        addButton.layer.cornerRadius = 5
        addButton.layer.borderWidth = 0.5
        configureViper()
    }
    
    func configureViper() {
        let manager = HttpManager()
        let presenter = CreatePresenter()
        let routing = CreateRouting()
        let interactor = CreateInteractor()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.routing = routing
        presenter.interactor = interactor
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
    }
    
    // MARK: - Action
    
    @IBAction func addContact(_ sender: UIButton) {
        self.contact.name = nameTextField.text
        self.contact.phone = phoneTextField.text
        presenter.apiContactCreate(contact: contact)
        presenter.closeCreateScreen()
    }
    
}
