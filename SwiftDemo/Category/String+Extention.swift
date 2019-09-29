//
//  String+Extention.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2016/11/14.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import Foundation
import CoreGraphics

#if false
// http://www.cnblogs.com/FranZhou/p/5086079.html

enum CryptoAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    
    var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:      result = kCCHmacAlgMD5
        case .SHA1:     result = kCCHmacAlgSHA1
        case .SHA224:   result = kCCHmacAlgSHA224
        case .SHA256:   result = kCCHmacAlgSHA256
        case .SHA384:   result = kCCHmacAlgSHA384
        case .SHA512:   result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .MD5:      result = CC_MD5_DIGEST_LENGTH
        case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

extension String {

    var md5: String {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: true)!
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: data.count)
        data.copyBytes(to: buffer, count: data.count)
        var digest = [UInt8](repeating:0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(buffer, CC_LONG(data.count), &digest)
        buffer.deinitialize(count: data.count)
        let result = digest.reduce(""){String(format: "\($0)%02x", $1)}
        
        return result
    }
    
    
    var sha1: String {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: true)!
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: data.count)
        data.copyBytes(to: buffer, count: data.count)
        var digest = [UInt8](repeating:0, count: Int(CC_SHA1_DIGEST_LENGTH))
        CC_SHA1(buffer, CC_LONG(data.count), &digest)
        buffer.deinitialize(count: data.count)
        let result = digest.reduce(""){String(format: "\($0)%02x", $1)}

        return result
    }
    
    
    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        
        let buffer = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))
        
        CCHmac(algorithm.HMACAlgorithm, keyStr, keyLen, str, strLen, buffer)
        buffer.deinitialize(count: digestLen)
        
        let digest = stringFrom(result: buffer, length: digestLen)

        return digest
    }
    
    private func stringFrom(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
    
    
    //MARK: - base64
    func base64Encode() -> String? {
        let data = self.data(using: String.Encoding.utf8)
        return data?.base64EncodedString()
    }
    
    func base64Decode() -> String? {
        let data = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))
        let result = NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
        return result as String?
    }
}
#endif


extension NSAttributedString {
    
    func boundingSize(with maxSize: CGSize) -> CGSize {
        let rect = boundingRect(with: maxSize, options: .usesLineFragmentOrigin, context: nil)
        return rect.size
    }
    
    
    static func newLineText() -> NSAttributedString {
        return NSAttributedString(string: "\n")
    }
}







