import Foundation

enum NetworkError: Error {
	case InValidSignIn
	case InvalidSignUp
	case ServerError
	case FecthError
	case NotExistUser
	case AlreadyExist
	case InvalidAccess
}
