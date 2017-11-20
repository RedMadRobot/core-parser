# CoreParser

## Features
* Recursive parse algorithm
* Parse primitive types
* Different log levels

## Installation
Cocoapods

```ruby
pod 'CoreParser'
```

## Usage

Let's assume you object user. It has mandatory and optional field. In swift it looks like this.

```swift
class User {

	var firstName: String = ""
	
	var secondName: String = ""
	
	var middleName: String? = nil

}
```

That means first and last name is mandatory, middle name is optional. So if you get user from server without mandatory field it should be rejected. For instance

```javascript
{
	"user": {
		"last_name": "Appleseed",
		"middle_name": "Key"
	}
}
```

It's really important in practice to deny "wrong" objects: it can crash your app, if you use only optional types or leads to undefined behaviour.

```swift
// Convert Data into object (dictionary or array) after network response 
let json = try JSONSerialization.jsonObject(with: jsonData, options: [])

// Initialize your parser with required log level
let parser = AccountParser(logLevel: .logMandatoryFields)

// Parse response
// If you wait only one object, just add .first in the end
let users = parser.parse(json)

```

Parser for user looks like this

```swift
class UserParser: JSONParser<User> {
    
    override func parseObject(_ data: JSON) -> User? {

	     // call this method only if you need logs
        printAbsentFields(in: data)
        
        // checking for mandatory fields
        guard
            let firstName = data["first_name"]?.string,
            let lastName = data["last_name"]?.string
        else {
            return nil
        }
        
        let object = User()
        object.firstName = firstName
        object.lastName = lastName
        object.middleName = data["middle_name"]?.string
        
        return object
    }
    
    
    // override this method only if you need logs
    override class func modelFields() -> Fields {
        return Fields(
            mandatory: Set(["first_name", "last_name"]),
            optional: Set(["middle_name"])
        )
    }
    
}

```

If your back-end changes key `user` for `data` it continue to work due to its algorithm: JSON keys are analyzed only for properties, that parser try to find recursively.

For more info please look at the example project.


## TODOs
* Create and return errors for failed parse objects
* Log error only once for single object

## Authors
Ivan Vavilov, iv@redmadrobot.com

Andrey Rozhkov, ar@redmadrobot.com


## Requirements
* Xcode 9
* Swift 4
* iOS 8

## License
CoreParser is available under the MIT license. See the LICENSE file for more info.