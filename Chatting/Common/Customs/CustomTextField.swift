import UIKit

class CustomTextField: UITextField {
	init(placeHolder: String ,frame: CGRect = .zero) {
		super.init(frame: frame)
		self.placeholder = "  \(placeHolder)"
		self.addLeftPadding()
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = .white
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
}
