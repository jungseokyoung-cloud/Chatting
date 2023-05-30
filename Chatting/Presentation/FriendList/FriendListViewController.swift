import UIKit

final class FriendListViewController: UIViewController {
	
	private let FriendTableView: UITableView = {
		let tableView = UITableView()
		return tableView
	}()
	
//	private lazy var logOutButton: UIBarButtonItem = {
//		let button = UIBarButtonItem(
//			title: "logOut",
//			style: .plain,
//			target: self,
//			action: #selector(logOutButtonTapped)
//		)
//		self.navigationItem.rightBarButtonItem = button
//		return button
//	}()
	
	override func viewDidLoad() {
		self.navigationItem.hidesBackButton = true
		let button = UIBarButtonItem(
			title: "logOut",
			style: .plain,
			target: self,
			action: #selector(logOutButtonTapped)
		)
		self.navigationItem.rightBarButtonItem = button
		
		super.viewDidLoad()
		self.title = "친구 목록"
		self.view.backgroundColor = .white
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
//		let vc = SignInViewController()
//		vc.modalPresentationStyle = .fullScreen
//
		self.navigationController?.popViewController(animated: true)
//		present(vc, animated: true)
//		self.dismiss(animated: true)
	}
}
