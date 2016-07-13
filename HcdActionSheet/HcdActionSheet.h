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

/**
 *  传入相关参数初始化HcdActionSheet
 *
 *  @param str         取消按钮文字
 *  @param titles      所有选项文字数组
 *  @param attachTitle 提示文字
 *
 *  @return HcdActionSheet对象
 */
- (instancetype) initWithCancelStr:(NSString *)str otherButtonTitles:(NSArray *)titles attachTitle:(NSString *)attachTitle;

/**
 *  修改某一项的titleColor
 *
 *  @param color 颜色
 *  @param index 下标
 */
- (void)changeTitleColor:(UIColor *)color andIndex:(NSInteger )index;

/**
 *  显示出来
 */
- (void)showHcdActionSheet;

@end