//
//  AppDelegate.m
//  SWSoftKeyboardDemo
//
//  Created by Spencer Williams on 9/5/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#import "AppDelegate.h"
#import "SWSoftKeyboard.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *textField;

@end

@implementation AppDelegate
            
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - NSTextFieldDelegate

- (void)controlTextDidBeginEditing:(NSNotification *)obj
{
    
}

- (void)controlTextDidEndEditing:(NSNotification *)obj
{
    
}

@end
