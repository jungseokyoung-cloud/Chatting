import UIKit
import RxCocoa
import RxSwift

final class SignUpViewController: UIViewController {
	private let viewModel: SignUpViewModelType
	private var disposeBag = DisposeBag()
	
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
	
	private let userNameTextField: CustomTextField = {
		let textField = CustomTextField(placeHolder: "닉네임을 입력하세요.")
		textField.textContentType = .nickname
		
		return textField
	}()
	
	private let passWordStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.spacing = 15
		stackView.alignment = .fill
		stackView.distribution = .fillEqually
		
		return stackView
	}()
	
	private let passWordTextField: CustomTextField = {
		let textField = CustomTextField(placeHolder: "비밀번호")
		textField.textContentType = .password
		textField.isSecureTextEntry = true
		
		return textField
	}()
	
	private let checkPassWordTextField: CustomTextField = {
		let textField = CustomTextField(placeHolder: "비밀번호 확인")
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
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		self.viewModel = SignUpViewModel()
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "회원가입"
		self.view.backgroundColor = UIColor(named: "SignInBackgroundColor")
		setupUI()
		bind()
	}
	
	private func bind() {
		userEmailTextField.rx.text
			.orEmpty
			.bind(to: viewModel.input.userEmail)
			.disposed(by: disposeBag)
		
		userNameTextField.rx.text
			.orEmpty
			.bind(to: viewModel.input.userName)
			.disposed(by: disposeBag)
		
		passWordTextField.rx.text
			.orEmpty
			.bind(to: viewModel.input.password)
			.disposed(by: disposeBag)
		
		checkPassWordTextField.rx.text
			.orEmpty
			.bind(to: viewModel.input.checkPassword)
			.disposed(by: disposeBag)
		
		confirmButton.rx.tap
			.bind(to: viewModel.input.confirmButtonTapped)
			.disposed(by: disposeBag)
		
		viewModel.output.isValidUserEmail
			.drive(
				onNext: { [weak self] result in
					if result {
						self?.userEmailTextField.changeUIWithTextFieldMode(.normal)
					} else {
						self?.userEmailTextField.changeUIWithTextFieldMode(.warning)
					}
				}
			)
			.disposed(by: disposeBag)
		
		viewModel.output.isValidUserName
			.drive(
				onNext: { [weak self] result in
					if result {
						self?.userNameTextField.changeUIWithTextFieldMode(.normal)
					} else {
						self?.userNameTextField.changeUIWithTextFieldMode(.warning)
					}
				}
			)
			.disposed(by: disposeBag)
		
		viewModel.output.isValidPassword
			.drive(
				onNext: { [weak self] result in
					if result {
						self?.passWordTextField.changeUIWithTextFieldMode(.normal)
					} else {
						self?.passWordTextField.changeUIWithTextFieldMode(.warning)
					}
				}
			)
			.disposed(by: disposeBag)
		
		viewModel.output.isValidCheckPassword
			.drive(
				onNext: { [weak self] result in
					if result {
						self?.checkPassWordTextField.changeUIWithTextFieldMode(.normal)
					} else {
						self?.checkPassWordTextField.changeUIWithTextFieldMode(.warning)
					}
				}
			)
			.disposed(by: disposeBag)
		
		viewModel.output.canTapConfirmButton
			.drive(confirmButton.rx.isEnabled)
			.disposed(by: disposeBag)
		
		viewModel.output.canTapConfirmButton
			.map {$0 ? 1.0 : 0.3 }
			.drive(confirmButton.rx.alpha)
			.disposed(by: disposeBag)
		
		viewModel.output.registerInDenied
			.drive(
				onNext: { [weak self] _ in
					self?.createAlertController(
						title: "회원가입에러",
						message: "이미 가입한 이메일입니다.",
						buttonTitle: "확인"
					)
				}
			)
			.disposed(by: disposeBag)
		
		viewModel.output.registerSuccess
			.drive(
				onNext: { [weak self] _ in
					self?.navigationController?.popViewController(animated: true)
				}
			)
			.disposed(by: disposeBag)
	}
	
	private func setupUI() {
		view.addSubview(stackView)
		
		passWordStackView.addArrangedSubview(passWordTextField)
		passWordStackView.addArrangedSubview(checkPassWordTextField)
		
		stackView.addArrangedSubview(userEmailTextField)
		stackView.addArrangedSubview(userNameTextField)
		stackView.addArrangedSubview(passWordStackView)
		stackView.addArrangedSubview(confirmButton)
		
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
			stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
			stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			userEmailTextField.heightAnchor.constraint(equalToConstant: 44),
			userNameTextField.heightAnchor.constraint(equalToConstant: 44),
			passWordStackView.heightAnchor.constraint(equalToConstant: 44),
			confirmButton.heightAnchor.constraint(equalToConstant: 50),
		])
	}
}
