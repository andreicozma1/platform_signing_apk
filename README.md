
# Platform Signing Android APKs
### + Installation

### Platform Key Location
> ~/android_O/android/build/make/target/product/security

## OPTION 1
#### Deploying Platform signed application from Android Studio!

### 1. Generate Signed APK from Platform Keys
> java -jar signapk.jar platform.x509.pem platform.pk8 unsigned.apk signed.apk

### 2. Push signed APK to the device
> adb push signed.apk /system/app/Example/ExampleApp.apk

## OPTION 2
#### Deploying Platform signed application from Android Studio!
### 1. Generate KeyStore from Key-Pair
> keytool-importkeypair -k ~/Desktop/release.keystore -p android -pk8 platform.pk8 -cert platform.x509.pem -alias platform
This saved the Keystore file to the desktop as 'release.keystore'  

### 2. Import KeyStore into Android Studio:
- In Android Studio -> File -> Project Structure -> Modules -> Signing Configs
- Store File: ~/Desktop/release.keystore
- Store Password: android
- Key Alias: platform
- Key Password: android

## Extras
### Enable Android Remounting System Read-Write
> adb root  
> adb disable-verity  
> adb reboot  
> adb root  
> adb remount  
