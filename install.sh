MIN_DEVICE_CONNECTED=3
SIGNAPK_FILE=signapk.jar
MY_ANDROID_PATH=$(cat 'MY_ANDROID_PATH')
if [ -z "$MY_ANDROID_PATH" ]; then
  if [ -z "$1" ]; then
    echo "Usage: ./install <PATH_TO_ANDROID_FOLDER>"
  else
    echo "---> Checking device connectivity"
    DEVICES_CONNECTED=$(adb devices | wc -l)
    if (($DEVICES_CONNECTED < $MIN_DEVICE_CONNECTED)); then
      echo "---> NO DEVICE CONNECTED!"
      echo "---> Is ADB Enabled on the device?"
    else
      echo "---> Device found!"
      printf "\n"
      echo "Using Provided ANDROID_SYSTEM_PATH: $1"
      echo "$1" >MY_ANDROID_PATH
      echo "---> Saved path to MY_ANDROID_PATH"
      echo "---> Next time you can run ./install without any arguments!"
      printf "\n"
      if test -f "$SIGNAPK_FILE"; then
        echo "---> SIGNING app/build/outputs/apk/app-release-unsigned.apk"
        java -jar signapk.jar $1/build/target/product/security/platform.x509.pem $1/build/target/product/security/platform.pk8 app/build/outputs/apk/app-release-unsigned.apk signed.apk &&
          echo "---> ATTEMPTING TO INSTALL SIGNED APK"
        adb install -r signed.apk
        echo "---> Removing temporary signed APK"
        rm signed.apk
      else
        echo "---> File 'signapk.jar' not found!"
      fi
    fi
  fi
else
  echo "---> Checking device connectivity"
  DEVICES_CONNECTED=$(adb devices | wc -l)
  if (($DEVICES_CONNECTED < $MIN_DEVICE_CONNECTED)); then
    echo "---> NO DEVICE CONNECTED!"
    echo "---> Is ADB Enabled on the device?"
  else
    echo "---> Device found!"
    printf "\n"
    echo "Using Saved ANDROID_SYSTEM_PATH: $MY_ANDROID_PATH"
    echo "Use: ./install <PATH_TO_ANDROID_FOLDER> to use and save a different path!"
    printf "\n"
    if test -f "$SIGNAPK_FILE"; then
      echo "---> SIGNING app/build/outputs/apk/app-release-unsigned.apk"
      java -jar signapk.jar $MY_ANDROID_PATH/build/target/product/security/platform.x509.pem $MY_ANDROID_PATH/build/target/product/security/platform.pk8 app/build/outputs/apk/app-release-unsigned.apk signed.apk &&
        echo "---> ATTEMPTING TO INSTALL SIGNED APK"
      adb install -r signed.apk
      echo "---> Removing temporary signed APK"
      rm signed.apk
    else
      echo "---> File 'signapk.jar' not found!"
    fi

  fi
fi
