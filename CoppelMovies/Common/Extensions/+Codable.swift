//
//  +Codable.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 22/10/21.
//

import Foundation

extension Encodable {
    var asDictionary : [String:Any] {
       let mirror = Mirror(reflecting: self)
       let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
         guard let label = label else { return nil }
         return (label, value)
       }).compactMap { $0 })
       return dict
     }
}
