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
	
	private let userNameTextField: UITextField = {
		let textField = CustomTextField(placeHolder: "아이디를 입력하세요.")
		textField.textContentType = .nickname
		
		return textField
	}()
	
	private let passWordTextField: UITextField = {
		let textField = CustomTextField(placeHolder: "비밀번호를 입력하세요.")
		textField.textContentType = .password
		textField.isSecureTextEntry = true
		
		return textField
	}()
	
	private lazy var confirmButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("로그인", for: .normal)
		button.backgroundColor = UIColor(rgb: 0x5f84a2)
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
	
	private lazy var findIDButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("아이디 찾기", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 15)

		return button
	}()
	
	private lazy var findPasswordButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("비밀번호 찾기", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 15)

		return button
	}()
	
	private lazy var registerButton = {
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
		userNameTextField.rx.text
			.orEmpty
			.bind(to: viewModel.input.userName)
			.disposed(by: disposBag)
		
		passWordTextField.rx.text
			.orEmpty
			.bind(to: viewModel.input.password)
			.disposed(by: disposBag)
		
		viewModel.output.isValid
			.drive(confirmButton.rx.isEnabled)
			.disposed(by: disposBag)
		
		viewModel.output.isValid
			.map {$0 ? 1 : 0.3}
			.drive(confirmButton.rx.alpha)
			.disposed(by: disposBag)
		
		confirmButton.rx.tap
			.bind(to: viewModel.input.confirmButtonTapped)
			.disposed(by: disposBag)
	}
	
	private func setupUI() {
		self.navigationItem.title = "로그인"
		self.view.addSubview(stackView)
		self.view.addSubview(buttomStackView)
		
		stackView.addArrangedSubview(userNameTextField)
		stackView.addArrangedSubview(passWordTextField)
		stackView.addArrangedSubview(confirmButton)
		
		buttomStackView.addArrangedSubview(findIDButton)
		buttomStackView.addArrangedSubview(findPasswordButton)
		buttomStackView.addArrangedSubview(registerButton)
		
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
			stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
			stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			userNameTextField.heightAnchor.constraint(equalToConstant: 44),
			passWordTextField.heightAnchor.constraint(equalToConstant: 44),
			confirmButton.heightAnchor.constraint(equalToConstant: 50),
			
			buttomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
			buttomStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
		])
	}
}
