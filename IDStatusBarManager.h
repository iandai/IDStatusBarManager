//
//  IDStatusBarManager.h
//  IDStatusBarManager
//
//  Created by IanDai on 06.08.18.
//  Copyright © 2018 IanDai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DRPosition) {
    DRPositionNone     =  0,          // Whole status bar
    DRPositionLeft     =  1,          // Left side of time item view
    DRPositionCenter   =  2,          // Center
    DRPositionRight    =  3           // Right side of time item view
};

@interface IDStatusBarManager : NSObject
+ (void)hideItemViewAt:(DRPosition)position;
+ (void)showItemViewAt:(DRPosition)position;
+ (void)animatewAt:(DRPosition)position text:(NSAttributedString *)text duration:(NSTimeInterval)duration completion:(void (^ __nullable)(BOOL finished))completion;
@end
