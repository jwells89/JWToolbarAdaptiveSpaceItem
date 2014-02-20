//
//  JWToolbarAdaptiveSpaceItem.h
//
//  Created by John Wells on 7/14/13.
//  Copyright (c) 2013 John Wells. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JWClickThroughView : NSView

@end


@interface JWToolbarAdaptiveSpaceItem : NSToolbarItem

@property (weak, nonatomic) NSView *linkedView;

- (void)updateWidth;

@end
