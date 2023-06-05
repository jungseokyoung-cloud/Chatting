import Foundation
import RxSwift

protocol FriendListUseCaseType {
	func getFriendList() async -> Single<[User]>
	
//	func tryAddFriendWithEmail(userEmail: String) async -> Single<Void>
}
