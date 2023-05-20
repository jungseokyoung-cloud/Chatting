import RxSwift

protocol SignInUseCaseType {
	func trySignInUser(
		userEmail: String,
		password: String
	) async -> Single<Void>
}
