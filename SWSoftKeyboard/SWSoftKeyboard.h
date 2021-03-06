//
//  SWSoftKeyboard.h
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  This is free and unencumbered software released into the public domain.
//

#import <Cocoa/Cocoa.h>
#import "SWSoftKeyboardProtocols.h"
#import "SWSoftKeyboardLayoutHelper.h"
#import "SWSoftKeyboardLayout.h"
#import "SWSoftKeyboardEmailAddressLayout.h"
#import "SWSoftKeyboardKeyCell.h"
#import "SWTextField.h"


/// The keyboard's delegate
@protocol SWSoftKeyboardDelegate <NSObject>
/// Triggered when the user has finished using the keyboard,
/// and it needs to be visually dismissed.
/// @param keyboard The keyboard that's ready to exit
- (void)softKeyboardReadyToExit:(SWSoftKeyboard *)keyboard;
@end

/// A soft keyboard! handles the key presses, shift/sticky state
@interface SWSoftKeyboard : NSControl <SWKeyDelegate>
/// The keyboard's delegate.
@property (nonatomic, weak) id<SWSoftKeyboardDelegate>delegate;
/// The keyboard's layout.
@property (nonatomic, strong) SWSoftKeyboardLayout *keyboardLayout;
/// The keyboard's layout state. Initializes as 0.
@property (nonatomic, assign) int layoutState;
/// The keyboard's keys
@property (nonatomic, strong) NSArray *keys;
/// The active textfield that the keyboard will be manipulating
@property (nonatomic, strong) NSControl *activeTextEntryControl;

@property (nonatomic, assign) BOOL keyboardShowing;

/// Initializes a new keyboard with a particular layout
/// @param keyboardLayout The layout.
- (id)initWithLayout:(SWSoftKeyboardLayout *)keyboardLayout;

- (void)showSoftKeyboardAnimated:(BOOL)animated;
- (void)hideSoftKeyboardAnimated:(BOOL)animated;
@end
