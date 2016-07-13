//
//  HcdActionSheet.h
//  HcdActionSheetDemo
//
//  Created by polesapp-hcd on 16/7/13.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^completeAnimationBlock)(BOOL complete);
typedef void(^seletedButtonIndexBlock)(NSInteger index);

@interface HcdActionSheet : UIView

@property (nonatomic,strong) seletedButtonIndexBlock selectButtonAtIndex;

-(instancetype) initWithCancelStr:(NSString *)str otherButtonTitles:(NSArray *)titles attachTitle:(NSString *)attachTitle;
-(void) changeTitleColor:(UIColor *)color andIndex:(NSInteger )index;
-(void) showHcdActionSheet;

@end