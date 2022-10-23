//
//  Constants.swift
//  FossTube
//
//  Created by Shrey Soni on 29/08/22.
//

import Foundation

class Constants{
    static var defaultCountryCode = "IN"
}


enum Either<A,B>{
    case Left(A)
    case Right(B)
}


enum ThrowableError:Error{
    case MalformedResponse
    case ParsingError
    case ResponseDataFoundNull
}
