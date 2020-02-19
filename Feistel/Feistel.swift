import Foundation
import UIKit
import CryptoKit
import CommonCrypto

open class Fesitel {
    private var passes: Int
    
    init(passes: Int) {
        self.passes = passes
    }
    
    private lazy var keys: [String] = {
        var keysN:[String] = []
        for _ in 0..<self.passes {
            keysN.append(generateKey())
        }
        return keysN
    }()
    
    private func generateKey() -> String {
        
        let charsLower = "abcdefghijklmnopqrstuvwxyz"
        let charsUpper = charsLower.uppercased()
        let integers = "0123456789"
        let symbols = "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
        
        let chars = charsLower + charsUpper + integers + symbols
        
        let wordLength = 10
        var word = ""
        for _ in 0...wordLength {
            let char = Int.random(in: 1..<chars.count)
            
            let lowerBound = chars.index(chars.startIndex, offsetBy: char - 1)
            let upperBound = chars.index(chars.startIndex, offsetBy: char)
            
            word += chars[lowerBound..<upperBound]
        }
        return word
    }
    
    private func ccSha512(data: Data) -> Data {
        var digest = Data(count: Int(CC_SHA512_DIGEST_LENGTH))

        _ = digest.withUnsafeMutableBytes { (digestBytes) in
            data.withUnsafeBytes { (stringBytes) in
                CC_SHA256(stringBytes, CC_LONG(data.count), digestBytes)
            }
        }
        return digest
    }
    
    private func chunks(data: Data) -> [Data] {
        var dataChunks:[Data] = []
        
        data.withUnsafeBytes { ptr in
            
            if let mutRawPointer = UnsafeMutableRawPointer(mutating: ptr.baseAddress) {
                let totalSize = data.count
                let uploadChunkSize = totalSize / 2
                var offset = 0
                
                while offset < totalSize {
                    let chunkSize = offset + uploadChunkSize > totalSize ? totalSize - offset : uploadChunkSize
                    let chunk = Data(bytesNoCopy: mutRawPointer+offset, count: chunkSize, deallocator: Data.Deallocator.none)
                    dataChunks.append(chunk)
                    offset += chunkSize
                }
            }
        }
        return dataChunks
        
    }
    
    private func xor(left: Data, right: Data) -> Data {
        var data = Data(count: left.count)
        
        for i in 0..<left.count {
            data[i] = left[i] ^ right[i]
        }

        return data
    }
    
    private func run(data: Data, count: Int) -> Data? {
        
        let chunks: [Data] = self.chunks(data: data)

        var left = chunks[0]
        var right = chunks[1]
        var oldRight = chunks[1]
                    
        let key = keys[count]
        let keyData = key.data(using: .utf8)!
        right.append(keyData)
        
        let hashedRight = self.ccSha512(data: right)
        let newRight = xor(left: left, right: hashedRight)

        oldRight.append(newRight)

        return oldRight
    }
    
    private func swap(data: Data) -> Data {
        let chunks = self.chunks(data: data)
        let left = chunks[0]
        var right = chunks[1]
        right.append(left)
        return right
    }
    
    open func encrypt(data: Data?, count: Int = 0) -> Data? {
        guard let nonNilData = data else {
            return nil
        }
        
        guard count < passes else {
            return self.swap(data: nonNilData)
        }
        
        let newData = self.run(data: nonNilData, count: count)
        
        let newCount = count + 1
        return self.encrypt(data: newData, count: newCount)
    }
    
    open func decrypt(data: Data?, count: Int = 0) -> Data? {
        guard let nonNilData = data else {
            return data
        }
        
        guard count < passes else {
            return self.swap(data: nonNilData)
        }
        
        let newData = self.run(data: nonNilData, count: (passes - 1) - count)
        
        let newCount = count + 1
        return self.decrypt(data: newData, count: newCount)
    }
}



