import Foundation

public struct FireStoreConstant {
	public struct Collections {}
	public struct Documents {}
}

public extension FireStoreConstant.Collections {
	static let FriendList = "FriendList"
}

public extension FireStoreConstant.Documents {
	static let Friends = "Friends"
}
