import UIKit
import RxCocoa
import RxSwift

final class SignInViewController: UIViewController {
	private var disposBag = DisposeBag()
	private var viewModel: SignInViewModelType
	
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
		button.setTitle("로그인", for: .normal)
		button.backgroundColor = UIColor(rgb: 0x5f84a2)
		button.isEnabled = false
		button.alpha = 0.3
		button.layer.cornerRadius = 10.0
		
		return button
	}()
	
	private let buttomStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.spacing = 10
		stackView.alignment = .fill
		stackView.distribution = .fillEqually
		
		return stackView
	}()
	
	private let findPasswordButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("비밀번호 찾기", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 15)
		
		return button
	}()
	
	private let registerButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("회원가입", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 15)
		
		return button
	}()
	
	init(viewModel: SignInViewModelType = SignInViewModel()) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		self.viewModel = SignInViewModel()
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor(named: "SignInBackgroundColor")
		bind()
		setupUI()
	}
	
	private func bind() {
		userEmailTextField.rx.text
			.orEmpty
			.bind(to: viewModel.input.userEmail)
			.disposed(by: disposBag)
		
		passWordTextField.rx.text
			.orEmpty
			.bind(to: viewModel.input.password)
			.disposed(by: disposBag)
		
		confirmButton.rx.tap
			.bind(to: viewModel.input.confirmButtonTapped)
			.disposed(by: disposBag)
		
		viewModel.output.isValidUserEmail
			.drive(
				onNext: { [weak self] result in
					guard let strongSelf = self else { return }
					if(result) {
						strongSelf.userEmailTextField.changeUIWithTextFieldMode(.normal)
					} else {
						strongSelf.userEmailTextField.changeUIWithTextFieldMode(.warning)
					}
				}
			)
			.disposed(by: disposBag)
		
		viewModel.output.isValidPassword
			.drive(
				onNext: { [weak self] result in
					guard let strongSelf = self else { return }
					if(result) {
						strongSelf.passWordTextField.changeUIWithTextFieldMode(.normal)
					} else {
						strongSelf.passWordTextField.changeUIWithTextFieldMode(.warning)
					}
				}
			)
			.disposed(by: disposBag)
		
		viewModel.output.canTapConfirmButton
			.drive(confirmButton.rx.isEnabled)
			.disposed(by: disposBag)
		
		viewModel.output.canTapConfirmButton
			.map {$0 ? 1 : 0.3}
			.drive(confirmButton.rx.alpha)
			.disposed(by: disposBag)
		
		viewModel.output.signInDenied
			.drive(
				onNext: { [weak self] _ in
					self?.createAlertController(
						title: "로그인 에러",
						message: "유저 아이디 혹은 비밀번호가 잘못 입력되었습니다.",
						buttonTitle: "확인")
				}
			)
			.disposed(by: disposBag)
		
		viewModel.output.signInSuccess
			.drive(
				onNext: { [weak self] _ in
					let vc = FriendListViewController()
					vc.modalPresentationStyle = .fullScreen
					self?.present(vc, animated: true)
				}
			)
			.disposed(by: disposBag)
		
		registerButton.rx.tap
			.subscribe(
				onNext: { [weak self] _ in
					let vc = SignUpViewController()
					self?.navigationController?.pushViewController(vc, animated: true)
				}
			)
			.disposed(by: disposBag)
	}
	
	private func setupUI() {
		self.navigationItem.title = "로그인"
		self.view.addSubview(stackView)
		self.view.addSubview(buttomStackView)
		
		stackView.addArrangedSubview(userEmailTextField)
		stackView.addArrangedSubview(passWordTextField)
		stackView.addArrangedSubview(confirmButton)
		
		buttomStackView.addArrangedSubview(findPasswordButton)
		buttomStackView.addArrangedSubview(registerButton)
		
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
			stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
			stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			userEmailTextField.heightAnchor.constraint(equalToConstant: 44),
			passWordTextField.heightAnchor.constraint(equalToConstant: 44),
			confirmButton.heightAnchor.constraint(equalToConstant: 50),
			
			buttomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
			buttomStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
		])
	}
}
