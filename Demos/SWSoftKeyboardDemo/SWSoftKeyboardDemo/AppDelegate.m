//
//  AppDelegate.m
//  SWSoftKeyboardDemo
//
//  Created by Spencer Williams on 9/8/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#import "AppDelegate.h"

#import <SWSoftKeyboard/SWSoftKeyboard.h>
#import <SWSoftKeyboard/SWSoftKeyboardEmailAddressLayout.h>
#import <QuartzCore/QuartzCore.h>
#import <SWSoftKeyboard/SWTextField.h>

@interface AppDelegate () {
    BOOL keyboardShowing;
}

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet SWTextField *textField;
@property (strong) SWSoftKeyboard *keyboard;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.keyboard = [[SWSoftKeyboard alloc] initWithLayout:[SWSoftKeyboardEmailAddressLayout new]];
    keyboardShowing = NO;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - Private helpers

- (void)showSoftKeyboardAnimated:(BOOL)animated
{
    if (keyboardShowing) return;
    NSLog(@"AppD showing keyboard");
    NSRect oldFrame = NSMakeRect((((NSView *)self.window.contentView).frame.size.width - self.keyboard.frame.size.width)/2.0,
                                 -1*self.keyboard.frame.size.height,
                                 self.keyboard.frame.size.width,
                                 self.keyboard.frame.size.height);
    [self.keyboard setFrame:oldFrame];
    [self.window.contentView addSubview:self.keyboard];
    NSRect newFrame = NSMakeRect(oldFrame.origin.x,
                                 0,
                                 oldFrame.size.width,
                                 oldFrame.size.height);
    if (animated) {
        [[self.keyboard animator] setFrame:newFrame];
    } else {
        [self.keyboard setFrame:newFrame];
    }
    keyboardShowing = YES;
}
- (void)hideSoftKeyboardAnimated:(BOOL)animated
{
    if (!keyboardShowing) return;
    NSLog(@"AppD hiding keyboard");
    if (animated) {
        [CATransaction begin]; {
            
            [CATransaction setCompletionBlock:^{
                [self.keyboard removeFromSuperview];
                keyboardShowing = NO;
            }];
            
            CABasicAnimation *scrollOut = [CABasicAnimation animationWithKeyPath:@"position"];
            [scrollOut setDuration:1.0];
            [scrollOut setFromValue:[NSValue valueWithPoint:self.keyboard.frame.origin]];
            NSPoint newPosition = NSMakePoint(self.keyboard.frame.origin.x, -1*self.keyboard.frame.size.height);
//            self.keyboard.layer.position = newPosition;
            [scrollOut setToValue:[NSValue valueWithPoint:newPosition]];
            [self.keyboard.layer addAnimation:scrollOut forKey:@"position"];
            
        } [CATransaction commit];
    } else {
        [self.keyboard removeFromSuperview];
        keyboardShowing = NO;
    }
}

#pragma mark - SWFirstResponderDelegate

- (void)textFieldWillBecomeFirstResponder:(NSTextField *)textField
{
    NSLog(@"AppD control %ld will become FR. %@", (long)textField.tag, [self.window firstResponder]);
}
- (void)textField:(NSTextField *)textField didBecomeFirstResponder:(BOOL)success
{
    NSLog(@"AppD control %ld did become FR. %@", (long)textField.tag, [self.window firstResponder]);
    [self showSoftKeyboardAnimated:YES];
}

- (void)textFieldWillResignFirstResponder:(NSTextField *)textField
{
    NSLog(@"AppD control %ld will resign FR. %@", (long)textField.tag, [self.window firstResponder]);
}
- (void)textField:(NSTextField *)textField didResignFirstResponder:(BOOL)success
{
    NSLog(@"AppD control %ld did resign FR. %@", (long)textField.tag, [self.window firstResponder]);
}

#pragma mark - NSTextFieldDelegate

- (void)controlTextDidBeginEditing:(NSNotification *)obj
{
    NSLog(@"AppD control %ld did begin editing",[obj.object tag]);
}

- (void)controlTextDidEndEditing:(NSNotification *)obj
{
    NSLog(@"AppD control %ld did end editing",[obj.object tag]);
    [self hideSoftKeyboardAnimated:YES];
}

@end
