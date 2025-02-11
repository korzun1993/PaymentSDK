

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding PaymentSDK as a dependency is as easy as adding it to  the Package list in Xcode.

## Usage

1. Import PaymentSDK
```
import PaymentSDK
```
2. Create instance of PaymentSDK providing API key and Base URL
```
try! PaymentSDK(
            configuration: .init(
                apiKey: paymentSDKAPIKey,
                baseURL: paymentSDKBaseURL
            )
        )
```
3. Send request via PaymentSDK and handle results
```
await self.paymentSDK.postPaymentDetails(
  amount: 100,
  currency: .USD,
  recipient: "123"
)
``` 
