import UIKit

extension UIViewController {
	func createAlertController(
		title: String,
		message: String,
		buttonTitle: String
	) {
		let alertVC = UIAlertController(
			title: title,
			message: message,
			preferredStyle: .alert
		)
		
		let button = UIAlertAction(title: buttonTitle, style: .default)
		
		alertVC.addAction(button)
		
		present(alertVC, animated: true)
	}
}
