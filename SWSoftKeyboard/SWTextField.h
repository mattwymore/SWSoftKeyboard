//
//  SWTextField.h
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/10/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SWSoftKeyboardProtocols.h"

/// A custom text field that notifies its First Responder Delegate about
/// first responder events
@interface SWTextField : NSTextField
/// The field's first responder delegate.
@property (nonatomic, weak) id<SWTextFieldFirstResponderDelegate> firstResponderDelegate;
@end
