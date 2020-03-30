
## Prerequisite

Add a google service config file in Android and iOS :
`android/app/google-services.json`
`ios/Runner/GoogleService-Info.plist`

Add release deployment key.jks
`android/app/keys/key.jks`

Add config file for release deployment
`android/key.properties`

Content : 
``` 
    storePassword=<storePassword>
    keyPassword=<storePassword>
    keyAlias=key
    storeFile=keys/key.jks
```

## Generate config for lunch icon

`flutter packages pub run flutter_launcher_icons:main`

## Build 

### APP BUNDLE
`flutter build appbundle`

### APK
`flutter build apk --split-per-abi`

### iOS
`flutter build ios`

###