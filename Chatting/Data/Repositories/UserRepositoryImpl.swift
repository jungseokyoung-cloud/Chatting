import RxSwift
import Firebase

final class UserRepository: UserRepositoryType {
	func trySignInUser(
		userEmail: String,
		password: String
	) async -> Single<Void> {
		
		let result = try? await Auth.auth().signIn(withEmail: userEmail, password: password)
		
		return Single<Void>.create { emitter in
			if result != nil {
				emitter(.success(()))
			} else {
				emitter(.failure(NetworkError.InValidSignIn))
			}
			return Disposables.create()
		}
	}
}
