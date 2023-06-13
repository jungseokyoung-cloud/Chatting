import RxSwift
import Firebase

final class SignUpRepository: SignUpRepositoryType {
	private let db = Firestore.firestore()
	private let fireStoreRepository: FireStoreRepositoryType
	
	init(fireStoreRepository: FireStoreRepositoryType = FireStoreRepository()) {
		self.fireStoreRepository = fireStoreRepository
	}
	
	func trySignUp(user: User) async -> Single<Void> {
		let result = try? await Auth.auth().createUser(
			withEmail: user.email,
			password: user.password
		)
		
		return .create { [weak self] emitter in
			if result != nil {
				emitter(.success(()))
				self?.fireStoreRepository.storeUserInfoInDatabase(user: user)
			} else {
				emitter(.failure(NetworkError.InvalidSignUp))
			}
			return Disposables.create()
		}
	}
}
