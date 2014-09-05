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
     stickyDelegate:(id<SWStickyKeyDelegate>)stickyDelegate
{
    if (self = [super init]) {
        self.frame = frame;
        self.stateLabels = stateLabels;
        self.stateValues = stateValues;
        self.isSticky = isSticky;
        self.stickyState = SWStickyKeyStateUp;
        self.stickyDelegate = stickyDelegate;
    }
    return self;
}
@end
