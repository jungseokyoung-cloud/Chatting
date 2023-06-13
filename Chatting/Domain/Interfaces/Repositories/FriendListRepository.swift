import RxSwift

protocol FriendListRepositoryType {
	func fetchUser() async -> Single<[User]>
	func addFriendWithEmail(_ email: String) async -> Single<Void>
	
	init(
		defaultStorage: UserDefaultStorage,
		fireStoreRepository: FireStoreRepositoryType
	)
}
