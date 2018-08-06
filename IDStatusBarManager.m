//
//  IDStatusBarManager.m
//  IDStatusBarManager
//
//  Created by IanDai on 06.08.18.
//  Copyright © 2018 IanDai. All rights reserved.
//

#import "IDStatusBarManager.h"

@implementation IDStatusBarManager

+ (void)animatewAt:(DRPosition)position text:(NSAttributedString *)text duration:(NSTimeInterval)duration completion:(void (^ __nullable)(BOOL finished))completion {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    UILabel *label = [[UILabel alloc] initWithFrame:statusBar.frame];
    label.attributedText = text;
    
    switch (position) {
        case DRPositionNone:
            label.textAlignment = NSTextAlignmentCenter;
            break;
        case DRPositionLeft:
            label.textAlignment = NSTextAlignmentLeft;
            break;
        case DRPositionCenter:
            label.textAlignment = NSTextAlignmentCenter;
            break;
        case DRPositionRight:
            label.textAlignment = NSTextAlignmentRight;
            break;
        default:
            label.textAlignment = NSTextAlignmentCenter;
            break;
    }
    
    label.alpha = 0;
    [statusBar addSubview:label];
    [self hideItemViewAt:position];
    [UIView animateWithDuration:1 animations:^{
            label.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:duration options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
            [self showItemViewAt:position];
            completion(finished);
        }];
    }];
}

+ (void)hideItemViewAt:(DRPosition)position {
    
    NSArray *itemViews = [self itemViews];
    CGFloat leftMax = [self leftMax];
    CGFloat rightMin = [self rightMin];
    
    for (UIView *itemView in itemViews) {
        switch (position) {
            case DRPositionNone:
                [itemView setHidden:YES];
                break;
            case DRPositionLeft:
                if (itemView.frame.origin.x < leftMax) {
                    [itemView setHidden:YES];
                }
                break;
            case DRPositionCenter:
                if (itemView.frame.origin.x >= leftMax && itemView.frame.origin.x <= rightMin) {
                    [itemView setHidden:YES];
                }
                break;
            case DRPositionRight:
                if (itemView.frame.origin.x > rightMin) {
                    [itemView setHidden:YES];
                }
                break;
            default:
                [itemView setHidden:YES];
                break;
        }
    }
}

+ (void)showItemViewAt:(DRPosition)position {
    
    NSArray *itemViews = [self itemViews];
    CGFloat leftMax = [self leftMax];
    CGFloat rightMin = [self rightMin];
    
    for (UIView *itemView in itemViews) {
        switch (position) {
            case DRPositionNone:
                [itemView setHidden:NO];
                break;
            case DRPositionLeft:
                if (itemView.frame.origin.x < leftMax) {
                    [itemView setHidden:NO];
                }
                break;
            case DRPositionCenter:
                if (itemView.frame.origin.x >= leftMax && itemView.frame.origin.x <= rightMin) {
                    [itemView setHidden:NO];
                }
                break;
            case DRPositionRight:
                if (itemView.frame.origin.x > rightMin) {
                    [itemView setHidden:NO];
                }
                break;
            default:
                [itemView setHidden:NO];
                break;
        }
    }
}

+ (UIView *)statusBarTimeItemView {
    
    NSArray *itemViews = [self itemViews];
    UIView *statusBarTimeItemView = nil;
    for (UIView *itemView in itemViews) {
        if ([itemView isKindOfClass:NSClassFromString(@"UIStatusBarTimeItemView")]) {
            statusBarTimeItemView = itemView;
            continue;
        }
    }
    return statusBarTimeItemView;
}

+ (NSArray *)itemViews {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    NSArray *itemViews = (NSArray *)[[statusBar valueForKey:@"foregroundView"] subviews];
    return itemViews;
}

+ (CGFloat)leftMax {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    CGFloat leftMax = statusBar.center.x;
    UIView *statusBarTimeItemView = [self statusBarTimeItemView];
    if (statusBarTimeItemView) {
        leftMax = statusBarTimeItemView.frame.origin.x;
    }
    return leftMax;
}

+ (CGFloat)rightMin {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    CGFloat rightMin = statusBar.center.x;
    UIView *statusBarTimeItemView = [self statusBarTimeItemView];
    if (statusBarTimeItemView) {
        rightMin = statusBarTimeItemView.frame.origin.x + CGRectGetWidth(statusBarTimeItemView.frame);
    }
    return rightMin;
}

@end
