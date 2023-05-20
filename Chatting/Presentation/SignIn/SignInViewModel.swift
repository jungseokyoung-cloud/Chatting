import Foundation
import RxSwift
import RxCocoa
import RxRelay
import Firebase

protocol SignInViewModelInput {
	var userEmail: BehaviorRelay<String> { get }
	var password: BehaviorRelay<String> { get }
	var confirmButtonTapped: PublishRelay<Void> { get set }
	var findIdButtonTapped: PublishRelay<Void> { get set }
	var findPasswordButtonTapped: PublishRelay<Void> { get set }
	var registerButtonTapped: PublishRelay<Void> { get set }
}

protocol SignInViewModelOutput {
	var isValidUserEmail: Driver<Bool> { get set }
	var isValidPassword: Driver<Bool> { get set }
	var canTapConfirmButton: Driver<Bool> { get set }
	var signInDenied: Driver<Void> { get }
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
	var registerButtonTapped = PublishRelay<Void>()
	
	var isValidUserEmail: Driver<Bool>
	var isValidPassword: Driver<Bool>
	var canTapConfirmButton: Driver<Bool>
	var signInDenied: Driver<Void>
	
	private let signInDenied$ = PublishSubject<Void>()

	init(dependency: SignInUseCaseType = SignInUseCase()) {
		self.dependency = dependency
		
		let isValidUserEmail$ = userEmail
			.map { email in
				if (email.contains("@") && email.contains(".")) {
					return true
				} else {
					return false
				}
			}
		
		let isValidPassword$ = password
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
		
		confirmButtonTapped
			.subscribe(onNext: (signInButtonTapped))
			.disposed(by: disposeBag)
	}
	
	private func signInButtonTapped() {
		Task {
			let result: Void? = try? await dependency.trySignInUser(
				userEmail: userEmail.value,
				password: password.value
			).value
			
			if result != nil {
				print("loginSuccess")
			} else {
				signInDenied$.onNext(())
			}
		}
	}
}
