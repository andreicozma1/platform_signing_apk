
# Platform Signing Android APKs
### + Installation

### Platform Key Location
> ~/android_O/android/build/make/target/product/security
#### Files: platform.pk8 and platform.x509.pem

## OPTION 1
#### Deploying Platform signed application from Android Studio!

### 1. Generate Signed APK from Platform Keys
> java -jar signapk.jar platform.x509.pem platform.pk8 unsigned.apk signed.apk

### 2. Push signed APK to the device
> adb push signed.apk /system/app/Example/ExampleApp.apk

## OPTION 2
#### Deploying Platform signed application from Android Studio!
### 1. Download keytool-importkeypair by getfatday and make it executable
> curl -O https://github.com/getfatday/keytool-importkeypair/blob/master/keytool-importkeypair
> chmod +x keytool-importkeypair
### 2. Optional: Add this tool to your Environment PATH
> mkdir ~/bin
> cp keytool-importkeypair ~/bin
> echo "export PATH="$HOME/bin:$PATH" > ~/.bashrc
> source ~/.bashrc
### 2. Generate KeyStore from Key-Pair
> keytool-importkeypair -k ~/Desktop/release.keystore -p android -pk8 platform.pk8 -cert platform.x509.pem -alias platform
This saved the Keystore file to the desktop as 'release.keystore'  
### 3. Import KeyStore into Android Studio:
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
