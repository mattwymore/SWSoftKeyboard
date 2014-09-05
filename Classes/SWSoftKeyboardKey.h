//
//  SWSoftKeyboardKey.h
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SWSoftKeyboardKey;

typedef enum {
    SWStickyKeyStateUp,
    SWStickyKeyStateDown
} SWStickyKeyState;

/**
 Objects that inherit this protocol may choose to respond to key events.
 */
@protocol SWKeyDelegate <NSObject>
@optional
/**
 Notifies the delegate that a key has been "stuck" in a state
 @param key     The key.
 @param state   The sticky state the key is in.
 */
- (void)softKeyboardKey:(SWSoftKeyboardKey *)key stickiedInState:(SWStickyKeyState)state;
/**
 Notifies the delegate that the key has been pressed
 @param key The key
 */
- (void)softKeyboardKeyPressed:(SWSoftKeyboardKey *)key;
@end






/**
 Instances of SWSoftKeyboardKey represent individual keyboard keys. They contain certain
 state-related variables (`isSticky`, `stateLabels`, `stateValues`) as well as positioning
 values (`frame`).
 */
@interface SWSoftKeyboardKey : NSActionCell
/// The delegate to receive messages about this (sticky) key
@property (nonatomic, weak) id<SWKeyDelegate>keyDelegate;
/// What "sticky state" the key is in
@property (nonatomic, assign) SWStickyKeyState stickyState;
/// Whether or not this key is sticky
@property (nonatomic, assign) BOOL isSticky;

/**
 The labels this key uses for certain keyboard/sticky states.

 State dictionaries are stored such that the first dictionary key is the keyboard key's sticky
 state (whether or not the key is stuck), and the second dictionary key is the keyboard's layout state.
 */
@property (nonatomic, strong) NSDictionary *stateLabels;
/// The values this key sends in certain keyboard/sticky states
/// @see stateLabels
@property (nonatomic, strong) NSDictionary *stateValues;

/**
 Initializes a new key with particular attributes
 @param frame       The key's frame
 @param stateLabels A dictionary of labels corresponding to specific keyboard/sticky states
 @param stateValues A dictionary of values corresponding to specific keyboard/sticky states
 @param isSticky    Whether or not the key is sticky
 @param keyDelegate The key's delegate
 */
- (id)initWithFrame:(NSRect)frame
        stateLabels:(NSDictionary *)stateLabels
        stateValues:(NSDictionary *)stateValues
             sticky:(BOOL)isSticky
     keyDelegate:(id<SWKeyDelegate>)keyDelegate;
/**
 Returns the label for a particular keyboard state, taking into account the key's sticky state
 @param keyboardState The keyboard's layout state
 @see stateLabels
 @return May be an instance of NSString or NSImage
 */
- (id)labelForKeyboardState:(int)keyboardState;
/**
 Returns the key's value for a particular keyboard state and key sticky state.
 @param keyboardState The keyboard's layout state
 @see stateLabels
 @return the key value
 */
- (NSString *)valueForKeyboardState:(int)keyboardState;
@end
