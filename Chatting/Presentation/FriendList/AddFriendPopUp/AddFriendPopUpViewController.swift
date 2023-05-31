import UIKit

final class AddFriendPopUpViewController: UIViewController {
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
	
	private lazy var addButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("친구 추가", for: .normal)
		button.backgroundColor = UIColor(rgb: 0x5f84a2)
		button.layer.cornerRadius = 10.0
		button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)

		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
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
		self.dismiss(animated: true)
	}
	
	@objc func addButtonTapped() {
		guard let text = textField.text else { return }
	}
}
