# Growthbeat Core SDK for iOS

Growthbeat Core SDK for iOS

## Usage

1. Add GrowthbeatCore.framework into your project. 

1. Import the framework header.

	```objc
	#import <GrowthbeatCore/GrowthbeatCore.h>
	```

1. Write initialization code

	```objc
	[GrowthbeatCore initializeWithApplicationId:@"APPLICATION_ID" credentialId:@"CREDENTIAL_ID"];
	```

## Growthbeat Full SDK

Growthbeat is growth hack platform for mobile apps. This repository includes only few function, but you can integrate some services. If you would like to use all functions of Growthbeat, you can choose following SDK.

* [Growthbeat SDK for iOS](https://github.com/SIROK/growthbeat-ios/)
* [Growthbeat SDK for Android](https://github.com/SIROK/growthbeat-android/)

## Integrations

### Growth Push

[Growth Push](https://growthpush.com/) is push notification and analysis platform for mobile apps.

* [Growth Push SDK for iOS](https://github.com/SIROK/growthpush-ios)
* [Growth Push SDK for Android](https://github.com/SIROK/growthpush-android)

### Growth Replay

[Growth Replay](https://growthreplay.com/) is usability testing tool for mobile apps.

* [Growth Replay SDK for iOS](https://github.com/SIROK/growthreplay-ios)
* [Growth Replay SDK for Android](https://github.com/SIROK/growthreplay-android)

# Building framework

[iOS-Universal-Framework](https://github.com/kstenerud/iOS-Universal-Framework) is required.

```bash
git clone https://github.com/kstenerud/iOS-Universal-Framework.git
cd ./iOS-Universal-Framework/Real\ Framework/
./install.sh
```

Archive the project on Xcode and you will get framework package.

## License

Apache License, Version 2.0


