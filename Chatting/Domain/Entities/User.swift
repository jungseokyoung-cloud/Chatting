import Foundation

struct User: Codable {
	let email: String
	let userName: String
	let password: String
}

extension User {
	init(email: String, userName: String) {
		self.email = email
		self.userName = userName
		self.password = ""
	}
}
