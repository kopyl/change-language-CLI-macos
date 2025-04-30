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
