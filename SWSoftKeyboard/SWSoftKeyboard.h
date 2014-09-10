//
//  SWSoftKeyboard.h
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  This is free and unencumbered software released into the public domain.
//

#import <Cocoa/Cocoa.h>

#import "SWSoftKeyboardProtocols.h"

/// A soft keyboard! handles the key presses, shift/sticky state
@interface SWSoftKeyboard : NSControl <SWKeyDelegate>
/// The keyboard's delegate.
@property (nonatomic, weak) id<SWSoftKeyboardDelegate>delegate;
/// The keyboard's layout.
@property (nonatomic, weak) id<SWSoftKeyboardLayout> keyboardLayout;
/// The keyboard's layout state. Initializes as 0.
@property (nonatomic, assign) int layoutState;
/// The keyboard's keys
@property (nonatomic, strong) NSArray *keys;
/// Initializes a new keyboard with a particular layout
/// @param keyboardLayout The layout.
- (id)initWithLayout:(id<SWSoftKeyboardLayout>)keyboardLayout;
@end
