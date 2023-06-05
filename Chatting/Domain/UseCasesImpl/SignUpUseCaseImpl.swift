import RxSwift

final class SignUpUseCaseImpl: SignUpUseCaseType {
	let dependency: SignUpRepositoryType
	
	init(dependency: SignUpRepositoryType = SignUpRepository()) {
		self.dependency = dependency
	}
	
	func trySignUp(
		userEmail: String,
		password: String
	) async -> Single<Void> {
		return await dependency.trySignUp(
			userEmail: userEmail,
			password: password
		)
	}
}
