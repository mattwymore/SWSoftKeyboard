//
//  SWSoftKeyboardProtocols.h
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/10/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#ifndef SWSoftKeyboard_SWSoftKeyboardProtocols_h
#define SWSoftKeyboard_SWSoftKeyboardProtocols_h

@class SWSoftKeyboard;
@class SWSoftKeyboardKeyCell;






/// The keyboard's delegate
@protocol SWSoftKeyboardDelegate <NSObject>
/// Triggered when the user has finished using the keyboard,
/// and it needs to be visually dismissed.
/// @param keyboard The keyboard that's ready to exit
- (void)softKeyboardReadyToExit:(SWSoftKeyboard *)keyboard;
@end








/// Objects that implement this protocol may choose to respond to key events.
@protocol SWKeyDelegate <NSObject>
/// Notifies the delegate that a key has been toggled on or off
/// @param key The key.
- (void)softKeyboardKeyToggled:(SWSoftKeyboardKeyCell *)key;
/// Notifies the delegate that the key has been pressed
/// @param key The key
- (void)softKeyboardKeyPressed:(SWSoftKeyboardKeyCell *)key;
@end








/// Objects that implement this protocol must provide details about how the layout looks and acts.
@protocol SWSoftKeyboardLayout <NSObject>
@required
/// The delegate to pass to each of the keys
@property (nonatomic, weak) id<SWKeyDelegate> keyDelegate;

/// @name Subclasses should override these

/**
 The keys of this layout.
 
 In this class this returns an empty array, but subclasses of this class should return filled arrays of SWSoftKeys.
 @param layoutState The state of the layout
 @return The keys in a particular state of this layout
 */
- (NSArray *)keysForState:(int)layoutState;
/**
 The keyboard's frame for a specific layout state.
 
 @param layoutState The layout state
 @return The keyboard's frame
 */
- (NSRect)keyboardFrameForState:(int)layoutState;
/**
 The number of possible states of this layout.
 
 Like `keys`, this should be defined in subclasses of this class.
 Keyboards are initialized with a layout state of 0.
 State descriptions may be handled internally to subclasses of this class.
 
 Note that the layout should probably only make one of each kind of key. That is,
 there should only be one 'Q' key between the "keyboard shift down" and "keyboard shift up"
 states. Also note that the Q key returned by this method may have a dirty label/value,
 So the keyboard should **also** update its individual keys.
 
 I guess you can think of this method as "what's the forest?" and when the keyboard has
 the "forest" then it still has to update each "tree". Perhaps not the most efficient,
 but I'm on a timeline here folks.
 
 @return The number of possible states of thsi layout.
 */
- (int)layoutStates;

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
