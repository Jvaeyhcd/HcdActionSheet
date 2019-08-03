//
//  HcdActionSheet.m
//  HcdActionSheetDemo
//
//  Created by polesapp-hcd on 16/7/13.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#import "HcdActionSheet.h"

#define kCollectionViewHeight 178.0f
#define kHcdSheetCellHeight 50.0f
#define kHcdScreenHeight [UIScreen mainScreen].bounds.size.height
#define kHcdScreenWidth [UIScreen mainScreen].bounds.size.width
#define kHcdCellSpacing 7.0f
#define IS_IPHONEX ([UIScreen mainScreen].bounds.size.height >= 812.0f)

@class HcdActionSheet;

@interface HcdActionSheet()<UIGestureRecognizerDelegate>
// 取消的字符串
@property (nonatomic, copy  )      NSString  *cancelStr;
// 按钮的文字
@property (nonatomic, strong)      NSArray   *titles;
// 底部按钮容器
@property (nonatomic, strong)      UIView    *buttomView;
// 顶部提示文字
@property (nonatomic, copy  )      NSString  *attachTitle;
// 高度
@property (nonatomic, assign)      CGFloat   actionSheetHeight;

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
    
    buttomView.backgroundColor = [UIColor colorWithRed:0.922 green:0.918 blue:0.937 alpha:1.00];
    
    _actionSheetHeight = IS_IPHONEX ? _titles.count * (kHcdSheetCellHeight + 0.5f) + 34.0 : _titles.count * (kHcdSheetCellHeight + 0.5f);
    
    CGFloat attachTitleHeight = 0;
    // 高度累计计算
    if (_attachTitle) {
        attachTitleHeight = [self getStringHeightWithText:_attachTitle font:[UIFont systemFontOfSize:12.0f] viewWidth:kHcdScreenWidth - 32] + 40;
        if (attachTitleHeight < 64) {
            attachTitleHeight = 64;
        }
        _actionSheetHeight += attachTitleHeight;
    }
    
    // 取消的文字高度累计
    if (_cancelStr) {
        _actionSheetHeight += ((kHcdSheetCellHeight + 0.5f) + kHcdCellSpacing);
    }
    
    [buttomView setFrame:CGRectMake(0, kHcdScreenHeight, kHcdScreenWidth, _actionSheetHeight)];
    _buttomView = buttomView;
    [self addSubview:_buttomView];
    /*end*/
    
    /*CanceBtn*/
    CGFloat cancleBtnY = IS_IPHONEX ? CGRectGetHeight(buttomView.bounds) - kHcdSheetCellHeight - 34.0 : CGRectGetHeight(buttomView.bounds) - kHcdSheetCellHeight;
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancleBtn setBackgroundColor:[UIColor whiteColor]];
    [cancleBtn setFrame:CGRectMake(0, cancleBtnY, kHcdScreenWidth, kHcdSheetCellHeight)];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn setTitle:_cancelStr forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(selectedButtons:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTag:100];
    if (_cancelStr) {
        [cancleBtn setFrame:CGRectMake(0, cancleBtnY, kHcdScreenWidth, kHcdSheetCellHeight)];
        [_buttomView addSubview:cancleBtn];
    }
    
    if (IS_IPHONEX) {
        UIView *bView = [[UIView alloc] init];
        bView.frame = CGRectMake(0, cancleBtnY + kHcdSheetCellHeight, kHcdScreenWidth, 34.0);
        bView.backgroundColor = [UIColor whiteColor];
        [_buttomView addSubview:bView];
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
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(selectedButtons:) forControlEvents:UIControlEventTouchUpInside];
        [_buttomView addSubview:btn];
    }
    /*END*/
    
    if (_attachTitle) {
        
        UILabel *attachTitleView = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, kHcdScreenWidth - 32, attachTitleHeight)];
        attachTitleView.backgroundColor = [UIColor whiteColor];
        attachTitleView.font = [UIFont systemFontOfSize:12.0f];
        attachTitleView.textColor = [UIColor grayColor];
        attachTitleView.text = _attachTitle;
        attachTitleView.textAlignment = NSTextAlignmentCenter;
        attachTitleView.numberOfLines = 0;
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kHcdScreenWidth, attachTitleHeight)];
        titleView.backgroundColor = [UIColor whiteColor];
        [titleView addSubview:attachTitleView];
        
        [_buttomView addSubview:titleView];
        
    }
    
    [self setCornerOnTop:_buttomView radius:8.0];
}

/**
 *  按钮的点击事件
 *
 *  @param btns 被电击的按钮
 */
- (void)selectedButtons:(UIButton *)btns{
    
    typeof(self) __weak weak = self;
    [self dismissBlock:^(BOOL complete) {
        if (weak.seletedButtonIndex) {
            weak.seletedButtonIndex(btns.tag - 100);
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
-(void)dismissBlock:(void(^)(BOOL complete))block{
    
    
    typeof(self) __weak weak = self;
    CGFloat height = ((kHcdSheetCellHeight+0.5f)+kHcdCellSpacing) + (_titles.count * (kHcdSheetCellHeight+0.5f)) + kCollectionViewHeight;
    
    [UIView animateWithDuration:0.4f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [weak setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f]];
        [weak.buttomView setFrame:CGRectMake(0, kHcdScreenHeight, kHcdScreenWidth, height)];
        
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
        [weak.buttomView setFrame:CGRectMake(0, kHcdScreenHeight - weak.actionSheetHeight, kHcdScreenWidth, weak.actionSheetHeight)];
        
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weak action:@selector(dismiss:)];
        tap.delegate = self;
        [weak addGestureRecognizer:tap];
        
        [weak.buttomView setFrame:CGRectMake(0, kHcdScreenHeight - weak.actionSheetHeight, kHcdScreenWidth, weak.actionSheetHeight)];
    }];
}

/**
 根据字体计算文字高度

 @param text 文字内容
 @param font 字体大小
 @param width 界面的宽度
 @return 计算好的高度
 */
- (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
    
    // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
}

- (void)setCornerOnTop:(UIView *)view radius:(CGFloat)radius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(10.0f, 10.0f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

@end
