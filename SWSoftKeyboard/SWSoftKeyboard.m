//
//  SWSoftKeyboard.m
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  This is free and unencumbered software released into the public domain.
//

#import "SWSoftKeyboard.h"
#import "SWSoftKeyboardKeyCell.h"

@implementation SWSoftKeyboard

- (id)initWithFrame:(NSRect)frameRect
{
    if (self = [super initWithFrame:frameRect]) {
        [self commonInit];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self commonInit];
    }
    return self;
}
- (id)initWithLayout:(id<SWSoftKeyboardLayout>)keyboardLayout
{
    if (self = [super init]) {
        self.keyboardLayout = keyboardLayout;
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    
}

- (void)setKeyboardLayout:(id<SWSoftKeyboardLayout>)keyboardLayout
{
    _keyboardLayout = keyboardLayout;
    [self.keyboardLayout setKeyDelegate:self];
    self.layoutState = 0; // triggers needsDisplay, so we don't need to do that here explicitly
}

- (void)setLayoutState:(int)layoutState
{
    if (layoutState < 0 ||
        layoutState > self.keyboardLayout.layoutStates) {
        NSLog(@"SWSoftKeyboard tried to enter invalid layout state %i",layoutState);
        return;
    }
    _layoutState = layoutState;
    [self setKeys:[self.keyboardLayout keysForState:layoutState]];
    self.needsDisplay = YES;
}

- (void)setKeys:(NSArray *)keys
{
    _keys = keys;
    for (SWSoftKeyboardKeyCell *key in self.keys) {
        [key updateForKeyboardState:self.layoutState];
    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

#pragma mark - SWKeyDelegate Protocol

- (void)softKeyboardKeyPressed:(SWSoftKeyboardKeyCell *)key
{
    
}
- (void)softKeyboardKeyToggled:(SWSoftKeyboardKeyCell *)key
{
    
}

@end
