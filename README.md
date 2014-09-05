#SWSoftKeyboard

A drop-in library that enables your Mac app to show an on-screen keyboard.

**Note: I'm currently working on the first version of this library, so it doesn't actually do anything yet!** Want to help out? Drop me a line at [@spilliams](https://twitter.com/spilliams) or [s@spencerenglish.com](mailto:s@spencerenglish.com).

Provides framework for easily adding new keyboard layouts and custom keys.

This keyboard does *not* fire actual key press events, so the operating system will *not* respond to key presses like Cmd-Q etc.
Instead, this keyboard updates its given set of NSTextFields with new values directly.

Included in this codebase:

- "Classes" contains the library implementing a soft keyboard, as well as an "email address" keyboard layout (see below)
- "Documentation" contains compiled documentation via [appledoc](http://gentlebytes.com/appledoc/)

##On Keyboard Layouts

Since this product is intended for touch screens, I started the process by emulating iOS's on-screen keyboards. These layouts have a state that determines what keys are presented, where those keys present within the keyboard, what labels those keys show, and what values those keys send.

A keyboard layout contains two types of keys: content keys and control keys. Content keys are your basic letter, number and punctuation keys. When a content key is pressed, the keyboard notifies its delegates of the new content. Control keys are more varied in their function. These are keys like control, alt/option, shift, command. Delete is considered a control key, since deleting a character isn't really new content. Enter is actually considered twice: once as content (ex: "insert newline") and once as control (ex: "dismiss keyboard, resign first responder"). It's up to your layout to implement one or both of these functions.

Some of the control keys may be "sticky". That is, clicking on one will toggle it between on and off, as opposed to a momentary press. Likely candidates for sticky keys include fn, Ctrl, Alt and Cmd. It's up to your layout to set these keys as sticky. All sticky keys initialize with a "sticky state" of Up (unpressed).

**This library currently does not handle pressing more than one key at a time, so control keys should definitely be sticky!**

Since the application I'm building this library for uses email addresses, I'll continue by describing an email address layout, which is included in Classes/Keyboard Layouts.

It contains the basic 36 alphanumerics, as well as common email address punctuation (@, -, _, . etc.). There is a return key which dismisses the keyboard and resigns first responder of the text field. There is a backspace key but no space key. There's a shift key to control letter case.

##License

This is free and unencumbered software released into the public domain.

For more information, please refer to LICENSE file or <http://unlicense.org/>
