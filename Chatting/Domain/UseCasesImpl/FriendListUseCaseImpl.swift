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
	
	func tryAddFriendWithEmail(_ email: String) async -> Single<Void> {
		return await dependency.addFriendWithEmail(email)
	}


}
