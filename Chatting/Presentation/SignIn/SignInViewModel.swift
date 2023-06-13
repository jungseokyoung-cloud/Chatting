import Foundation
import RxSwift
import RxCocoa
import RxRelay

protocol SignInViewModelInput {
	var userEmail: BehaviorRelay<String> { get }
	var password: BehaviorRelay<String> { get }
	var confirmButtonTapped: PublishRelay<Void> { get set }
	var findIdButtonTapped: PublishRelay<Void> { get set }
	var findPasswordButtonTapped: PublishRelay<Void> { get set }
}

protocol SignInViewModelOutput {
	var isValidUserEmail: Driver<Bool> { get set }
	var isValidPassword: Driver<Bool> { get set }
	var canTapConfirmButton: Driver<Bool> { get set }
	var signInDenied: Driver<Void> { get }
	var signInSuccess: Driver<User> { get }
}

protocol SignInViewModelType {
	var disposeBag: DisposeBag { get set }
	var dependency: SignInUseCaseType { get }
	
	var input: SignInViewModelInput { get }
	var output: SignInViewModelOutput { get }
	
	init(dependency: SignInUseCaseType)
}

final class SignInViewModel: SignInViewModelType,
														 SignInViewModelInput,
														 SignInViewModelOutput
{

	
	var dependency: SignInUseCaseType
	var disposeBag = DisposeBag()
	
	var input: SignInViewModelInput { return self }
	var output: SignInViewModelOutput { return self}
	
	var userEmail = BehaviorRelay<String>(value: "")
	var password = BehaviorRelay<String>(value: "")
	var confirmButtonTapped = PublishRelay<Void>()
	var findIdButtonTapped = PublishRelay<Void>()
	var findPasswordButtonTapped = PublishRelay<Void>()
	
	var isValidUserEmail: Driver<Bool>
	var isValidPassword: Driver<Bool>
	var canTapConfirmButton: Driver<Bool>
	var signInDenied: Driver<Void>
	var signInSuccess: Driver<User>

	private let signInDenied$ = PublishSubject<Void>()
	private let signInSuccess$ = PublishSubject<User>()

	init(dependency: SignInUseCaseType = SignInUseCase()) {
		self.dependency = dependency
				
		let isValidUserEmail$ = userEmail
			.skip(1)
			.map { email in
				if (email.checkValidPattern(.email)) {
					return true
				} else {
					return false
				}
			}
		
		let isValidPassword$ = password
			.skip(1)
			.map { password in
				if (password.count >= 6) {
					return true
				} else {
					return false
				}
			}
		
		let isValid$ = Observable<Bool>
			.combineLatest(isValidUserEmail$, isValidPassword$) { (userEmailValidInfo, passwordValidInfo) in
				if(userEmailValidInfo && passwordValidInfo) {
					return true
				} else {
					return false
				}
			}
		
		canTapConfirmButton = isValid$.asDriver(onErrorJustReturn: false)
		isValidUserEmail = isValidUserEmail$.asDriver(onErrorJustReturn: false)
		isValidPassword = isValidPassword$.asDriver(onErrorJustReturn: false)
		signInDenied = signInDenied$.asDriver(onErrorJustReturn: ())
		signInSuccess = signInSuccess$.asDriver(onErrorJustReturn: (User(email: "", name: "", password: "")))
		
		confirmButtonTapped
			.subscribe(onNext: (signInButtonTapped))
			.disposed(by: disposeBag)
	}

	private func signInButtonTapped() {
		Task {
			let result = try? await dependency.trySignInUser(
				userEmail: userEmail.value,
				password: password.value
			).value
			
			if let userInfo = result {
				signInSuccess$.onNext(userInfo)
			} else {
				signInDenied$.onNext(())
			}
		}
	}
}
