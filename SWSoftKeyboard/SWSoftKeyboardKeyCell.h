//
//  SWSoftKeyboardKey.h
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  This is free and unencumbered software released into the public domain.
//

#import <Cocoa/Cocoa.h>

typedef enum {
    SKKeyTypeContent,
    SKKeyTypeControl,
    SKKeyTypeLayout
} SKKeyType;

typedef enum {
    SKControlTypeNone,
    SKControlTypeShift,
    SKControlTypeBackspace,
    SKControlTypeDelete,
    SKControlTypeFn,
    SKControlTypeCtrl,
    SKControlTypeAlt,
    SKControlTypeDone,
    SKControlTypeNext
    // no Cmd type because I don't want to steal Apple's thunder.
} SKControlType;

@class SWSoftKeyboardKeyCell;

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






/**
 A SWSoftKeyboardKeyCell is an NSButtonCell that belongs to an SWSoftKeyboard.
 
 It contains dictionaries that describe how the button should look and what value
 it represents for different keyboard states as well as for different selected states.
 
 A key is one of three types: "content", "control" or "layout".
 
 A key may be momentary (default) or "sticky". Sticky keys toggle between selected and
 unselected. This attribute is derived, however. Currently only Control keys are sticky.
 
 - **Content**: for example: letter keys, number keys, punctuation keys. Touching these keys represents adding content to the current text field.
 - **Control**: for example: "fn", "ctrl", "alt/option", "cmd". Touching these keys represents changing the labels and values of (content) keys on the keyboard.
 - **Layout**: These keys are a bit more abstract. There's no hardware equivalent, but on something like an iPhone keyboard, a key designed to switch the keyboard between QWERTY layout and numpad layout would be a "layout" key.
 */
@interface SWSoftKeyboardKeyCell : NSButtonCell
/// The delegate to receive messages about this key
@property (nonatomic, weak) id<SWKeyDelegate>keyDelegate;
/// Whether or not this key is selected
@property (nonatomic, assign) BOOL isSelected;
/// The type of key.
@property (nonatomic, assign) SKKeyType keyType;
/// The control type this key holds (if its `keyType` is SKKeyTypeControl)
@property (nonatomic, assign) SKControlType controlType;

/**
 The labels this key uses for certain keyboard/selected states.

 State dictionaries are stored such that the first dictionary key is the keyboard
 key's selected state, and the second dictionary key is the keyboard's layout state.
 */
@property (nonatomic, strong) NSDictionary *stateLabels;
/// The values this key sends in certain keyboard/selected states
/// @see stateLabels
@property (nonatomic, strong) NSDictionary *stateValues;

/**
 Initializes a new key with particular attributes
 @param frame       The key's frame
 @param stateLabels A dictionary of labels corresponding to specific keyboard/selected states
 @param stateValues A dictionary of values corresponding to specific keyboard/selected states
 @param keyType     The type of key
 @param controlType The type of control the key holds (if it's a control key)
 @param keyDelegate The key's delegate
 */
- (id)initWithFrame:(NSRect)frame
        stateLabels:(NSDictionary *)stateLabels
        stateValues:(NSDictionary *)stateValues
            keyType:(SKKeyType)keyType
        controlType:(SKControlType)controlType
     keyDelegate:(id<SWKeyDelegate>)keyDelegate;
/**
 Returns the label for a particular keyboard state, taking into account the key's selected state
 @param keyboardState The keyboard's layout state
 @see stateLabels
 @return The cell's view
 */
- (NSView *)labelForKeyboardState:(int)keyboardState;
/**
 Returns the key's value for a particular keyboard state and key selected state.
 @param keyboardState The keyboard's layout state
 @see stateLabels
 @return the key value
 */
- (NSString *)valueForKeyboardState:(int)keyboardState;
/**
 Updates the cell's look to match a keyboard state and the key's selected state.
 @param keyboardState The keyboard's layout state
 */
- (void)updateForKeyboardState:(int)keyboardState;
@end
