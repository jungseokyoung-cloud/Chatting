import RxSwift
import Firebase

final class SignUpRepository: SignUpRepositoryType {
	func trySignUp(
		userEmail: String,
		password: String
	) async -> Single<Void> {
		let result = try? await Auth.auth().createUser(
			withEmail: userEmail,
			password: password
		)
		
		return Single.create { emitter in
			if result != nil {
				emitter(.success(()))
			} else {
				emitter(.failure(NetworkError.InvalidSignUp))
			}
			return Disposables.create()
		}
	}
}
