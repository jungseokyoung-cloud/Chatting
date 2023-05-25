import UIKit

final class FriendListViewController: UIViewController {
	
	private let FriendTableView: UITableView = {
		let tableView = UITableView()
		return tableView
	}()
	
	override func viewDidLoad() {
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
