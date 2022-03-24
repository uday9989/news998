//
//  ServiceError.swift
//  Newsin
//
//  Created by MAC on 24/03/22.
//

import Foundation

enum ServiceError: Error {
    case failedToCreateRequest
    case dataNotFound
    case parsingError
    case networkNotAvailable
}
