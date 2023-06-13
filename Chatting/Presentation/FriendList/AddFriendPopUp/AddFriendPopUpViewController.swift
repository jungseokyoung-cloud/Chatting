import UIKit
import RxCocoa
import RxSwift

final class AddFriendPopUpViewController: UIViewController {
	private let viewModel: AddFriendPopUpViewModelType
	private var disposBag = DisposeBag()
	
	private let containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		view.layer.cornerRadius = 10.0
		
		return view
	}()
	
	private let popUpBackgroundView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .black.withAlphaComponent(0.3)
		
		return view
	}()
	
	private let textField: CustomTextField = {
		let textField = CustomTextField(placeHolder: "아이디로 검색")
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.backgroundColor = .systemGray4
		
		return textField
	}()
	
	private let bottomStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.alignment = .fill
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.spacing = 10
		
		return stackView
	}()
	
	private lazy var closeButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("취소", for: .normal)
		button.backgroundColor = UIColor(rgb: 0x5f84a2)
		button.layer.cornerRadius = 10.0
		button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
		
		return button
	}()
	
	private let addButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("친구 추가", for: .normal)
		button.backgroundColor = UIColor(rgb: 0x5f84a2)
		button.layer.cornerRadius = 10.0
		button.alpha = 0.3
		
		return button
	}()
	
	init(viewModelListener: AddFriendPopUpListner) {
		self.viewModel = AddFriendPopUpViewModel(listener: viewModelListener)
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		bind()
		setupUI()
	}
	
	private func bind() {
		textField.rx.text
			.orEmpty
			.bind(to: viewModel.input.friendName)
			.disposed(by: disposBag)
		
		addButton.rx.tap
			.bind(to: viewModel.input.addButtonTapped)
			.disposed(by: disposBag)
		
		viewModel.output.canTapConfirmButton
			.drive(addButton.rx.isEnabled)
			.disposed(by: disposBag)
		
		viewModel.output.canTapConfirmButton
			.map { $0 ? 1.0 : 0.3 }
			.drive(addButton.rx.alpha)
			.disposed(by: disposBag)
	}
	
	private func setupUI() {
		view.addSubview(popUpBackgroundView)
		popUpBackgroundView.addSubview(containerView)
		containerView.addSubview(textField)
		containerView.addSubview(bottomStackView)
		
		bottomStackView.addArrangedSubview(addButton)
		bottomStackView.addArrangedSubview(closeButton)
		
		NSLayoutConstraint.activate([
			popUpBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			popUpBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			popUpBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
			popUpBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

			containerView.centerXAnchor.constraint(equalTo: popUpBackgroundView.centerXAnchor),
			containerView.centerYAnchor.constraint(equalTo: popUpBackgroundView.centerYAnchor),
			containerView.heightAnchor.constraint(equalToConstant: 150),
			containerView.widthAnchor.constraint(equalToConstant: 300),
			
			textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
			textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
			textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
			textField.heightAnchor.constraint(equalToConstant: 44),
			
			bottomStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
			bottomStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
			bottomStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
		])
	}
}

extension AddFriendPopUpViewController {
	@objc func closeButtonTapped() {
		self.dismiss(animated: false)
	}
}
