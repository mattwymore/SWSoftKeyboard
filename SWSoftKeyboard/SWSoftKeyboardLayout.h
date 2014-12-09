//
//  SWSoftKeyboardLayout.h
//  CurrentScience
//
//  Created by Spencer Williams on 12/8/14.
//  Copyright (c) 2014 Uncorked Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWSoftKeyboardProtocols.h"

/// Objects that implement this protocol may provide details (to the layout itself) about how the layout looks and acts
@protocol SWSoftKeyboardLayoutDelegate <NSObject>

@optional
- (CGSize)maxSizeForLayout:(SWSoftKeyboardLayout *)layout;

@end


@interface SWSoftKeyboardLayout : NSObject
@property (nonatomic, strong) NSMutableDictionary *keysForStates;
@property (nonatomic, assign) NSInteger maxKeysInRow;
@property (nonatomic, assign) CGFloat gutter;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) NSInteger numberOfRows;
@property (nonatomic, assign) CGFloat defaultKeyWidth;
@property (nonatomic, assign) CGFloat defaultKeyHeight;
@property (nonatomic, assign) CGFloat keyHeightMultiplier;
@property (nonatomic, strong) NSArray *keyCodeValues;

/// The delegate to pass to each of the keys
@property (nonatomic, weak) id<SWKeyDelegate> keyDelegate;

@property (nonatomic, weak) id<SWSoftKeyboardLayoutDelegate>layoutDelegate;

/// @name Subclasses should override these

/**
 The keys of this layout.
 
 In this class this returns an empty array, but subclasses of this class should return filled arrays of SWSoftKeys.
 @param layoutState The state of the layout
 @return The keys in a particular state of this layout
 */
- (NSArray *)keysForState:(int)layoutState;
/**
 The keyboard's frame for a specific layout state.
 
 @param layoutState The layout state
 @return The keyboard's frame
 */
- (NSRect)keyboardFrameForState:(int)layoutState;
/**
 The number of possible states of this layout.
 
 Like `keys`, this should be defined in subclasses of this class.
 Keyboards are initialized with a layout state of 0.
 State descriptions may be handled internally to subclasses of this class.
 
 Note that the layout should probably only make one of each kind of key. That is,
 there should only be one 'Q' key between the "keyboard shift down" and "keyboard shift up"
 states. Also note that the Q key returned by this method may have a dirty label/value,
 So the keyboard should **also** update its individual keys.
 
 I guess you can think of this method as "what's the forest?" and when the keyboard has
 the "forest" then it still has to update each "tree". Perhaps not the most efficient,
 but I'm on a timeline here folks.
 
 @return The number of possible states of thsi layout.
 */
- (int)layoutStates;

- (void)emptyExistingKeys;
@end
