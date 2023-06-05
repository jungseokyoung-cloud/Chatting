import Foundation

struct User: Codable {
	let email: String
	let password: String?
}

extension User {
	init(email: String) {
		self.email = email
		self.password = nil
	}
}
