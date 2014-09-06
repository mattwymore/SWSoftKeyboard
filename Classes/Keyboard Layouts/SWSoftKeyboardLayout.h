//
//  SWSoftKeyboardLayout.h
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
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
 
 Like `keys`, states should be defined in subclasses of this class.  
 Keyboards are initialized with a layout state of 0.  
 State descriptions may be handled internally to subclasses of this class.
 @return The number of possible states of thsi layout.
 */
- (int)layoutStates;

/**
 Returns an array of SWSoftKeyboardKeys based on an array of NSStrings.
 
 Assumes two layout states: 0=shift key unpressed (unstuck), 1=shift key pressed (stuck).  
 Key values will be identical to key labels.
 Key values and labels will not change between key sticky states.
 */
- (NSArray *)simpleKeysFromKeyboardShiftDownCharacters:(NSArray *)keyboardShiftDownCharacters
                             keyboardShiftUpCharacters:(NSArray *)keyboardShiftUpCharacters;
/**
 Returns common alphabet keys, in QWERTY order.
 

 @return Common alphabet keys in QWERTY order.
 */
- (NSArray *)commonAlphabetKeys;
@end
