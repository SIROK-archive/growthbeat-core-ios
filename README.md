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
	[[GrowthbeatCore sharedInstance] initializeWithApplicationId:@"APPLICATION_ID" credentialId:@"CREDENTIAL_ID"];
	```

## Growthbeat Full SDK

Growthbeat is growth hack platform for mobile apps. This repository includes only few function, but you can integrate some services. If you would like to use all functions of Growthbeat, you can choose following SDK.

* [Growthbeat SDK for iOS](https://github.com/SIROK/growthbeat-ios/)
* [Growthbeat SDK for Android](https://github.com/SIROK/growthbeat-android/)

## Integrations

### Growth Analytics

[Growth Analytics](https://analytics.growthbeat.com/) is analytics service for mobile apps.

* [Growth Analytics SDK for iOS](https://github.com/SIROK/growthanalytics-ios)
* [Growth Analytics SDK for Android](https://github.com/SIROK/growthanalytics-android)

### Growth Push (Under development)

[Growth Push](https://growthpush.com/) is push notification and analysis platform for mobile apps.

* [Growth Push SDK for iOS](https://github.com/SIROK/growthpush-ios)
* [Growth Push SDK for Android](https://github.com/SIROK/growthpush-android)

### Growth Replay (Under development)

[Growth Replay](https://growthreplay.com/) is usability testing tool for mobile apps.

* [Growth Replay SDK for iOS](https://github.com/SIROK/growthreplay-ios)
* [Growth Replay SDK for Android](https://github.com/SIROK/growthreplay-android)

# Building framework

1. Set build target to GrowthbeatCoreFramework and iOS Device.
1. Run.

## License

Apache License, Version 2.0


