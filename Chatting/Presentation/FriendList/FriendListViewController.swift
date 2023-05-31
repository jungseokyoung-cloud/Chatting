import UIKit

final class FriendListViewController: UIViewController {
	
	private let FriendTableView: UITableView = {
		let tableView = UITableView()
		return tableView
	}()
	
	override func viewDidLoad() {
		self.navigationItem.hidesBackButton = true
		
		let button = UIBarButtonItem(
			title: "logOut",
			style: .plain,
			target: self,
			action: #selector(logOutButtonTapped)
		)
		
		let button2 = UIBarButtonItem(
			title: "친구 추가",
			style: .plain,
			target: self,
			action: #selector(addFriendButtonTapped)
		)
		self.navigationItem.rightBarButtonItem = button
		self.navigationItem.leftBarButtonItem = button2

		
		super.viewDidLoad()
		self.title = "친구 목록"
		self.view.backgroundColor = UIColor(named: "SignInBackgroundColor")
		bind()
		setupUI()
	}
	
	private func bind() {
	}
	
	private func setupUI() {
		view.addSubview(FriendTableView)
		
		NSLayoutConstraint.activate([
			FriendTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			FriendTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			FriendTableView.topAnchor.constraint(equalTo: view.topAnchor),
			FriendTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
	}
}

extension FriendListViewController {
	
	@objc func logOutButtonTapped() {
		UserDefaultStorage().removeUserInfo()
		self.navigationController?.popViewController(animated: true)
	}
	
	@objc func addFriendButtonTapped() {

		let vc = AddFriendPopUpViewController()
		self.view.alpha = 50.0
		vc.modalPresentationStyle = .overFullScreen
		present(vc, animated: true)
		
	}
}
