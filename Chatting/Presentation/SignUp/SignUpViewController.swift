import UIKit
import RxCocoa
import RxSwift

final class SignUpViewController: UIViewController {
	private let viewMoel: SignUpViewModelType
	private var disposBag = DisposeBag()
	
	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 20
		stackView.alignment = .fill
		stackView.distribution = .fillProportionally
		
		return stackView
	}()

	private let userEmailTextField: CustomTextField = {
		let textField = CustomTextField(placeHolder: "이메일을 입력하세요.")
		textField.textContentType = .nickname
		
		return textField
	}()
	
	private let passWordTextField: CustomTextField = {
		let textField = CustomTextField(placeHolder: "비밀번호를 입력하세요.")
		textField.textContentType = .password
		textField.isSecureTextEntry = true
		
		return textField
	}()
	
	private let confirmButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("회원가입", for: .normal)
		button.backgroundColor = UIColor(rgb: 0x5f84a2)
		button.isEnabled = false
		button.alpha = 0.3
		button.layer.cornerRadius = 10.0
		
		return button
	}()
	
	
	init(viewModel: SignUpViewModelType = SignUpViewModel()) {
		self.viewMoel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		self.viewMoel = SignUpViewModel()
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor(named: "SignInBackgroundColor")
		setupUI()
		bind()
	}
	
	private func bind() {
		
	}
	
	private func setupUI() {
		view.addSubview(stackView)
		
		stackView.addArrangedSubview(userEmailTextField)
		stackView.addArrangedSubview(passWordTextField)
		stackView.addArrangedSubview(confirmButton)
		
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
			stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
			stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			userEmailTextField.heightAnchor.constraint(equalToConstant: 44),
			passWordTextField.heightAnchor.constraint(equalToConstant: 44),
			confirmButton.heightAnchor.constraint(equalToConstant: 50),
		])
	}
}
