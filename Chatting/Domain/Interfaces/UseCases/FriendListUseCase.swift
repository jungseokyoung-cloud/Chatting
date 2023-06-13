import Foundation
import RxSwift

protocol FriendListUseCaseType {
	func getFriendList() async -> Single<[User]>
	
	func tryAddFriendWithEmail(_ email: String) async -> Single<Void>
}
