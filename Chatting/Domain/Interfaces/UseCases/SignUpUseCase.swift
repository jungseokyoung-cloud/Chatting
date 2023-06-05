import RxSwift

protocol SignUpUseCaseType {
	var dependency: SignUpRepositoryType { get }

	func trySignUp(user: User) async -> Single<Void>
}
