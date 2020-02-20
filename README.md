# Swift Feistel Cipher
My attempt at implementing a Feistel Cipher completely in Swift 

![](https://img.shields.io/github/license/wvabrinskas/Swift-Feistel-Cipher)
![](https://img.shields.io/cocoapods/v/Feistel)
![](https://img.shields.io/badge/swift-5.1-orange)
![](https://img.shields.io/badge/iOS-13+-blue)

# Background

"In cryptography, a Feistel cipher is a symmetric structure used in the construction of block ciphers, named after the German-born physicist and cryptographer Horst Feistel who did pioneering research while working for IBM (USA); it is also commonly known as a Feistel network. A large proportion of block ciphers use the scheme, including the Data Encryption Standard (DES). The Feistel structure has the advantage that encryption and decryption operations are very similar, even identical in some cases, requiring only a reversal of the key schedule. Therefore, the size of the code or circuitry required to implement such a cipher is nearly halved." (Wikipedia)

<img width="100" src=".images/cipher.png&">

# Installation
- Add to your podfile `pod 'Feistel'`

# Usage
1. Create a `Feistel` object with the number of passes you would like to take. 
    - `let fest = Fesitel(passes: 20)`
2. Create the `Data` object you would like to encrypt.
    - `let data = "super duper awesome test".data(using: .utf8)`
3. To encrypt:
    - `let encrypted = fest.encrypt(data: data)`
4. To decrypt (using already encrypted data): 
    - `let decrypt = fest.decrypt(data: encrypted)`

# Resources 
- Feistel Cipher - Computerphile: https://www.youtube.com/watch?v=FGhj3CGxl8I
- Feistel cipher - https://en.wikipedia.org/wiki/Feistel_cipher
