import Foundation
import RxSwift
import RxCocoa
import RxRelay

public protocol SignInViewModelInput {
	var userName: PublishRelay<String> { get }
	var password: PublishRelay<String> { get }
	var confirmButtonTapped: PublishRelay<Void> { get set }
	var findIdButtonTapped: PublishRelay<Void> { get set }
	var findPasswordButtonTapped: PublishRelay<Void> { get set }
	var registerButtonTapped: PublishRelay<Void> { get set }
}

public protocol SignInViewModelOutput {
	var isValid: Driver<Bool> { get set }
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
	
	var userName = PublishRelay<String>()
	var password = PublishRelay<String>()
	var confirmButtonTapped = PublishRelay<Void>()
	var findIdButtonTapped = PublishRelay<Void>()
	var findPasswordButtonTapped = PublishRelay<Void>()
	var registerButtonTapped = PublishRelay<Void>()
	
	var isValid: Driver<Bool>
	
	init() {
		let isValid$ = Observable<Bool>
			.combineLatest(userName, password) { (userName, password) in
				if(userName != "" && password.count > 6) {
					return true
				} else {
					return false
				}
			}
		
		isValid = isValid$.asDriver(onErrorJustReturn: false)
		
		confirmButtonTapped
			.subscribe(
				onNext: {print("isTapped")}
			)
			.disposed(by: disposeBag)
	}
}
