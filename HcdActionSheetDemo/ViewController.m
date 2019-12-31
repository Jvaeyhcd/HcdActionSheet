//
//  ViewController.m
//  HcdActionSheetDemo
//
//  Created by polesapp-hcd on 16/7/13.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#import "ViewController.h"
#import "HcdActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"HcdActionSheetDemo";
    
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.frame = CGRectMake(0, 0, 100, 40);
    openBtn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    [openBtn setTitle:@"Open" forState:UIControlStateNormal];
    [openBtn addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
    openBtn.layer.cornerRadius = 4;
    openBtn.backgroundColor = [UIColor colorWithRed:0.373 green:0.718 blue:0.980 alpha:1.00];
    openBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:openBtn];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(openBtn);
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[openBtn(==100)]"
                                                          options:0
                                                          metrics:nil
                                                            views:views];
    
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[openBtn(==40)]"
                                                          options:0
                                                          metrics:nil
                                                            views:views];
    
    NSLayoutConstraint *cx = [NSLayoutConstraint constraintWithItem:openBtn
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0];
    
    NSLayoutConstraint *cy = [NSLayoutConstraint constraintWithItem:openBtn
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0];
    
    [self.view addConstraints:@[cx, cy]];
    [self.view addConstraints:ch];
    [self.view addConstraints:cv];
}

- (void)open {
    HcdActionSheet *sheet = [[HcdActionSheet alloc] initWithCancelStr:@"Cancle"
                                                    otherButtonTitles:@[@"Log Out"]
                                                          attachTitle:@"Are you sure Log Out? Log Out the userinfo will be losed!Are you sure Log Out? Log Out the userinfo will be losed!"];
    sheet.seletedButtonIndex  = ^(NSInteger index) {
        NSLog(@"%ld", (long)index);
    };
    [[UIApplication sharedApplication].keyWindow addSubview:sheet];
    [sheet showHcdActionSheet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
