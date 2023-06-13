import Foundation
import RxSwift
import FirebaseFirestore
import Firebase

final class FriendListRepository: FriendListRepositoryType {
	private let db = Firestore.firestore()
	private let defaultStorage: UserDefaultStorage
	private let fireStoreRepository: FireStoreRepositoryType
	
	init(
		defaultStorage: UserDefaultStorage = UserDefaultStorage(),
		fireStoreRepository: FireStoreRepositoryType = FireStoreRepository()
	) {
		self.defaultStorage = defaultStorage
		self.fireStoreRepository = fireStoreRepository
	}
	
	func fetchUser() async -> Single<[User]> {
		guard
			let email = defaultStorage.getUserInfo()?.email,
			let _ = await fireStoreRepository.findUserInDatabaseWithEmail(email)
		else {
			return .create { emitter in
				emitter(.failure(NetworkError.ServerError))
				return Disposables.create()
			}
		}
		
		let users = await fireStoreRepository.findFriendsDataWithEmail(email)
		
		return .create { emitter in
			emitter(.success(users))
			return Disposables.create()
		}
	}
	
	// 중복 체크!
	// 있는 사람인지!
	func addFriendWithEmail(_ email: String) async -> Single<Void> {
		guard
			let userEmail = defaultStorage.getUserInfo()?.email,
			let user = await fireStoreRepository.findUserInDatabaseWithEmail(userEmail)
		else
		{
			return .create { emitter in
				emitter(.failure(NetworkError.ServerError))
				return Disposables.create()
			}
		}

		var users = await fireStoreRepository.findFriendsDataWithEmail(userEmail)
		let addUser = await fireStoreRepository.findUserInDatabaseWithEmail(email)
		
		return .create { [weak self] emitter in
			guard let addUser = addUser else {
				emitter(.failure(NetworkError.NotExistUser))
				return Disposables.create()
			}
			
			if addUser.email == user.email {
				emitter(.failure(NetworkError.InvalidAccess))
			} else if users.filter({ $0.email == addUser.email }).count != 0 {
				emitter(.failure(NetworkError.AlreadyExist))
			} else {
				users.append(addUser)
				self?.fireStoreRepository.storeFriendsDataToDatabase(userEmail, users: users)
				emitter(.success(()))
			}
			return Disposables.create()
		}
	}
	
	func updateDataInDocument(
		_ doc: DocumentReference,
		fieldName: String = "",
		data: Any
	)
	{
		doc.updateData([fieldName: data])
	}
}
