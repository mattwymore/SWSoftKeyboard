//
//  SWSoftKeyboard.h
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SWSoftKeyboardLayout.h"


@class SWSoftKeyboard;
/// The keyboard's delegate
@protocol SWSoftKeyboardDelegate <NSObject>
/// Triggered when the user has finished using the keyboard,
/// and it needs to be visually dismissed.
/// @param keyboard The keyboard that's ready to exit
- (void)softKeyboardReadyToExit:(SWSoftKeyboard *)keyboard;
@end

@protocol SWKeyDelegate;

/// A soft keyboard! handles the key presses, shift/sticky state
@interface SWSoftKeyboard : NSControl <SWKeyDelegate>
/// The keyboard's delegate.
@property (nonatomic, weak) id<SWSoftKeyboardDelegate>delegate;
/// The keyboard's layout.
@property (nonatomic, strong) SWSoftKeyboardLayout *keyboardLayout;
/// The keyboard's layout state. Initializes as 0.
@property (nonatomic, assign) int layoutState;
/// Initializes a new keyboard with a particular layout
/// @param keyboardLayout The layout.
- (id)initWithLayout:(SWSoftKeyboardLayout *)keyboardLayout;
@end
