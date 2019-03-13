# Usage

Add in ```Podfile``` ``` pod 'AppinappPhotosIos', :git => 'https://github.com/juvaly/appinapp-photos-ios.git', :tag => '0.0.1'```

In code
```swift
import AppinappPhotosIos 

class ViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // open app with apikey "APP-123-123-123"
        PhotoApp.open(with: "APP-123-123-123")
        // close app 
        // PhotoApp.close()
    }

}
```

Open app only when ```rootViewController``` is not ```nil```.
