//
//  StringExtension.swift
//  code hero
//
//  Created by Thalles Araújo on 12/02/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

//
// Based on https://gist.github.com/finder39/f6d71f03661f7147547d
// NOTE: There's no CommonCrypto module for Swift. To make the import CommonCrypto line work do something like what's described in http://stackoverflow.com/a/29189873/257577
//
import Foundation
import CommonCrypto

extension String {
    /**
     Get the MD5 hash of this String
     
     - returns: MD5 hash of this String
     */
    func md5() -> String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, self, CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate()
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        return hexString
    }
}
