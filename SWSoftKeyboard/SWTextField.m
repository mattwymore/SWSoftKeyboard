//
//  SWTextField.m
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/10/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#import "SWTextField.h"

@implementation SWTextField
@synthesize firstResponderDelegate;

- (BOOL)becomeFirstResponder
{
    if (self.firstResponderDelegate &&
        [self.firstResponderDelegate respondsToSelector:@selector(textFieldWillBecomeFirstResponder:)]) {
        [self.firstResponderDelegate textFieldWillBecomeFirstResponder:self];
    }
    BOOL didBecomeFirstResponder = [super becomeFirstResponder];
    if (self.firstResponderDelegate &&
        [self.firstResponderDelegate respondsToSelector:@selector(textField:didBecomeFirstResponder:)]) {
        if (didBecomeFirstResponder) {
            [self.firstResponderDelegate textField:self didBecomeFirstResponder:YES];
        } else {
            [self.firstResponderDelegate textField:self didBecomeFirstResponder:NO];
        }
    }
    return didBecomeFirstResponder;
}
- (BOOL)resignFirstResponder
{
    if (self.firstResponderDelegate &&
        [self.firstResponderDelegate respondsToSelector:@selector(textFieldWillResignFirstResponder:)]) {
        [self.firstResponderDelegate textFieldWillResignFirstResponder:self];
    }
    BOOL didResignFirstResponder = [super resignFirstResponder];
    if (self.firstResponderDelegate &&
        [self.firstResponderDelegate respondsToSelector:@selector(textField:didResignFirstResponder:)]) {
        if (didResignFirstResponder) {
            [self.firstResponderDelegate textField:self didResignFirstResponder:YES];
        } else {
            [self.firstResponderDelegate textField:self didResignFirstResponder:NO];
        }
    }
    return didResignFirstResponder;
}

- (void)keyDown:(NSEvent *)theEvent
{
    NSLog(@"chars: %@ - unmodchars: %@ - keyCode: %hu", theEvent.characters, theEvent.charactersIgnoringModifiers, theEvent.keyCode);
    [super keyDown:theEvent];
}


@end
