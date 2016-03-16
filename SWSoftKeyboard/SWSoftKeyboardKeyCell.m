//
//  SWSoftKeyboardKey.m
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  This is free and unencumbered software released into the public domain.
//

#import "SWSoftKeyboardKeyCell.h"

@interface SWSoftKeyboardKeyCell ()
@property (nonatomic, assign) NSRect frame;
@end

@implementation SWSoftKeyboardKeyCell

@dynamic frame;

- (id)initWithStateLabels:(NSDictionary *)stateLabels
              stateValues:(NSDictionary *)stateValues
                  keyType:(SKKeyType)keyType
              controlType:(SKControlType)controlType
{
    return [self initWithFrame:NSZeroRect stateLabels:stateLabels stateValues:stateValues keyType:keyType controlType:controlType keyDelegate:nil];
}
- (id)initWithFrame:(NSRect)frame
        stateLabels:(NSDictionary *)stateLabels
        stateValues:(NSDictionary *)stateValues
            keyType:(SKKeyType)keyType
        controlType:(SKControlType)controlType
        keyDelegate:(id<SWKeyDelegate>)keyDelegate
{
    return [self initWithFrame:frame stateLabels:stateLabels stateValues:stateValues keyCode:@0 keyType:keyType controlType:controlType keyDelegate:keyDelegate];
}

- (id)initWithFrame:(NSRect)frame
        stateLabels:(NSDictionary *)stateLabels
        stateValues:(NSDictionary *)stateValues
            keyCode:(NSNumber *)keyCode
            keyType:(SKKeyType)keyType
        controlType:(SKControlType)controlType
        keyDelegate:(id<SWKeyDelegate>)keyDelegate
{
    if (self = [super init]) {
        self.frame = frame;
        self.stateLabels = stateLabels;
        self.stateValues = stateValues;
        self.keyCode = keyCode;
        self.keyType = keyType;
        self.controlType = controlType;
        self.keyDelegate = keyDelegate;
        self.isShifted = NO;
        
        if ([self isSticky]) {
            [self setButtonType:NSMomentaryPushInButton];
        } else {
            [self setButtonType:NSMomentaryPushInButton];
        }
        self.bezelStyle = NSSmallSquareBezelStyle;
        self.bordered = NO;
        self.wantsLayer = YES;
        self.layer.cornerRadius = 10;
        //self.layer.backgroundColor = CGColorCreateGenericRGB(1.0, 1.0, 1.0, 0.7);
        [self setFont:[NSFont fontWithName:@"Arial" size:frame.size.height/3]];
        [self setTitle:[stateLabels objectForKey:[NSNumber numberWithBool:self.isShifted]]];
        [self setTarget:self];
        [self setAction:@selector(hit)];
    }
    return self;
}

#pragma mark - Private helpers

-(void)setFrame:(NSRect)frame{
    [super setFrame:frame];
    NSInteger newRadius = frame.size.width/4;
    self.layer.cornerRadius = newRadius;
}

- (BOOL)isSticky
{
    return self.keyType == SKKeyTypeControl;
}

- (void)hit
{
    if (self.keyDelegate) {
        if ([self isSticky]) {
            self.isSelected = !self.isSelected;
            self.highlighted = !self.highlighted;
            [self.keyDelegate softKeyboardKeyToggled:self];
        } else {
            [self.keyDelegate softKeyboardKeyPressed:self];
        }
    }
}

#pragma mark - Public methods

- (NSView *)labelForKeyboardState:(int)keyboardState
{
    NSDictionary *stickyStateLabels = [self.stateLabels objectForKey:[NSNumber numberWithBool:self.isSelected]];
    if (stickyStateLabels) {
        return [stickyStateLabels objectForKey:[NSNumber numberWithInt:keyboardState]];
    }
    return nil;
}
- (NSString *)valueForKeyboardState:(int)keyboardState
{
    NSDictionary *stickyStateValues = [self.stateValues objectForKey:[NSNumber numberWithBool:self.isSelected]];
    if (stickyStateValues) {
        return [stickyStateValues objectForKey:[NSNumber numberWithInt:keyboardState]];
    }
    return @"";
}

- (NSString *)valueForKey
{
    NSString *stateValue = [self.stateValues objectForKey:[NSNumber numberWithBool:self.isShifted]];
    if (stateValue) {
        return stateValue;
    }
    return @"";
}

- (void)setShifted:(BOOL)shifted{
    self.isShifted= shifted;
    [self setTitle:[self.stateLabels objectForKey:[NSNumber numberWithBool:self.isShifted]]];
}

- (void)updateForKeyboardState:(int)keyboardState
{
    // TODO: update the cell's view according to the given keyboard state and the key's sitcky state
    
    
}

- (void)drawRect:(NSRect)rect
{
    if (self.isSelected) {
        [[NSColor colorWithCGColor:CGColorCreateGenericRGB(0.95, 0.95, 0.95, 1.0)] set];
    }else{
        [[NSColor colorWithCGColor:CGColorCreateGenericRGB(1.0, 1.0, 1.0, 0.7)] set];
    }
    NSRectFill([self bounds]);
    [super drawRect:rect];
}
@end
