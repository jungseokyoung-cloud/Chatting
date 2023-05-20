import RxSwift

protocol UserRepositoryType {
	func trySignInUser(
		userEmail: String,
		password: String
	) async -> Single<Void>
}
