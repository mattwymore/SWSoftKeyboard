//
//  SWSoftKeyboardLayout.h
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

/// An interface that describes how to interact with a keyboard layout
@interface SWSoftKeyboardLayout : NSObject
/// The keys of this layout. In this class this returns an empty array,
/// but subclasses of this class should return filled arrays of SWSoftKeys.
- (NSArray *)keys;
/// The number of possible states of this layout. Like `keys`, states
/// should be defined in subclasses of this class.
- (int)layoutStates;
@end
