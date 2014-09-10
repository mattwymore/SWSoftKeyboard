//
//  SWSoftKeyboardLayoutHelper.h
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/10/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Contains methods to help out soft keyboard layouts
@interface SWSoftKeyboardLayoutHelper : NSObject
/**
 Returns an array of SWSoftKeyboardKeys based on an array of NSStrings.
 
 Assumes two layout states: 0=shift key unpressed (unstuck), 1=shift key pressed (stuck).
 Key values will be identical to key labels.
 Key values and labels will not change between key sticky states.
 @param keyboardShiftUpCharacters   An array of characters corresponding to the "shift key up (unstuck)" layout state
 @param keyboardShiftDownCharacters An array of characters corresponding to the "shift key down (stuck)" layout state
 @return An array of SWSoftKeyboardKeys
 */
+ (NSArray *)simpleKeysFromKeyboardShiftUpCharacters:(NSArray *)keyboardShiftUpCharacters
                         keyboardShiftDownCharacters:(NSArray *)keyboardShiftDownCharacters;
/**
 Returns common alphabet keys, in QWERTY order.
 
 @return Common alphabet keys in QWERTY order.
 */
+ (NSArray *)commonAlphabetKeys;

@end
