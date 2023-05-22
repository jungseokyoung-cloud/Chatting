import RxSwift

protocol SignInRepositoryType {
	func trySignInUser(
		userEmail: String,
		password: String
	) async -> Single<Void>
}
