import UIKit

class SignInViewController: UIViewController {
	
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
		button.layer.cornerRadius = 10.0
		button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
		
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
		button.addTarget(self, action: #selector(findIDButtonTapped), for: .touchUpInside)

		return button
	}()
	
	private lazy var findPasswordButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("비밀번호 찾기", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 15)
		button.addTarget(self, action: #selector(findPasswordButtonTapped), for: .touchUpInside)

		return button
	}()
	
	private lazy var registerButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("회원가입", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 15)
		button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)

		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = UIColor(named: "SignInBackgroundColor")
		setupUI()
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

extension SignInViewController {
	@objc func confirmButtonTapped() {
		print("confirm")
	}
	
	@objc func findIDButtonTapped() {
		print("findID")
	}
	
	@objc func findPasswordButtonTapped() {
		print("findPassWord")
	}
		
	@objc func registerButtonTapped() {
		print("registerButton")
	}
}
