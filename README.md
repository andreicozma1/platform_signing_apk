
# Platform Signing Android APKs + Installation Script

### Platform Key Location
> ~/Android_O/android/build/make/target/product/security   

Files: `platform.pk8` and `platform.x509.pem`

---

## OPTION 1 - Use the provided script
1. Go to your Android Studio project folder
2. Copy `signapk.jar` and `install.sh` to the root of the project folder.
3. Make install.sh executable: `chmod +x install.sh`
3. Build your Android App: `./gradlew build`
4. Ensure the unsigned APK exists: `app/build/outputs/apk/###-release-unsigned.apk`
- Connect your device and run the script from the root folder:
> ./install <PATH_TO_ANDROID_FOLDER>
- Example:  
> ./install /home/acozma/android  
where `android` is the root directory of Android System Source Code
- Second run you can just use `./install.sh` to use the previously saved path.

---

## OPTION 2 - Deploying Platform signed application Manually
#### 1. Generate Signed APK from Platform Keys
> java -jar signapk.jar platform.x509.pem platform.pk8 example-app-unsigned.apk example-app-signed.apk
#### 2. Push signed APK to the device
> adb push signed.apk /system/app/Example/ExampleApp.apk

---

## OPTION 3 - Deploying Platform signed application from Android Studio!
#### 1. Download keytool-importkeypair by getfatday and make it executable
> curl -O https://github.com/getfatday/keytool-importkeypair/blob/master/keytool-importkeypair   
> chmod +x keytool-importkeypair   
#### 2. Optional: Add this tool to your Environment PATH
> mkdir ~/bin   
> cp keytool-importkeypair ~/bin   
> echo "export PATH="$HOME/bin:$PATH"" > ~/.bashrc   
> source ~/.bashrc   
#### 2. Generate KeyStore from Key-Pair
> keytool-importkeypair -k ~/Desktop/release.keystore -p android -pk8 platform.pk8 -cert platform.x509.pem -alias platform   
This saved the Keystore file to the desktop as 'release.keystore'  
#### 3. Import KeyStore into Android Studio:
- In Android Studio -> File -> Project Structure -> Modules -> Signing Configs
- Store File: `~/Desktop/release.keystore`
- Store Password: `android`
- Key Alias: `platform`
- Key Password: `android`

---

## EXTRAS - Unused
#### Enable Android Remounting System Read-Write
> adb root  
> adb disable-verity  
> adb reboot  
> adb root  
> adb remount  
