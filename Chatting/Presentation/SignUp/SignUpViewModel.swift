import Foundation
import RxCocoa
import RxSwift

protocol SignUpViewModelInput {
	var userEmail: BehaviorRelay<String> { get }
	var password: BehaviorRelay<String> { get }
	var confirmButtonTapped: PublishRelay<Void> { get }
}

protocol SignUpViewModelOutput {
	var isValidUserEmail: Driver<Bool> { get }
	var isValidPassword: Driver<Bool> { get }
	var canTapConfirmButton: Driver<Bool> { get }
//	var registerInDenied: Driver<Void> { get }
}

protocol SignUpViewModelType {
	var disposBag: DisposeBag { get }
	var dependency: SignUpUseCaseType { get set }
	
	var input: SignUpViewModelInput { get }
	var output: SignUpViewModelOutput { get }
}

final class SignUpViewModel: SignUpViewModelType,
														 SignUpViewModelInput,
														 SignUpViewModelOutput
{
	var disposBag = DisposeBag()
	var dependency: SignUpUseCaseType
	
	var input: SignUpViewModelInput { return self }
	var output: SignUpViewModelOutput { return self }
	
	var userEmail = BehaviorRelay<String>(value: "")
	var password = BehaviorRelay<String>(value: "")
	var confirmButtonTapped = PublishRelay<Void>()
	
	var isValidUserEmail: Driver<Bool>
	var isValidPassword: Driver<Bool>
	var canTapConfirmButton: Driver<Bool>
//	var registerInDenied: Driver<Void>
	
	init(dependency: SignUpUseCaseType = SignUpUseCaseImpl()) {
		self.dependency = dependency
		
		let isValidUserEmail$ = userEmail
			.skip(1)
			.map { email in
				if (email.contains("@") && email.contains(".")) {
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
		
		self.isValidUserEmail = isValidUserEmail$.asDriver(onErrorJustReturn: false)
		self.isValidPassword = isValidPassword$.asDriver(onErrorJustReturn: false)
		self.canTapConfirmButton = isValid$.asDriver(onErrorJustReturn: false)
	}
}
