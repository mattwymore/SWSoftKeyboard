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
        [self.firstResponderDelegate respondsToSelector:@selector(controlWillBecomeFirstResponder:)]) {
        [self.firstResponderDelegate controlWillBecomeFirstResponder:self];
    }
    BOOL didBecomeFirstResponder = [super becomeFirstResponder];
    if (didBecomeFirstResponder) {
        if (self.firstResponderDelegate &&
            [self.firstResponderDelegate respondsToSelector:@selector(controlDidBecomeFirstResponder:)]) {
            [self.firstResponderDelegate controlDidBecomeFirstResponder:self];
        }
    } else {
        if (self.firstResponderDelegate &&
            [self.firstResponderDelegate respondsToSelector:@selector(controlFailedToBecomeFirstResponder:)]) {
            [self.firstResponderDelegate controlFailedToBecomeFirstResponder:self];
        }
    }
    return didBecomeFirstResponder;
}
- (BOOL)resignFirstResponder
{
    if (self.firstResponderDelegate &&
        [self.firstResponderDelegate respondsToSelector:@selector(controlWillResignFirstResponder:)]) {
        [self.firstResponderDelegate controlWillResignFirstResponder:self];
    }
    BOOL didResignFirstResponder = [super resignFirstResponder];
    if (didResignFirstResponder) {
        if (self.firstResponderDelegate &&
            [self.firstResponderDelegate respondsToSelector:@selector(controlDidResignFirstResponder:)]) {
            [self.firstResponderDelegate controlDidResignFirstResponder:self];
        }
    } else {
        if (self.firstResponderDelegate &&
            [self.firstResponderDelegate respondsToSelector:@selector(controlFailedToResignFirstResponder:)]) {
            [self.firstResponderDelegate controlFailedToResignFirstResponder:self];
        }
    }
    return didResignFirstResponder;
}
@end
