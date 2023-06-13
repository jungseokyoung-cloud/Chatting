import Foundation
import RxCocoa
import RxSwift

protocol AddFriendPopUpListner {
	func AddFriendPopUpCloseButtonTapped()
	func AddFriendPopUpAddButtonTapped(email: String)
}

protocol AddFriendPopUpViewModelInput {
	var friendName: BehaviorRelay<String> { get }
	var addButtonTapped: PublishRelay<Void> { get }
}

protocol AddFriendPopUpViewModelOutput {
	var canTapConfirmButton: Driver<Bool> { get }
}


protocol AddFriendPopUpViewModelType {
	var listener: AddFriendPopUpListner { get }
	var disposBag: DisposeBag { get }
	
	var input: AddFriendPopUpViewModelInput { get }
	var output: AddFriendPopUpViewModelOutput { get }
	
	init(listener: AddFriendPopUpListner)
}

final class AddFriendPopUpViewModel:
	AddFriendPopUpViewModelInput,
	AddFriendPopUpViewModelOutput,
	AddFriendPopUpViewModelType
{
	var listener: AddFriendPopUpListner
	var disposBag = DisposeBag()
	
	//Input
	var friendName = BehaviorRelay<String>(value: "")
	var addButtonTapped = PublishRelay<Void>()
	
	//Output
	var canTapConfirmButton: Driver<Bool>
	
	var input: AddFriendPopUpViewModelInput { return self }
	var output: AddFriendPopUpViewModelOutput { return self }
	
	init(listener: AddFriendPopUpListner) {
		self.listener = listener
		
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
				onNext: (addFriendTapped)
			)
			.disposed(by: disposBag)
	}
	
	private func addFriendTapped() {
		let data = friendName.value
		listener.AddFriendPopUpAddButtonTapped(email: data)
	}
	
	private func closeButtonTapped() {
		listener.AddFriendPopUpCloseButtonTapped()
	}
}
