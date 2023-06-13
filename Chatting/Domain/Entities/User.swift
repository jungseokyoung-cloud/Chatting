import Foundation

struct User: Codable {
	let email: String
	let name: String
	let password: String
}

extension User {
	init(email: String, name: String) {
		self.email = email
		self.name = name
		self.password = ""
	}
}

extension User: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.email == rhs.email
	}	
}
