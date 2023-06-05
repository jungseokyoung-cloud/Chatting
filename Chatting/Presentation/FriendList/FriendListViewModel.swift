import Foundation
import RxSwift
import RxCocoa

protocol FriendListViewModelInput {
	func viewWillAppear()
}

protocol FriendListViewModelOutput {
	var friendList: Driver<[User]> { get }
	var fetchFriendListError: Driver<Void> { get }
}

protocol FriendListViewModelType {
	var dependency: FriendListUseCaseType { get }
	var disposBag: DisposeBag { get }
	
	var input: FriendListViewModelInput { get }
	var output: FriendListViewModelOutput { get }
	
	init(dependency: FriendListUseCaseType)
}

final class FriendListViewModel:
	FriendListViewModelInput,
	FriendListViewModelOutput,
	FriendListViewModelType
{
	var dependency: FriendListUseCaseType
	var disposBag = DisposeBag()
	
	//Input
	var friendList: Driver<[User]>
	var fetchFriendListError: Driver<Void>
	
	var input: FriendListViewModelInput { return self }
	var output: FriendListViewModelOutput { return self }
	
	private let friendList$ = PublishSubject<[User]>()
	private let fetchFriendListError$ = PublishSubject<Void>()

	init(dependency: FriendListUseCaseType = FriendListUseCase()) {
		self.dependency = dependency
		
		friendList = friendList$.asDriver(onErrorJustReturn: [])
		fetchFriendListError = fetchFriendListError$.asDriver(onErrorJustReturn: ())
	}
	
	func viewWillAppear() {
		Task {
			let value = try? await dependency.getFriendList().value
			
			if let value = value {
				friendList$.onNext(value)
			} else {
				fetchFriendListError$.onNext(())
			}
		}
	}
}
