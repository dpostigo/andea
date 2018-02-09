//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation
import Alamofire

public struct EntityResponseSerializer<T: Decodable> : CustomResponseSerializer {
	public typealias SerializedObject = T
	public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<SerializedObject>

	public init() {
		self.serializeResponse = {  _, response, data, error in
			let result = Request.serializeResponseData(response: response, data: data, error: error)
			switch result {
				case .success(let data):
                    do {
    
                        let result: T = try JSONDecoder.decode(T.self, from: data, dateDecodingStrategy: .formatted(DateFormatter.iso8601Full))
    
                        Swift.print("result = \(String(describing: result))")
    
                        return .success(result)
                    }
                    catch let error as DecodingError {
                        
                        let json = try? JSONSerialization.jsonObject(with: data) 
                        
                       
                        switch error {
                            case .valueNotFound(let type, let context):
                            
                                Log.divider()
                                Log.print("DecodingError.valueNotFound, type = \(type), context = \(context)")
                                Log.print("context.codingPath = \(context.codingPath)")

                                // Log.print("json = \(json)")
                                break
                            
                            case .typeMismatch(let type, let context):
                                
                                Log.divider()
                                Log.print("DecodingError.typeMismatch, type = \(type), context = \(context)")
                                Log.print("context.codingPath = \(context.codingPath)")
                            
                                let something = context.codingPath
                            
//                            something.
                            
                            default:
                                Log.print("DecodingError, error = \(error)")
                            
                        }
                      
                        return .failure(error)
                    }
					catch {
                       
                        return .failure(error)
					}
				case .failure(let error):
                    
                    Log.divider()
                    Log.print("error = \(error)")
                    Log.divider()
                    return .failure(error)
			}
		}
	}

}


extension Alamofire.DataRequest {
	public static func decodableResponseSerializer<T: Decodable>() -> EntityResponseSerializer<T> { return EntityResponseSerializer() }
}


