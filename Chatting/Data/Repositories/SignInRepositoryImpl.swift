import RxSwift
import Firebase

final class SignInRepository: SignInRepositoryType {
	private let defaultStorage: UserDefaultStorage
	
	init(defaultStorage: UserDefaultStorage = UserDefaultStorage()) {
		self.defaultStorage = defaultStorage
	}
	
	func trySignInUser(
		userEmail: String,
		password: String
	) async -> Single<User> {
		let result = try? await Auth.auth().signIn(withEmail: userEmail, password: password)
		
		return Single<User>.create { [weak self] emitter in
			if result != nil {
				let user = User(email: userEmail, password: password)
				emitter(.success(user))
				self?.defaultStorage.saveUserInfo(user: user)
			} else {
				emitter(.failure(NetworkError.InValidSignIn))
			}
			return Disposables.create()
		}
	}
}
