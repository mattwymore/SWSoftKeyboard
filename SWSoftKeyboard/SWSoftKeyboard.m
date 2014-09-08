//
//  SWSoftKeyboard.m
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  This is free and unencumbered software released into the public domain.
//

#import "SWSoftKeyboard.h"
#import "SWSoftKeyboardLayout.h"
#import "SWSoftKeyboardKey.h"

@implementation SWSoftKeyboard

- (id)initWithLayout:(SWSoftKeyboardLayout *)keyboardLayout
{
    if (self = [super init]) {
        self.keyboardLayout = keyboardLayout;
    }
    return self;
}

- (void)setKeyboardLayout:(SWSoftKeyboardLayout *)keyboardLayout
{
    _keyboardLayout = keyboardLayout;
    [self.keyboardLayout setKeyDelegate:self];
    self.layoutState = 0;
    self.needsDisplay = YES;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
