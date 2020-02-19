# Swift Feistel Cipher
My attempt at implementing a Feistel Cipher completely in Swift 

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

