import RxSwift

protocol FriendListRepositoryType {
	func fetchUser() async -> Single<[User]>
}
