import Foundation

public struct FireStoreConstant {
	public struct Users{}
	public struct FriendList {}
}

public extension FireStoreConstant.Users {
	static let collectionID = "Users"
	static let documentID = "UserInfo"
	
	static let emailField = "email"
	static let nameField = "userName"
	static let passwordField = "password"
}

public extension FireStoreConstant.FriendList {
	static let collectionID = "FriendList"
	static let documentID = "Friends"
}
