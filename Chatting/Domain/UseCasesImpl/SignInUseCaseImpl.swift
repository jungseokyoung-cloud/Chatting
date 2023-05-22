import RxSwift

final class SignInUseCase: SignInUseCaseType {
	private let dependency: SignInRepositoryType
	
	init(dependency: SignInRepositoryType = SignInRepository()) {
		self.dependency = dependency
	}
	
	func trySignInUser(
		userEmail: String,
		password: String
	) async -> Single<Void> {
		return await dependency.trySignInUser(
			userEmail: userEmail,
			password: password
		)
	}
	
}
