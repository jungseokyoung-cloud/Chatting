import Foundation
import FirebaseStorage
import Firebase

protocol FireStoreRepositoryType {
	func findUserInDatabaseWithEmail(_ email: String) async -> User?
	func storeUserInfoInDatabase(user: User)
	func findFriendsDataWithEmail(_ email: String) async -> [User]
	func storeFriendsDataToDatabase(_ email: String, users: [User])
}

final class FireStoreRepository: FireStoreRepositoryType {
	private let defaultStorage: UserDefaultStorage
	private let db = Firestore.firestore()
	
	init(defaultStorage: UserDefaultStorage = UserDefaultStorage()) {
		self.defaultStorage = defaultStorage
	}
	
	func findUserInDatabaseWithEmail(_ email: String) async -> User? {
		let query = db
			.collection(FireStoreConstant.Users.collectionID)
			.whereField("email", isEqualTo: email)
		
		let data = try? await query.getDocuments().documents.first?.data() as? [String : String]
		
		if let data = data {
			let user = data.dictionaryToObject(User.self)

			return user
		} else {
			return nil
		}
	}
	
	func storeUserInfoInDatabase(user: User) {
		let newDocument = db
			.collection(FireStoreConstant.Users.collectionID)
			.document(user.email)
		
		if let userDictionary = user.toDictionry() {
			newDocument.setData(userDictionary)
		}
	}

	func findFriendsDataWithEmail(_ email: String) async -> [User] {
		let doc = db
			.collection(FireStoreConstant.FriendList.collectionID)
			.document(email)
				
		let documentData = try? await doc.getDocument()
		
		if
			let data = documentData?[FireStoreConstant.FriendList.documentID],
			let users = (data as? [[String: String]])?.dictionaryToObject([User].self)
		{
			return users
		} else {
			setDataInDocument(
				doc,
				fieldName: FireStoreConstant.FriendList.documentID,
				data: [] as [[String: String]]
			)
			return []
		}
	}
	
	func storeFriendsDataToDatabase(_ email: String, users: [User]) {
		let doc = db
			.collection(FireStoreConstant.FriendList.collectionID)
			.document(email)
			
		if let usersDictionary = users.toDictionryArray() {
			print(usersDictionary)
			doc.setData([FireStoreConstant.FriendList.documentID: usersDictionary])
			updateDataInDocument(
				doc,
				fieldName: FireStoreConstant.FriendList.documentID,
				data: usersDictionary
			)
		}
	}
}

private extension FireStoreRepository {
	func updateDataInDocument(
		_ doc: DocumentReference,
		fieldName: String = "",
		data: Any
	)
	{
		doc.updateData([fieldName: data])
	}
	
	func setDataInDocument(
		_ doc: DocumentReference,
		fieldName: String = "",
		data: Any
	)
	{
		doc.setData([fieldName: data])
	}
}
