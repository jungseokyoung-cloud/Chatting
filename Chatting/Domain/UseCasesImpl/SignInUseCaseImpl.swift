import RxSwift

final class SignInUseCase: SignInUseCaseType {
	private let repository: UserRepositoryType
	
	init(repository: UserRepositoryType = UserRepository()) {
		self.repository = repository
	}
	
	func trySignInUser(
		userEmail: String,
		password: String
	) async -> Single<Void> {
		return await repository.trySignInUser(
			userEmail: userEmail,
			password: password
		)
	}
	
}
