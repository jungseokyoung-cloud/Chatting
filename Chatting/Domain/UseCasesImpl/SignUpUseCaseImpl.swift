import RxSwift

final class SignUpUseCaseImpl: SignUpUseCaseType {
	let dependency: SignUpRepositoryType
	
	init(dependency: SignUpRepositoryType = SignUpRepository()) {
		self.dependency = dependency
	}
	
	func trySignUp(user: User) async -> Single<Void> {
		return await dependency.trySignUp(user: user)
	}
}
