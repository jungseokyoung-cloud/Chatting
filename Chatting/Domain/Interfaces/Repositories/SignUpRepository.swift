import RxSwift

protocol SignUpRepositoryType {
	func trySignUp(user: User) async -> Single<Void>
}
