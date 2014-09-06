//
//  AppDelegate.m
//  SWSoftKeyboardDemo
//
//  Created by Spencer Williams on 9/5/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#import "AppDelegate.h"
#import "SWSoftKeyboard.h"
#import "SWSoftKeyboardEmailAddressLayout.h"

#import <QuartzCore/QuartzCore.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *textField;
@property (strong) SWSoftKeyboard *keyboard;

@end

@implementation AppDelegate
            
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.keyboard = [[SWSoftKeyboard alloc] initWithLayout:[SWSoftKeyboardEmailAddressLayout new]];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - NSTextFieldDelegate

- (void)controlTextDidBeginEditing:(NSNotification *)obj
{
//    NSRect oldFrame = NSMakeRect((((NSView *)self.window.contentView).frame.size.width - self.keyboard.frame.size.width)/2.0,
//                                 -1*self.keyboard.frame.size.height,
//                                 self.keyboard.frame.size.width,
//                                 self.keyboard.frame.size.height);
//    [self.keyboard setFrame:oldFrame];
//    [self.window.contentView addSubview:self.keyboard];
//    NSRect newFrame = NSMakeRect(oldFrame.origin.x,
//                                 0,
//                                 oldFrame.size.width,
//                                 oldFrame.size.height);
//    [[self.keyboard animator] setFrame:newFrame];
}

- (void)controlTextDidEndEditing:(NSNotification *)obj
{
//    [CATransaction begin]; {
//
//        [CATransaction setCompletionBlock:^{
//            [self.keyboard removeFromSuperview];
//        }];
//        
//        CABasicAnimation *scrollOut = [CABasicAnimation animationWithKeyPath:@"position"];
//        [scrollOut setFromValue:[NSValue valueWithPoint:self.keyboard.frame.origin]];
//        NSPoint newPosition = NSMakePoint(self.keyboard.frame.origin.x, -1*self.keyboard.frame.size.height);
//        self.keyboard.layer.position = newPosition;
//        [scrollOut setToValue:[NSValue valueWithPoint:newPosition]];
//        [self.keyboard.layer addAnimation:scrollOut forKey:@"position"];
//        
//    } [CATransaction commit];
}

@end
