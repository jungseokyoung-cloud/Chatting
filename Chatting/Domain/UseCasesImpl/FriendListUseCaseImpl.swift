import Foundation
import RxSwift

final class FriendListUseCase: FriendListUseCaseType {
	let dependency: FriendListRepositoryType
	
	init(dependency: FriendListRepositoryType = FriendListRepository()) {
		self.dependency = dependency
	}
	
	func getFriendList() async -> Single<[User]> {
		return await dependency.fetchUser()
	}
	//	func tryAddFriendWithEmail(userEmail: String) async -> Single<Void> {
	//
	//	}
	//	func addFriend(userEmail: String, addEmail: String) async {
	//		let result = try? await db
	//			.collection("FriendList")
	//			.document(userEmail)
	//			.setData([
	//
	//			])
	//	}
}
