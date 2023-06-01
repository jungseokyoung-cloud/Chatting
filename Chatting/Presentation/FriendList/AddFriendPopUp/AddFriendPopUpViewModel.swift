import Foundation
import RxCocoa
import RxSwift

protocol AddFriendPopUpViewModelInput {
	var friendName: BehaviorRelay<String> { get }
	var addButtonTapped: PublishRelay<Void> { get }
}

protocol AddFriendPopUpViewModelOutput {
	var canTapConfirmButton: Driver<Bool> { get }
}


protocol AddFriendPopUpViewModelType {
	var disposBag: DisposeBag { get }
	
	var input: AddFriendPopUpViewModelInput { get }
	var output: AddFriendPopUpViewModelOutput { get }
	
	init()
}

final class AddFriendPopUpViewModel:
	AddFriendPopUpViewModelInput,
	AddFriendPopUpViewModelOutput,
	AddFriendPopUpViewModelType
{
	var disposBag = DisposeBag()
	
	//Input
	var friendName = BehaviorRelay<String>(value: "")
	var addButtonTapped = PublishRelay<Void>()
	
	//Output
	var canTapConfirmButton: Driver<Bool>
	
	var input: AddFriendPopUpViewModelInput { return self }
	var output: AddFriendPopUpViewModelOutput { return self }
	
	
	init() {
		let canTapConfirmButton$ = friendName
			.skip(1)
			.map {
				email in
				if(email.checkValidPattern(.email)) {
					return true
				} else {
					return false
				}
			}
		
		canTapConfirmButton = canTapConfirmButton$.asDriver(onErrorJustReturn: false)
		
		addButtonTapped
			.subscribe(
				onNext: (tryAddFriend)
			)
			.disposed(by: disposBag)
	}
	
	private func tryAddFriend() {
		let userName = friendName.value
		
		print(userName)
	}
}
