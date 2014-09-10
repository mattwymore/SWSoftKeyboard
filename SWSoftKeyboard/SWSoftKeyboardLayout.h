//
//  SWSoftKeyboardLayout.h
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  This is free and unencumbered software released into the public domain.
//

#import <Foundation/Foundation.h>

@protocol SWKeyDelegate;

/// An interface that describes how to interact with a keyboard layout
@interface SWSoftKeyboardLayout : NSObject
/// The delegate to pass to each of the keys
@property (nonatomic, weak) id<SWKeyDelegate> keyDelegate;
/**
 The keys of this layout.
 
 In this class this returns an empty array, but subclasses of this class should return filled arrays of SWSoftKeys.
 @param layoutState The state of the layout
 @return The keys in a particular state of this layout
 */
- (NSArray *)keysForState:(int)layoutState;
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

/**
 Returns an array of SWSoftKeyboardKeys based on an array of NSStrings.
 
 Assumes two layout states: 0=shift key unpressed (unstuck), 1=shift key pressed (stuck).  
 Key values will be identical to key labels.
 Key values and labels will not change between key sticky states.
 @param keyboardShiftUpCharacters   An array of characters corresponding to the "shift key up (unstuck)" layout state
 @param keyboardShiftDownCharacters An array of characters corresponding to the "shift key down (stuck)" layout state
 @return An array of SWSoftKeyboardKeys
 */
- (NSArray *)simpleKeysFromKeyboardShiftUpCharacters:(NSArray *)keyboardShiftUpCharacters
                         keyboardShiftDownCharacters:(NSArray *)keyboardShiftDownCharacters;
/**
 Returns common alphabet keys, in QWERTY order.
 
 @return Common alphabet keys in QWERTY order.
 */
- (NSArray *)commonAlphabetKeys;

@end
