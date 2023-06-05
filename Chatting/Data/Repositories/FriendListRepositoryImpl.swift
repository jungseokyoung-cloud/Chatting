import Foundation
import RxSwift
import FirebaseFirestore

final class FriendListRepository: FriendListRepositoryType {
	private let db = Firestore.firestore()
	private let defaultStorage: UserDefaultStorage
	
	init(defaultStorage: UserDefaultStorage = UserDefaultStorage()) {
		self.defaultStorage = defaultStorage
	}

	func fetchUser() async -> Single<[User]> {
		let path = db.collection(FireStoreConstant.Collections.FriendList)
		let snapshot = try? await path.getDocuments()
		
		return Single<[User]>.create { [weak self] emitter in
			guard
				let userEmail = self?.defaultStorage.getUserInfo()?.email,
				let doc = snapshot?.documents.filter({ $0.documentID == userEmail }).first,
				let data = doc[FireStoreConstant.Documents.Friends] as? [String]
			else {
				emitter(.failure(NetworkError.FecthError))
				return Disposables.create()
			}
			
			let users = data.map({User.init(email: $0)})
			emitter(.success(users))

			return Disposables.create()
		}
	}	
}
