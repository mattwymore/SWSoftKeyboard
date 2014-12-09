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
- (id)initWithLayout:(SWSoftKeyboardLayout *)keyboardLayout
{
    if (self = [super init]) {
        self.keyboardLayout = keyboardLayout;
        self.wantsLayer = YES;
    }
    return self;
}

- (void)setKeyboardLayout:(SWSoftKeyboardLayout *)keyboardLayout
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
    [self setFrame:[self.keyboardLayout keyboardFrameForState:layoutState]];
    [self setKeys:[self.keyboardLayout keysForState:layoutState]];
    for (SWSoftKeyboardKeyCell *key in self.keys) {
        key.keyDelegate = self;
        [self addSubview:key];
    }
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
    [[NSColor colorWithCalibratedWhite:0.7 alpha:0.9] set];
    NSRectFill(self.bounds);
    
}

#pragma mark - SWKeyDelegate Protocol

- (void)softKeyboardKeyPressed:(SWSoftKeyboardKeyCell *)key
{
    NSWindow *activeWindow = [[NSApplication sharedApplication] mainWindow];
    if (key.keyType == SKKeyTypeContent) {
        if (key.controlType == SKControlTypeBackspace) {
            NSEvent *keyDownEvent = [NSEvent keyEventWithType:NSKeyDown location:CGPointMake(0, 0) modifierFlags:0x100 timestamp:[[NSProcessInfo processInfo] systemUptime] windowNumber:[activeWindow windowNumber] context:nil characters:[key valueForKey] charactersIgnoringModifiers:[key valueForKey] isARepeat:NO keyCode:[key.keyCode unsignedShortValue]];
            
            [NSApp sendEvent:keyDownEvent];
        }else{
            NSEvent *keyDownEvent = [NSEvent keyEventWithType:NSKeyDown location:CGPointMake(0, 0) modifierFlags:0 timestamp:[[NSProcessInfo processInfo] systemUptime] windowNumber:[activeWindow windowNumber] context:[NSGraphicsContext graphicsContextWithWindow:activeWindow] characters:[key valueForKey] charactersIgnoringModifiers:[key valueForKey] isARepeat:NO keyCode:[key.keyCode unsignedShortValue]];
            
            [NSApp sendEvent:keyDownEvent];
            
        }
    }else if (key.keyType == SKKeyTypeLayout){
        for (SWSoftKeyboardKeyCell *key in self.keys) {
            [key removeFromSuperview];
        }
        if (key.controlType == SKControlTypeNumeric) {
            self.layoutState = 1;
        }else{
            self.layoutState = 0;
        }
        
    }
    
}
- (void)softKeyboardKeyToggled:(SWSoftKeyboardKeyCell *)key
{
    if (key.controlType == SKControlTypeShift) {
        for (SWSoftKeyboardKeyCell *contentKey in self.keys) {
            [contentKey setShifted:key.isSelected];
        }
    }else if (key.controlType == SKControlTypeDone){
        if (self.delegate && [self.delegate respondsToSelector:@selector(softKeyboardReadyToExit:)]) {
            [self.delegate softKeyboardReadyToExit:self];
        }
    }
}

#pragma mark - show/hide
- (void)showSoftKeyboardAnimated:(BOOL)animated
{
    if (self.keyboardShowing) return;
    for (SWSoftKeyboardKeyCell *key in self.keys) {
        [key removeFromSuperview];
    }
    [self.keyboardLayout emptyExistingKeys];
    self.layoutState = 0;
    
    NSWindow *activeWindow = nil;
    if ([NSApp keyWindow]) {
        activeWindow = [NSApp keyWindow];
    }else if ([NSApp mainWindow]){
        activeWindow = [NSApp mainWindow];
    }else{
        activeWindow = [NSApp windows][0];
    }
    
    
    NSRect oldFrame = NSMakeRect(self.frame.origin.x,
                                 -1*self.frame.size.height,
                                 self.frame.size.width,
                                 self.frame.size.height);
    [self setFrame:oldFrame];
    if (!self.superview) {
        [activeWindow.contentView addSubview:self];
    }
    NSRect newFrame = NSMakeRect(oldFrame.origin.x,
                                 0,
                                 oldFrame.size.width,
                                 oldFrame.size.height);
    if (animated) {
        [[self animator] setFrame:newFrame];
    } else {
        [self setFrame:newFrame];
    }
    self.keyboardShowing = YES;
}
- (void)hideSoftKeyboardAnimated:(BOOL)animated
{
    if (!self.keyboardShowing) return;
    if (animated) {
        [NSAnimationContext currentContext].completionHandler =^{
            [self removeFromSuperview];
            self.keyboardShowing = NO;
        };
        NSRect newFrame = NSMakeRect(self.frame.origin.x, -1*self.frame.size.height, self.frame.size.width, self.frame.size.height);
        [[self animator] setFrame:newFrame];
    } else {
        [self removeFromSuperview];
        self.keyboardShowing = NO;
    }
}

- (void)mouseDown:(NSEvent *)theEvent {
    //trap the clicking so items under the keybaord do not recieve the event.
}

@end
