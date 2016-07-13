//
//  HcdActionSheet.m
//  HcdActionSheetDemo
//
//  Created by polesapp-hcd on 16/7/13.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#import "HcdActionSheet.h"

#define kCollectionViewHeight 178.0f
#define kSubTitleHeight 65.0f
#define kHcdSheetCellHeight 50.0f
#define kHcdScreenHeight [UIScreen mainScreen].bounds.size.height
#define kHcdScreenWidth [UIScreen mainScreen].bounds.size.width
#define kHcdCellSpacing 7.0f

@class HcdActionSheet;

@interface HcdActionSheet()<UIGestureRecognizerDelegate>

@property (nonatomic, copy  )      NSString  *cancelStr;
@property (nonatomic, strong)      NSArray   *titles;
@property (nonatomic, weak  )      UIView    *buttomView;
@property (nonatomic, copy  )      NSString  *attachTitle;
@property (nonatomic        )      CGFloat   actionSheetHeight;

@end

@implementation HcdActionSheet

- (instancetype) initWithCancelStr:(NSString *)str otherButtonTitles:(NSArray *)titles attachTitle:(NSString *)attachTitle
{
    self = [super init];
    if (self) {
        _attachTitle = attachTitle;
        _cancelStr = str;
        _titles = titles;
        [self loadUI];
    }
    return self;
}

/**
 *  加载UI
 */
- (void)loadUI
{
    /*self*/
    [self setFrame:CGRectMake(0, 0, kHcdScreenWidth, kHcdScreenHeight)];
    [self setBackgroundColor:[UIColor clearColor]];
    /*end*/
    
    /*buttomView*/
    UIView *buttomView = [[UIView alloc] init];
    
    buttomView.backgroundColor = [UIColor colorWithRed:223.0f/255.0f green:226.0f/255.f blue:236.0f/255.0f alpha:1];
    
    _actionSheetHeight = _titles.count * (kHcdSheetCellHeight+0.5f);
    if (_attachTitle) {
        _actionSheetHeight += kSubTitleHeight;
    }
    if (_cancelStr) {
        _actionSheetHeight += ((kHcdSheetCellHeight+0.5f)+kHcdCellSpacing);
    }
    
    [buttomView setFrame:CGRectMake(0, kHcdScreenHeight, kHcdScreenWidth, _actionSheetHeight)];
    _buttomView = buttomView;
    [self addSubview:_buttomView];
    /*end*/
    
    /*CanceBtn*/
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancleBtn setBackgroundColor:[UIColor whiteColor]];
    [cancleBtn setFrame:CGRectMake(0, CGRectGetHeight(buttomView.bounds) - kHcdSheetCellHeight, kHcdScreenWidth, kHcdSheetCellHeight)];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn setTitle:_cancelStr forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(selectedButtons:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTag:100];
    if (_cancelStr) {
        [cancleBtn setFrame:CGRectMake(0, CGRectGetHeight(buttomView.bounds) - kHcdSheetCellHeight, kHcdScreenWidth, kHcdSheetCellHeight)];
        [_buttomView addSubview:cancleBtn];
    }
    
    /*end*/
    
    /*Items*/
    for (NSString *title in _titles) {
        
        NSInteger index = [_titles indexOfObject:title];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setBackgroundColor:[UIColor whiteColor]];
        
        CGFloat hei = 0;
        CGFloat y = 0;
        
        if (_cancelStr) {
            hei = (50.5 * _titles.count) + kHcdCellSpacing;
            y = (CGRectGetMinY(cancleBtn.frame) + (index * (kHcdSheetCellHeight+0.5))) - hei;
        } else {
            hei = (50.5 * (_titles.count - 1));
            y = (CGRectGetMinY(cancleBtn.frame) + (index * (kHcdSheetCellHeight+0.5))) - hei;
        }
        
        [btn setFrame:CGRectMake(0, y, kHcdScreenWidth, kHcdSheetCellHeight)];
        [btn setTag:(index + 100)+1];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectedButtons:) forControlEvents:UIControlEventTouchUpInside];
        [_buttomView addSubview:btn];
    }
    /*END*/
    
    if (_attachTitle) {
        
        UILabel *attachTitleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kHcdScreenWidth, kSubTitleHeight)];
        attachTitleView.backgroundColor = [UIColor whiteColor];
        attachTitleView.font = [UIFont systemFontOfSize:12.0f];
        attachTitleView.textColor = [UIColor grayColor];
        attachTitleView.text = _attachTitle;
        attachTitleView.textAlignment = 1;
        attachTitleView.numberOfLines = 0;
        
        
        [_buttomView addSubview:attachTitleView];
        
    }
}

/**
 *  按钮的点击事件
 *
 *  @param btns 被电击的按钮
 */
- (void)selectedButtons:(UIButton *)btns{
    
    typeof(self) __weak weak = self;
    [self dismissBlock:^(BOOL complete) {
        if (weak.selectButtonAtIndex) {
            weak.selectButtonAtIndex(btns.tag - 100);
        }
    }];
    
    
}

//修改某一项的titleColor
- (void)changeTitleColor:(UIColor *)color andIndex:(NSInteger )index{
    
    UIButton *btn = (UIButton *)[_buttomView viewWithTag:index + 100];
    [btn setTitleColor:color forState:UIControlStateNormal];
    
}

//隐藏
-(void)dismiss:(UITapGestureRecognizer *)tap{
    
    if( CGRectContainsPoint(self.frame, [tap locationInView:_buttomView])) {
        NSLog(@"tap");
    } else{
        
        [self dismissBlock:^(BOOL complete) {
            
        }];
    }
}

//隐藏ActionSheet的Block
-(void)dismissBlock:(completeAnimationBlock)block{
    
    
    typeof(self) __weak weak = self;
    CGFloat height = ((kHcdSheetCellHeight+0.5f)+kHcdCellSpacing) + (_titles.count * (kHcdSheetCellHeight+0.5f)) + kCollectionViewHeight;
    
    [UIView animateWithDuration:0.4f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [weak setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f]];
        [_buttomView setFrame:CGRectMake(0, kHcdScreenHeight, kHcdScreenWidth, height)];
        
    } completion:^(BOOL finished) {
        
        block(finished);
        [self removeFromSuperview];
        
    }];
    
}

/**
 *  显示ActionSheet
 */
- (void)showHcdActionSheet
{
    typeof(self) __weak weak = self;
    [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [weak setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]];
        [_buttomView setFrame:CGRectMake(0, kHcdScreenHeight - _actionSheetHeight, kHcdScreenWidth, _actionSheetHeight)];
        
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weak action:@selector(dismiss:)];
        tap.delegate = self;
        [weak addGestureRecognizer:tap];
        
        [_buttomView setFrame:CGRectMake(0, kHcdScreenHeight - _actionSheetHeight, kHcdScreenWidth, _actionSheetHeight)];
    }];
}

@end
