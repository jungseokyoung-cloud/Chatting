import Foundation

final class UserDefaultStorage {
	private let defaults: UserDefaults
	
	enum UserDefaultKey: String {
		case user = "UserInfo"
	}
	
	init(defaults: UserDefaults = UserDefaults.standard) {
		self.defaults = defaults
	}
	
	func saveUserInfo(user: User) {
		if let encodeData = try? JSONEncoder().encode(user) {
			defaults.set(encodeData, forKey: UserDefaultKey.user.rawValue)
		}
	}
	
	func getUserInfo() -> User? {
		guard let data = defaults.object(forKey: UserDefaultKey.user.rawValue) as? Data else {
			return nil
		}
		print(data)
		
		let decodeData = try? JSONDecoder().decode(User.self, from: data)
		print("decodeData: \(decodeData)")

		return decodeData
	}
	
	func removeUserInfo() {
		defaults.removeObject(forKey: UserDefaultKey.user.rawValue)
	}
}
