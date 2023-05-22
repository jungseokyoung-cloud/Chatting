import RxSwift

protocol SignUpUseCaseType {
	func trySignUp(
		userEmail: String,
		password: String
	) async -> Single<Void>
}
