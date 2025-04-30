# Simple CLI tool to change your language (input source) on macOS.

Video demo:

![Video demo](https://github.com/user-attachments/assets/25c29636-95ed-47be-aff9-8baa14432353)

### Motivation:
I needed some CLI tool for changing my input source because i wanted to make a tool for automating the process of creating screenshots for my macOS application.
I'm writing the screenshot making automation in AppleScript and it does not natively suppport changing an input source.
To achieve language changing with AppleScript you can run some external shell script (which is why I made this binary).

### How to run it:
1. Download the binary from the latest release
2. Convenience-wise i recommend you to put the binary to `/usr/local/bin/` on your macOS, so you don't need to write the full path to this tool each time you run it. You can do it like this: `sudo cp /path/to/downloaded/change-language /usr/local/bin/`
3. To get available input sources with their IDs run `change-language` (or full path to the binary).
4. To switch to some other input source, just run `change-language {ID}`. Fox example: `change-language 0`, which will set your input source to English.

### Want to build it yourself?
1. Download this repository
2. Open termianl
3. `cd` into the downloaded repo like this: `cd /Users/kopyl/Downloads/change-language`
4. Run `swift run change-language` to just run it
5. Run `swift build` to just build it for debugging
6. Run `swift build -c release` to build it for release (like i did)
7. Run `swift build -c release --show-bin-path` to show the binary path of the just-built binary

### Want to share it with friends?
You need to ~~suffer~~ sign it first with a developer account (which costs $99 a year 🤬). But in case you have it (like i do), here are the steps to do it:
1. First you must generate a certificate. To do it:<br>
  1.1. Open 'Keychain Access.app'. To do it:<br>
   1.1.1. You might open Spotlight, type 'Keychain' and select 'Keychain Access.app'. Or find it somewhere in `'/System/Library/CoreServices/Applications/Keychain Access.app'`<br>
 1.2. In the top left corner of the screen press 'Keychain Access' -> 'Certificate Assistant' -> 'Request a Certificate From a Certificate Authority'<br>
 1.3. Enter the email<br>
 1.4. Save the certificate to disk<br>
2. Then you must download another certificate:<br>
  2.1. First go to https://developer.apple.com/account<br>
  2.2. Navigate to: Certificates, Identifiers & Profiles → Certificates<br>
  2.3. Click ➕ → Developer ID Application → Continue<br>
  2.4. Upload the certificate you got from the 'Certificate Assistant'<br>
  2.5. Download the certificate, double click it and make sure it appears in the 'Keychain Access' app on the 'My certificates' tab.<br>
  2.6. Now in Keychain Access, under "My Certificates", you should see something like `Developer ID Application: Mike Tyson (XXXXXXX)`. You need to save that ID in parentheses (XXXXXXX) for later<br>
3. Now create App-specific password on https://account.apple.com/account/manage , save the name you give (for example "codesign") and the password you get<br>
4. Run this command to save the credentials for the Apple Notary Service:<br>
```
xcrun notarytool store-credentials "codesign" \
  --apple-id "miketyson@gmail.com" \
  --team-id "XXXXXXX" \
  --password "russ-ians-shou-lddi"
```
Of course don't forget to replace the "codesign" App-specific password name with yours you set in step 3, the Apple ID with yours, team ID with the one received in step 2.6 and the App-specific password you got from Apple in step 3.<br>
5. Sign the binary with the certificate you just downloaded from the Apple Developer website by this command `codesign --timestamp --options runtime --sign "XXXXXXX" change-language`. Don't forget to rerplace the "XXXXXXX" with the ID saved in step 2.6. I got no output from this command, so don't freak out if you don't get it as well<br>
6. Create zip archive of the signed app like this: `zip -r change-language.zip change-language`<br>
7. Send the archive to Apple Notary Service with this command:<br>
```
xcrun notarytool submit change-language.zip --keychain-profile "codesign" --wait
```
replacing the keychain-profile name with yours (in case you have it different from mine).<br>
8. Now you should see something like "Accepted". If you did, congratulations, just send your archive to your friends.<br>

If it's not signed, anyone who downloads it from the internet to their mac are going to see this bullshit:<br>
<img width="260" alt="image" src="https://github.com/user-attachments/assets/b059177f-61da-4525-af27-fae2508c65b8" /><br>
It [can be fixed without having to sign the binary](https://youtu.be/biIvAM94b98?si=C39_yPQ5SUgS-41B) on a recepient's macOS (whoever downloads it from the internet, but it's much better if it is.

Did you find this tool useful? As of April 30 2025, the day I'm writing this README, I'm desparately looking for a job as an Apple Developer. Please feel free to recommend me to anyone who might be interested ❤️
