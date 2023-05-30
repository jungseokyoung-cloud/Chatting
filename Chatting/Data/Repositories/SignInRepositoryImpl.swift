import RxSwift
import Firebase

final class SignInRepository: SignInRepositoryType {
	func trySignInUser(
		userEmail: String,
		password: String
	) async -> Single<User> {
		
		let result = try? await Auth.auth().signIn(withEmail: userEmail, password: password)
		
		return Single<User>.create { emitter in
			if result != nil {
				emitter(.success(User(email: userEmail, password: password)))
			} else {
				emitter(.failure(NetworkError.InValidSignIn))
			}
			return Disposables.create()
		}
	}
}
