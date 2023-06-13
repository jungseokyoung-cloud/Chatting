import Foundation

extension Encodable {
	func toDictionry() -> [String: Any]? {
		guard
			let object = try? JSONEncoder().encode(self),
			let dictionry = try? JSONSerialization.jsonObject(with: object, options: []) as? [String: Any]
		else
		{
			return nil
		}
		return dictionry
	}
	
	func toDictionryArray() -> [[String: Any]]? {
		guard
			let object = try? JSONEncoder().encode(self),
			let dictionry = try? JSONSerialization.jsonObject(with: object, options: []) as? [[String: Any]]
		else
		{
			return nil
		}
		return dictionry
	}
}
