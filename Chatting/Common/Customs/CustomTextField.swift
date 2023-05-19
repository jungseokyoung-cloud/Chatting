import UIKit

enum TextFieldMode {
	case warning
	case normal
}

class CustomTextField: UITextField {
	init(placeHolder: String ,frame: CGRect = .zero) {
		super.init(frame: frame)
		self.placeholder = "  \(placeHolder)"
		self.addLeftPadding()
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = .white
		self.layer.borderWidth = 0.7
		self.layer.borderColor = UIColor.white.cgColor
		self.layer.cornerRadius = 10.0
	}
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}

extension CustomTextField {
	func addLeftPadding() {
		let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
		self.leftView = paddingView
		self.leftViewMode = ViewMode.always
	}
	
	func changeUIWithTextFieldMode(_ textMode: TextFieldMode) {
		if(textMode == .normal) {
			self.layer.borderColor = UIColor.white.cgColor
		} else {
			self.layer.borderColor = UIColor.red.cgColor
		}
	}
}
