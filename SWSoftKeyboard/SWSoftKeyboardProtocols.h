//
//  SWSoftKeyboardProtocols.h
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/10/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#ifndef SWSoftKeyboard_SWSoftKeyboardProtocols_h
#define SWSoftKeyboard_SWSoftKeyboardProtocols_h

#import <Cocoa/Cocoa.h>

@class SWSoftKeyboard;
@class SWSoftKeyboardLayout;
@class SWSoftKeyboardKeyCell;















/// Objects that implement this protocol may choose to respond to key events.
@protocol SWKeyDelegate <NSObject>
/// Notifies the delegate that a key has been toggled on or off
/// @param key The key.
- (void)softKeyboardKeyToggled:(SWSoftKeyboardKeyCell *)key;
/// Notifies the delegate that the key has been pressed
/// @param key The key
- (void)softKeyboardKeyPressed:(SWSoftKeyboardKeyCell *)key;
@end







/// Objects that implement this protocol may choose to act on first responder events
@protocol SWTextFieldFirstResponderDelegate <NSObject>
@optional
/// Fires when a text field will become a first responder
/// @param textField The text field
- (void)textFieldWillBecomeFirstResponder:(NSTextField *)textField;
/// Fires when a text field has become a first responder
/// @param textField    The text field
/// @param success      Whether or not the becoming succeeded
- (void)textField:(NSTextField *)textField didBecomeFirstResponder:(BOOL)success;

/// Fires when a text field will resign first responder
/// @param textField The text field
- (void)textFieldWillResignFirstResponder:(NSTextField *)textField;
/// Fires when a text field has resigned first responder
/// @param textField    The text field
/// @param success      Whether or not the resignation succeeded
- (void)textField:(NSTextField *)textField didResignFirstResponder:(BOOL)success;
@end


#endif
