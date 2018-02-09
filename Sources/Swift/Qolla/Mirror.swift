//
// Created by Daniela Postigo on 1/26/18.
//

extension Mirror {
	public static func customReflect( _ value: Any) -> String {
		let mirror = Mirror(reflecting: value)
		return mirror.children.isEmpty ? String(describing: value) : String(describing: mirror.children.first!.label!)
	}
}

