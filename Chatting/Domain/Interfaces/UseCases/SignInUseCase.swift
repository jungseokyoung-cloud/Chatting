import RxSwift

protocol SignInUseCaseType {
	var dependency: SignInRepositoryType { get }
	
	func trySignInUser(
		userEmail: String,
		password: String
	) async -> Single<User>
}
