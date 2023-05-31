import Foundation
import RxCocoa
import RxSwift

//TODO: 잘못된 이메일 형식 에러 처리
//TODO: UseCase Repository 연결

protocol AddFriendPopUpViewModelInput {
	var friendName: BehaviorRelay<String> { get }
	var addButtonTapped: PublishRelay<Void> { get }
}

protocol AddFriendPopUpViewModelOutput {
	
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
	
	
	var input: AddFriendPopUpViewModelInput { return self }
	var output: AddFriendPopUpViewModelOutput { return self }
	
	init() {
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
