import RxSwift
import Firebase
import FirebaseFirestore

final class SignInRepository: SignInRepositoryType {
	private let defaultStorage: UserDefaultStorage
	private let db = Firestore.firestore()
	
	init(defaultStorage: UserDefaultStorage = UserDefaultStorage()) {
		self.defaultStorage = defaultStorage
	}
	
	func trySignInUser(
		userEmail: String,
		password: String
	) async -> Single<User> {
		let result = try? await Auth.auth().signIn(withEmail: userEmail, password: password)
		let user = await findUserInDatabaseWithEmail(userEmail)
		return Single<User>.create { [weak self] emitter in
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

extension SignInRepository {
	private func findUserInDatabaseWithEmail(_ email: String) async -> User? {
		let query = db
			.collection(FireStoreConstant.Users.collectionID)
			.whereField("email", isEqualTo: email)
		
		let data = try? await query.getDocuments().documents.first?.data() as? [String : String]
		
		if
			let data = data,
			let userEmail = data[FireStoreConstant.Users.emailField],
			let userName = data[FireStoreConstant.Users.nameField],
			let password = data[FireStoreConstant.Users.passwordField]
		{
			let user = User(
				email: userEmail,
				userName: userName,
				password: password
			)
			return user
		} else {
			return nil
		}
	}
}
