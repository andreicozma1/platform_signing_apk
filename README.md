### Enable Android Remounting System Read-Write
> adb root
> adb disable-verity
> adb reboot
> adb root
> adb remount

### Platform Key Location:
~/ELO/system/android_O/android/build/make/target/product/security

### Generate Signed APK
> java -jar SignApk.jar platform.x509.pem platform.pk8 unsigned.apk signed.apk
> adb push signed.apk /system/app/EloAthens/EloAthens.apk

### Generate KeyStore from Key-Pair
> keytool-importkeypair -k ~/Desktop/release.keystore -p android -pk8 platform.pk8 -cert platform.x509.pem -alias platform

### Import KeyStore into Android Studio:
- In Android Studio -> File -> Project Structure -> Modules -> Signing Configs
- Store File: ~/Desktop/release.keystore
- Store Password: android
- Key Alias: platform
- Key Password: android
