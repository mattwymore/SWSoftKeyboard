//
//  SWSoftKeyboardKey.m
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#import "SWSoftKeyboardKey.h"

@interface SWSoftKeyboardKey ()
@property (nonatomic, assign) NSRect frame;
@end

@implementation SWSoftKeyboardKey

- (id)initWithFrame:(NSRect)frame
        stateLabels:(NSDictionary *)stateLabels
        stateValues:(NSDictionary *)stateValues
             sticky:(BOOL)isSticky
     keyDelegate:(id<SWKeyDelegate>)keyDelegate
{
    if (self = [super init]) {
        self.frame = frame;
        self.stateLabels = stateLabels;
        self.stateValues = stateValues;
        self.isSticky = isSticky;
        self.stickyState = SWStickyKeyStateUp;
        self.keyDelegate = keyDelegate;
        
        [self setTarget:self];
        [self setAction:@selector(hit)];
    }
    return self;
}

- (void)hit
{
    if (self.keyDelegate) {
        if (self.isSticky) {
            [self.keyDelegate softKeyboardKey:self stickiedInState:self.stickyState];
        } else {
            [self.keyDelegate softKeyboardKeyPressed:self];
        }
    }
}

- (id)labelForKeyboardState:(int)keyboardState
{
    NSDictionary *stickyStateLabels = [self.stateLabels objectForKey:[NSNumber numberWithInt:(int)self.stickyState]];
    if (stickyStateLabels) {
        return [stickyStateLabels objectForKey:[NSNumber numberWithInt:keyboardState]];
    }
    return nil;
}
- (NSString *)valueForKeyboardState:(int)keyboardState
{
    NSDictionary *stickyStateValues = [self.stateValues objectForKey:[NSNumber numberWithInt:(int)self.stickyState]];
    if (stickyStateValues) {
        return [stickyStateValues objectForKey:[NSNumber numberWithInt:keyboardState]];
    }
    return @"";
}
@end
