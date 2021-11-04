
import UIKit

protocol ContactRequestProtocol {
    func apiContactList()
    func apiContactDelete(contact: Contact)
    
    func navigateCreateScreen()
    func navigateEditScreen(contact: Contact)
}

protocol ContactResponseProtocol {
    func onLoadContact(contacts: [Contact])
    func onDeleteContact(isDeleted: Bool)
}

class ContactViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, ContactResponseProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: Array<Contact> = Array()
    var isReloadData = false
    var presenter: ContactRequestProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.apiContactList()
    }
    
    // MARK: - Method
    func onLoadContact(contacts: [Contact]) {
        hideProgress()
        refreshableTableView(contacts: contacts)
    }
    
    func onDeleteContact(isDeleted: Bool) {
        hideProgress()
        presenter.apiContactList()
    }

    func initViews() {
        tableView.delegate = self
        tableView.dataSource = self
        
        initNavigation()
        
        configureViper()
    }
    
    func configureViper() {
        let manager = HttpManager()
        let presenter = ContactPresenter()
        let routing = ContactRouting()
        let interactor = ContactInteractor()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.routing = routing
        presenter.interactor = interactor
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
    }
    
    func initNavigation() {
        let refresh = UIImage(named: "ic_refresh")
        let add = UIImage(named: "ic_add")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Storyboard Contacts"
    }
    
    func refreshableTableView(contacts: [Contact]) {
        self.items = contacts
        self.tableView.reloadData()
    }
    
    func callCreateViewController() {
        let viewController = CreateViewController(nibName: "CreateViewController", bundle: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func callEditViewConroller(contact: Contact) {
        let viewController = EditViewController(nibName: "EditViewController", bundle: nil)
        viewController.contact = contact
        let navigationController = UINavigationController(rootViewController: viewController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Action
    
    @objc func leftTapped() {
        presenter.apiContactList()
    }
    
    @objc func rightTapped() {
        presenter.navigateCreateScreen()
    }
    
    

    // MARK: - Table View
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position >= 0 {
            isReloadData = false
        }
        if position < -120 && !isReloadData {
            hud.position = .topCenter
            isReloadData = true
            presenter.apiContactList()
            tableView.reloadData()
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("ContactTableViewCell", owner: self, options: nil)?.first as! ContactTableViewCell
        
        cell.nameLabel.text = item.name
        cell.phoneLabel.text = item.phone
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeCompleteContextualActions(forRowAt: indexPath, contact: items[indexPath.row])])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeDeleteContextualActions(forRowAt: indexPath, contact: items[indexPath.row])])
    }
    
    // MARK: - Contextual Actions
    private func makeCompleteContextualActions(forRowAt indexPath: IndexPath, contact: Contact) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Edit") { [self] (action, swipeButtonView, completion) in
            print("COMPLETE HERE")
            presenter.navigateEditScreen(contact: contact)
        }
    }
    
    private func makeDeleteContextualActions(forRowAt indexPath: IndexPath, contact: Contact) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { [self] (action, swipeButtonView, completion) in
            print("DELETE HERE")
            completion(true)
            presenter.apiContactDelete(contact: contact)
        }
    }

}
