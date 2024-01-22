TInputComp is a component for Lazarus on Linux to capture input events.
You can capture all events with unusual hardware, especially if the key codes are above 255.

This component only works with Lazarus and Linux (not Windows), but does not provide general access to other programs running under X.

My goal was to use the Infinity VEC pedal with Lazarus/Linux.
The pedal is recognized well by Linux as a USB device, but the VEC pedal generates the codes 256-258, which cannot be processed by the X server (without further measures such as mapping).
The component is able to read all events listed in /dev/input (as examples: VEC pedal, simple game controller and jog-dial Contour Shuttle Pro V2).
Mouse and keyboard events could also be captured, but that usually doesn't make sense since they are almost fully supported by XServer and Lazarus.

TnputComp requires read permissions for the suggested event file.
For a quick test, adding the user to the 'input' group is sufficient, but this is strongly discouraged for security reasons.
So it's better to add rules to /etc/udev/rules.d that create read permissions specifically for the event you need.
For security reasons (keylogging), keyboard entries at the event level should never receive read permissions for normal users, unless you know exactly what you are doing!
Examples of rules are attached. You have to adapt these to your own hardware (idVendor and idProduct).

Files:
readdevinput.pas contains the base component “TInputComp”. This will capture all events from the selected device. You need to filter the events yourself in your program by evaluating the 'OnInputEvent' event.
All other components (TInputComp_VEC, TInputComp_CSP, TInputComp_GPS, TInputComp_Mouse) are derived from TInputComp and implement more device-specific events.
The package name is RIEEvent (which means "Read Input Event") and can be installed as usual using the package manager. After recompiling the Lazarus IDE, you will find the components in the RIEvent tab.

Examples:
1. General           (no specific device)
component-name:      TInputComp
component-file:      readdevinput.pas
application example: DemoInputComp/InputCompGeneral.lpr

2. VEC Pedal
link:                https://www.altoedge.com/pedals/vec-infinity-foot-pedals.html
lsusb shows          Bus 001 Device 005: ID 05f3:00ff PI Engineering, Inc. VEC Footpedal
rule:                ACTION=="add|change", KERNEL=="event[0-9]*", ATTRS{idVendor}=="05f3", ATTRS{idProduct}=="00ff",MODE="0664"
component-name:      TInputComp_VEC
component-file:      readdevinput_vecpedal.pas
application example: DemoVECpedal/DemoVecpedal.lpr

3. Contour Shuttle Pro
link:                https://contourdesign.de/products/multimedia-controller-pro
lsusb shows:         Bus 001 Device 003: ID 0b33:0030 Contour Design, Inc. ShuttlePro v2
rule:                ACTION=="add|change", KERNEL=="event[0-9]*", ATTRS{idVendor}=="0b33", ATTRS{idProduct}=="0030",MODE="0664"
component-name:      TInputComp_CSP
component-file:      readdevinput_contourshuttlepro.pas
application example: DemoContourShuttlePro/DemoContourShuttlePro.lpr

4. SNES Gamepad
link:                https://www.joy-it.net/de/products/SBC-Gamepad-SNES
lsusb shows          Bus 001 Device 004: ID 0079:0011 DragonRise Inc. Gamepad
rule:                ACTION=="add|change", KERNEL=="event[0-9]*", ATTRS{idVendor}=="0079", ATTRS{idProduct}=="0011",MODE="0664"
component-name:      TInputComp_GPS
component-file:      readdevinput_gamepadsnes.pas
application example: (none)

5. Mouse             (only to show, how to access, not useful in practice)
lsusb shows          Bus 001 Device 030: ID 046d:c077 Logitech, Inc. M105 Optical Mouse
rule:                ACTION=="add|change", KERNEL=="event[0-9]*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c077",MODE="0664"
component-name:      TInputComp_Mouse
component-file:      readdevinput_Mouse.pas
application example: DemoMouse/DemoMouse.lpr

6. Keyboard          (only to show, how to access, not useful in practice, e.g. you use multiple keyboards or a keypad and you want to know, which device sent the event)
lsusb shows          Bus 001 Device 010: ID 046a:0014 Cherry GmbH Keypad G84-4700
rule:                ACTION=="add|change", KERNEL=="event[0-9]*", ATTRS{idVendor}=="046a", ATTRS{idProduct}=="00147",MODE="0664"
component-name:      TInputComp_Keyboard
component-file:      readdevinput_Keyboard.pas
application example: DemoKeyboard/Demokeyboard.lpr
