//
//  FourCharCode.swift
//  RSCore
//
//  Created by Olof Hellman on 1/7/18.
//  Copyright © 2018 Olof Hellman. All rights reserved.
//

import Foundation

public extension String {

	/// Converts a string to a `FourCharCode`.
	///
	/// `FourCharCode` values like `OSType`, `DescType` or `AEKeyword` are really just
	///	4-byte values commonly represented as values like `'odoc'` where each byte is
	///	represented as its Mac Roman character. This property turns a Swift string into
	///	its `FourCharCode` equivalent, as Swift doesn't recognize `FourCharCode` types
	///	natively just yet. With this extension, one can use `"odoc".fourCharCode`
	///	where one would really want to use `'odoc'`.
	var fourCharCode: FourCharCode {
		return FourCharCode(self)
	}
}

public extension Int {

	var fourCharCode: FourCharCode {
		return UInt32(self)
	}
}

extension FourCharCode: ExpressibleByStringLiteral {

	public typealias StringLiteralType = String

	public init(stringLiteral: String) {
		self.init(stringLiteral)
	}

	public init(_ string: String) {
		// Match NSHFSTypeCodeFromFileType() behavior: Return 0 for invalid codes.
		guard string.count == 4, let data = string.data(using: .macOSRoman) else {
			self = 0
			return
		}

		self = FourCharCode(data[0]) << 24 | FourCharCode(data[1]) << 16 | FourCharCode(data[2]) << 8 | FourCharCode(data[3])
	}

}
