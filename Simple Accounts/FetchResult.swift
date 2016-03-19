//
//  FetchResult.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 19/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

enum FetchResult<T> {
    case Success([T])
    case Failure(ErrorType)
    
    ///Either returns the original Success array or an empty array in case of Failure
    func simpleResult() -> [T] {
        switch self {
        case .Success(let results):
            return results
        case .Failure(_):
            return [T]()
        }
    }
}