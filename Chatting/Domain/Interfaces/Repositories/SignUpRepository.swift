import RxSwift

protocol SignUpRepositoryType {
	func trySignUp(
		userEmail: String,
		password: String
	) async -> Single<Void>
}
