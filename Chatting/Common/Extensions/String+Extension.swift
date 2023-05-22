import Foundation

extension String {
	enum StringPattern {
		case email
		
		var getRegex: String {
			switch self {
			case .email:
				return "^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+.[a-zA-Z]{3,20}$"
			}
		}
	}
	func checkValidPattern(_ stringPattern: StringPattern) -> Bool {
		let pattern = stringPattern.getRegex
		if self.range(of: pattern, options: .regularExpression) != nil {
			return true
		} else {
			return false
		}
	}
}
