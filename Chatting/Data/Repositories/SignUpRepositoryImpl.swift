import RxSwift
import Firebase

final class SignUpRepository: SignUpRepositoryType {
	private let db = Firestore.firestore()
	
	func trySignUp(user: User) async -> Single<Void> {
		let result = try? await Auth.auth().createUser(
			withEmail: user.email,
			password: user.password
		)
		
		return Single.create { [weak self] emitter in
			if result != nil {
				emitter(.success(()))
				self?.storeUserInfoInDatabase(user: user)
			} else {
				emitter(.failure(NetworkError.InvalidSignUp))
			}
			return Disposables.create()
		}
	}
}

extension SignUpRepository {
	private func storeUserInfoInDatabase(user: User) {
		let newDocument = db
			.collection(FireStoreConstant.Users.collectionID)
			.document(user.email)
		
		newDocument.setData([
			FireStoreConstant.Users.emailField: user.email,
			FireStoreConstant.Users.nameField: user.userName,
			FireStoreConstant.Users.passwordField: user.password
		])
	}
}
