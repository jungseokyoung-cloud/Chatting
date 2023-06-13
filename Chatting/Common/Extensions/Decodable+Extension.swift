import Foundation

extension Decodable {
	func dictionaryToObject<T: Decodable> (_ objectType: T.Type) -> T?
	{
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		if
			let dictionary = try? JSONSerialization.data(withJSONObject: self),
			let objects = try? decoder.decode(T.self, from: dictionary)
		{
			return objects
		} else {
			return nil
		}
	}
	
//	func dictionaryArrayToObject<T: Decodable> (_ objectType: T.Type) -> T?
//	{
//		let decoder = JSONDecoder()
//		decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//		if
//			let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary),
//			let objects = try? decoder.decode(T.self, from: dictionaries)
//		{
//			return objects
//		} else {
//			return nil
//		}
//	}
}
