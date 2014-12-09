//
//  AppDelegate.m
//  SWSoftKeyboardDemo
//
//  Created by Spencer Williams on 9/8/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#import "AppDelegate.h"

#import <QuartzCore/QuartzCore.h>

@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@property (strong) SWSoftKeyboard *keyboard;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    SWSoftKeyboardEmailAddressLayout *keyboardLayout = [SWSoftKeyboardEmailAddressLayout new];
    [keyboardLayout setLayoutDelegate:self];
    self.keyboard = [[SWSoftKeyboard alloc] initWithLayout:keyboardLayout];
    [self.keyboard setDelegate:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - SWSoftKeyboard Protocols
#pragma mark SWSoftKeyboardDelegate

- (void)softKeyboardReadyToExit:(SWSoftKeyboard *)keyboard
{
    [self.keyboard hideSoftKeyboardAnimated:YES];
    // there's something wrong with resignFirstResponder
    [self.window makeFirstResponder:nil];
}

#pragma mark SWSoftKeyboardLayoutDelegate

- (CGSize)maxSizeForLayout:(SWSoftKeyboardLayout *)layout {
    return CGSizeMake(1000, MAXFLOAT);
}

#pragma mark SWFirstResponderDelegate

- (void)textFieldWillBecomeFirstResponder:(NSTextField *)textField
{
    [self.keyboard showSoftKeyboardAnimated:YES];
}

@end
