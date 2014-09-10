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


/**
 Objects that inherit this protocol may choose to respond to key events.
 */
@protocol SWKeyDelegate <NSObject>
/**
 Notifies the delegate that a key has been toggled on or off
 @param key The key.
 */
- (void)softKeyboardKeyToggled:(SWSoftKeyboardKeyCell *)key;
/**
 Notifies the delegate that the key has been pressed
 @param key The key
 */
- (void)softKeyboardKeyPressed:(SWSoftKeyboardKeyCell *)key;
@end

#endif
