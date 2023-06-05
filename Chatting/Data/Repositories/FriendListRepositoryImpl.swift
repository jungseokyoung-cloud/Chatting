import Foundation
import RxSwift
import FirebaseFirestore
import Firebase

final class FriendListRepository: FriendListRepositoryType {
	private let db = Firestore.firestore()
	private let defaultStorage: UserDefaultStorage
	
	init(defaultStorage: UserDefaultStorage = UserDefaultStorage()) {
		self.defaultStorage = defaultStorage
	}

	func fetchUser() async -> Single<[User]> {
		let path = db.collection(FireStoreConstant.FriendList.collectionID)
		let snapshot = try? await path.getDocuments()
		
		return Single<[User]>.create { [weak self] emitter in
			guard
				let userEmail = self?.defaultStorage.getUserInfo()?.email,
				let doc = snapshot?.documents.filter({ $0.documentID == userEmail }).first,
				let data = doc[FireStoreConstant.FriendList.documentID] as? [String]
			else {
				emitter(.failure(NetworkError.FecthError))
				return Disposables.create()
			}
			
//			let users = data.map({User.init(email: $0)})
			let users = [
				User(email: "1", userName: "1")
			]
			emitter(.success(users))

			return Disposables.create()
		}
	}
	
	// 친구 가져오기 -> 유효성 검사 체크
	
//	func tryAddFriend() async -> Single<Void> {
//		let path = db.collection(FireStoreConstant.Collections.FriendList)
//		let snapshot = try? await path.getDocuments()
//
//		return Single<Void>.create { [weak self] emitter in
//			guard
//				let userEmail = self?.defaultStorage.getUserInfo()?.email,
//				let doc = snapshot?.documents.filter({ $0.documentID == userEmail }).first,
//				let data = doc[FireStoreConstant.Documents.Friends] as? [String]
//			else {
//				emitter(.failure(NetworkError.FecthError))
//				return Disposables.create()
//			}
//
//			let users = data.map({User.init(email: $0)})
//			emitter(.success(()))
//
//			return Disposables.create()
//		}
//	}
}
//
//extension FriendListRepository {
//	private func checkInvalidUser() async {
////		guard let user = Auth.auth().
//	}
//}
