import Foundation
import RxSwift
import RxCocoa
import RxRelay

public protocol SignInViewModelInput {
	var userEmail: PublishRelay<String> { get }
	var password: PublishRelay<String> { get }
	var confirmButtonTapped: PublishRelay<Void> { get set }
	var findIdButtonTapped: PublishRelay<Void> { get set }
	var findPasswordButtonTapped: PublishRelay<Void> { get set }
	var registerButtonTapped: PublishRelay<Void> { get set }
}

public protocol SignInViewModelOutput {
	var isValidUserEmail: Driver<Bool> { get set }
	var isValidPassword: Driver<Bool> { get set }
	var canTapConfirmButton: Driver<Bool> { get set }
}

public protocol SignInViewModelType {
	var disposeBag: DisposeBag { get set }
	
	var input: SignInViewModelInput { get }
	var output: SignInViewModelOutput { get }
	
	init()
}

final class SignInViewModel: SignInViewModelType,
														 SignInViewModelInput,
														 SignInViewModelOutput
{
	var disposeBag = DisposeBag()
	
	var input: SignInViewModelInput { return self }
	var output: SignInViewModelOutput { return self}
	
	var userEmail = PublishRelay<String>()
	var password = PublishRelay<String>()
	var confirmButtonTapped = PublishRelay<Void>()
	var findIdButtonTapped = PublishRelay<Void>()
	var findPasswordButtonTapped = PublishRelay<Void>()
	var registerButtonTapped = PublishRelay<Void>()
	
	var isValidUserEmail: Driver<Bool>
	var isValidPassword: Driver<Bool>
	var canTapConfirmButton: Driver<Bool>
	
	init() {
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
				if (password.count > 6) {
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
		
		confirmButtonTapped
			.subscribe(
				onNext: {print("isTapped")}
			)
			.disposed(by: disposeBag)
	}
}
