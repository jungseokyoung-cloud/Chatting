import UIKit
import RxSwift
import RxCocoa

final class FriendListViewController: UIViewController {
	private let viewModel: FriendListViewModelType
	private var disposBag = DisposeBag()
	
	private let FriendTableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FriendListCell")
		return tableView
	}()
	
	private lazy var logOutButton: UIBarButtonItem = {
		let button = UIBarButtonItem(
			title: "logOut",
			style: .plain,
			target: self,
			action: #selector(logOutButtonTapped)
		)
		
		return button
	}()
	
	private lazy var addFriendButton: UIBarButtonItem = {
		let button = UIBarButtonItem(
			title: "친구 추가",
			style: .plain,
			target: self,
			action: #selector(addFriendButtonTapped)
		)
		
		return button
	}()
	
	init(viewModel: FriendListViewModelType = FriendListViewModel()) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		self.viewModel = FriendListViewModel()
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		self.view.backgroundColor = UIColor(named: "SignInBackgroundColor")
		self.FriendTableView.backgroundColor = .clear
		self.title = "친구 목록"
		self.navigationItem.hidesBackButton = true
		self.navigationItem.rightBarButtonItem = addFriendButton
		self.navigationItem.leftBarButtonItem = logOutButton
		
		super.viewDidLoad()
		setupUI()
		bind()
	}
	
	private func bind() {
		self.rx.viewWillAppear
			.subscribe(onNext: { [weak self] _ in
				self?.viewModel.input.viewWillAppear()
			})
			.disposed(by: disposBag)
		
		viewModel.output.friendList
			.drive(FriendTableView.rx.items(cellIdentifier: "FriendListCell")) { index, item, cell in
				var content = cell.defaultContentConfiguration()
				content.text = item.email
				cell.contentConfiguration = content
				cell.backgroundColor = .clear
			}
			.disposed(by: disposBag)
		
		viewModel.output.fetchFriendListError
			.drive(
				onNext: { [weak self] _ in
					self?.navigationController?.popToRootViewController(animated: true)
				}
			)
			.disposed(by: disposBag)
	}
	
	private func setupUI() {
		view.addSubview(FriendTableView)
		NSLayoutConstraint.activate([
			FriendTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			FriendTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			FriendTableView.topAnchor.constraint(equalTo: view.topAnchor),
			FriendTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
		vc.modalPresentationStyle = .overFullScreen
		present(vc, animated: false)
	}
}
