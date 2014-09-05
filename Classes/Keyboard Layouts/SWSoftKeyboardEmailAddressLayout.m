//
//  SWSoftKeyboardEmailAddressLayout.m
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#import "SWSoftKeyboardEmailAddressLayout.h"

@implementation SWSoftKeyboardEmailAddressLayout
- (NSArray *)keysForState:(int)layoutState
{
    // this layout actually doesn't care about layout state
    
    NSMutableArray *keysArray = [NSMutableArray new];
    
    NSArray *alphabetKeys = [self commonAlphabetKeys];
    // update frame data for all keys
    // TODO: incomplete
    return keysArray;
}
- (int)layoutStates
{
    return 2; // shift up, shift down
}
@end
