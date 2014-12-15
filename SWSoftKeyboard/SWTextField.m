//
//  SWTextField.m
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/10/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#import "SWTextField.h"

#define LOG YES

@interface SWTextField () {
    BOOL suppressInformingDelegate;
}

@end

@implementation SWTextField
@synthesize firstResponderDelegate;

- (BOOL)becomeFirstResponder
{
    if (LOG) NSLog(@"[SWTF] become first responder");
    
    BOOL informDelegate = !suppressInformingDelegate;
    suppressInformingDelegate = YES;
    
    if (informDelegate &&
        self.firstResponderDelegate &&
        [self.firstResponderDelegate respondsToSelector:@selector(textFieldWillBecomeFirstResponder:)]) {
        if (LOG) NSLog(@"  inform delegate of will become");
        [self.firstResponderDelegate textFieldWillBecomeFirstResponder:self];
    }
    
    if (LOG) NSLog(@"  super...");
    BOOL didBecomeFirstResponder = [super becomeFirstResponder];
    
    if (informDelegate &&
        self.firstResponderDelegate &&
        [self.firstResponderDelegate respondsToSelector:@selector(textField:didBecomeFirstResponder:)]) {
        if (LOG) NSLog(@"  inform delegate of did become (%@)", didBecomeFirstResponder ? @"yes" : @"no");
        [self.firstResponderDelegate textField:self didBecomeFirstResponder:didBecomeFirstResponder];
    }
    
    // if suppress was YES before, and we didn't inform the delegate, suppress remains at YES
    // if suppress was NO before, and we did inform the delegate, suppress is NO again
    suppressInformingDelegate = !informDelegate;
    
    return didBecomeFirstResponder;
}
- (BOOL)resignFirstResponder
{
    if (LOG) NSLog(@"[SWTF] resign first responder");
    
    BOOL informDelegate = !suppressInformingDelegate;
    suppressInformingDelegate = YES;
    
    if (informDelegate &&
        self.firstResponderDelegate &&
        [self.firstResponderDelegate respondsToSelector:@selector(textFieldWillResignFirstResponder:)]) {
        if (LOG) NSLog(@"  inform delegate of will resign");
        [self.firstResponderDelegate textFieldWillResignFirstResponder:self];
    }
    
    if (LOG) NSLog(@"  super...");
    BOOL didResignFirstResponder = [super resignFirstResponder];
    
    //resignFirstResponder does not function so you need to resign with this:
//    [self.windowResponder makeFirstResponder:nil];
    
    if (informDelegate &&
        self.firstResponderDelegate &&
        [self.firstResponderDelegate respondsToSelector:@selector(textField:didResignFirstResponder:)]) {
        if (LOG) NSLog(@"  inform delegate of did resign (%@)", didResignFirstResponder ? @"yes" : @"no");
        [self.firstResponderDelegate textField:self didResignFirstResponder:didResignFirstResponder];
    }
    
    // if suppress was YES before, and we didn't inform the delegate, suppress remains at YES
    // if suppress was NO before, and we did inform the delegate, suppress is NO again
    suppressInformingDelegate = !informDelegate;
    
    return didResignFirstResponder;
}

- (void)keyDown:(NSEvent *)theEvent
{
    if (LOG) NSLog(@"chars: %@ - unmodchars: %@ - keyCode: %hu", theEvent.characters, theEvent.charactersIgnoringModifiers, theEvent.keyCode);
    [super keyDown:theEvent];
}


@end
