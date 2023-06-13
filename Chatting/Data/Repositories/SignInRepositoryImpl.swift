import RxSwift
import Firebase
import FirebaseFirestore

final class SignInRepository: SignInRepositoryType {
	private let defaultStorage: UserDefaultStorage
	private let db = Firestore.firestore()
	private let fireStoreRepository: FireStoreRepositoryType
	
	init(
		defaultStorage: UserDefaultStorage = UserDefaultStorage(),
		fireStoreRepository: FireStoreRepositoryType = FireStoreRepository()
	) {
		self.defaultStorage = defaultStorage
		self.fireStoreRepository = fireStoreRepository
	}
	
	func trySignInUser(
		userEmail: String,
		password: String
	) async -> Single<User> {
		let result = try? await Auth.auth().signIn(withEmail: userEmail, password: password)
		let user = await fireStoreRepository.findUserInDatabaseWithEmail(userEmail)
		
		return .create { [weak self] emitter in
			if let user = user, result != nil {
				emitter(.success(user))
				self?.defaultStorage.saveUserInfo(user: user)
			} else {
				emitter(.failure(NetworkError.InValidSignIn))
			}
			return Disposables.create()
		}
	}
}
