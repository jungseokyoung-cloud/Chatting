import RxSwift

protocol SignUpUseCaseType {
	var dependency: SignUpRepositoryType { get }

	func trySignUp(
		userEmail: String,
		password: String
	) async -> Single<Void>
}
