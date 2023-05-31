import RxSwift

protocol SignInRepositoryType {
	func trySignInUser(
		userEmail: String,
		password: String
	) async -> Single<User>
	
	init(defaultStorage: UserDefaultStorage)
}
