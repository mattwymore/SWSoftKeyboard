#SWSoftKeyboard

A drop-in framework that enables your Mac app to show an on-screen keyboard. Provides framework for easily adding new keyboard layouts and custom keys.

**Note:** This framework is for an NSWindow-based application, not an NSDocument-based one. It is also a work in progress. Want to help out? Drop me a line at [@spilliams](https://twitter.com/spilliams) or [s@spencerenglish.com](mailto:s@spencerenglish.com).

Included in this codebase:

- "SWSoftKeyboard" contains the framework implementing a soft keyboard, as well as an "email address" keyboard layout (see below)
- "Demos" contains demonstrations of the framework
- "Documentation" contains compiled documentation via [appledoc](http://gentlebytes.com/appledoc/), in an unknown state of outdatedness.

##Installation

For now this library is only installable statically.

1. Download this repository and place it in a subdirectory of your project. (or perhaps [submodule](http://git-scm.com/docs/git-submodule) it).
1. Drag `SWSoftKeyboard.xcodeproj` into your file navigator in Xcode. You may have to add it to your build target's Target Dependencies, Link Binary With Libraries and Header Search Paths.
1. in your app target's Build Phases tab, in the Target Dependencies section click the "+" button to add a dependency. Select SWSoftKeyboard
1. in your app target's Build Phases tab, in the Link Binary With Libraries section click the "+" button to add a library. Select SWSoftKeyboard.framework
1. in your app's code, you can now `#import <SWSoftKeyboard/SWSoftKeyboard.h>`

##Usage

The demo app SWSoftKeyboardDemo shows how to use the soft keyboard in a Mac 10.9 app.

1. Import the header and set up a property in your view controller to reference the keyboard

        @property (nonatomic, strong) SWSoftKeyboard *keyboard;
2. In `viewDidLoad` or a similar method in your view controller's implementation, initialize the keyboard. Then set your view controller to be the keyboard's delegate (and add `SWSoftKeyboardDelegate` to the interface definition's list of protocols)

        self.keyboard = [[SWSoftKeyboard alloc] initWithLayout:[SWSoftKeyboardEmailAddressLayout new]];
        self.keyboard.delegate = self;
3. Change all applicable TextFields to `SWTextField`, and assign your view controller to be the `firstResponderDelegate` of the text field (your view controller interface definition will want to have `SWTextFieldFirstResponderDelegate` in its list of protocols)
4. In order to trigger the keyboard to display, implement the `SWTextFieldFirstResponderDelegate` method `-textField:didBecomeFirstResponder:`:

        - (void)textField:(NSTextField *)textField didBecomeFirstResponder:(BOOL)success {
            [self.keyboard showSoftKeyboardAnimated:YES];
        }
5. In order to get the keyboard to dismiss, implement the `SWSoftKeyboardDelegate` method `-softKeyboardReadyToExit`:

        -(void)softKeyboardReadyToExit:(SWSoftKeyboard *)keyboard {
            [self.keyboard hideSoftKeyboardAnimated:YES];
            // resignFirstResponder does not function so you need to resign with this:
            AppDelegate *appDelegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];
            [appDelegate.window makeFirstResponder:nil];
        }

You may want to do more customizing of the layout, or set the VC up to be the layout's `layoutDelegate`.

##On Keyboard Layouts

Since this product is intended for touch screens, I started the process by emulating iOS's on-screen keyboards. These layouts have a state that determines what keys are presented, where those keys present within the keyboard, what labels those keys show, and what values those keys send.

A keyboard layout contains three types of keys: content keys, control keys and layout keys.

**Content keys** are your basic letter, number and punctuation keys. When a content key is pressed, the keyboard notifies its delegates of the new content. Delete is considered a content key, since deleting a character is actually [Unicode character 127](http://unicode-table.com/en/#007F). Enter is considered a content key as well ("newline").

**Control keys** are more varied in their function. These are keys like control, alt/option, shift, command. Done is a control key that will tell the keyboard to dismiss.

Some of the control keys may be "sticky". That is, clicking on one will toggle it between on and off, as opposed to a momentary press. Likely candidates for sticky keys include fn, Ctrl, Alt and Cmd. It's up to your layout to set these keys as sticky. All sticky keys initialize with a "sticky state" of Up (unpressed).

**This framework currently does not handle pressing more than one key at a time, so control keys should definitely be sticky!**

**Layout keys** are for telling the keyboard which layout it is to show. For instance, iOS keyboards commonly have a layout key to switch the keyboard layout from alphabetical to numeric, to punctuational.

Since the application I'm building this framework for uses email addresses, I'll continue by describing an email address layout, which is included in Classes/Keyboard Layouts.

It contains the basic alphabet, space key, convenience keys for "@" and ".com", and access to numerals and punctiation through another layout state. There is a Done key which dismisses the keyboard and resigns first responder of the text field. There is a delete (backspace) key. There's a shift key to control letter case. The layout itself has two states: "alphabet" (1) and "numeral" (2). It returns the same set of keys for each state (since pressing shift doesn't add or remove keys from the keyboard). When the sticky shift key is toggled, the keys' labels will update through the keyboard's display lifecycle. Any letter keys pressed will send values based on the keyboard's layout state.

##Development

I'm currently developing this with Xcode 6 beta 6, running on Yosemite Beta Version 2. The framework is intended to be used in OS X 10.10+ applications.

###TODO

- podify it
- example usage

##License

This is free and unencumbered software released into the public domain.

For more information, please refer to LICENSE file or <http://unlicense.org/>
