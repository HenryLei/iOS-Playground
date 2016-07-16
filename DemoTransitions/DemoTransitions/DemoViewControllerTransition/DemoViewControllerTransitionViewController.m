//
//  DemoViewControllerTransitionViewController.m
//  DemoTransitions
//
//  Created by Chris Hu on 16/7/16.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "DemoViewControllerTransitionViewController.h"
#import "DemoViewControllerTransitionPresentedViewController.h"

#import "AnimatorPresentTransition.h"


@interface DemoViewControllerTransitionViewController () <

    UIViewControllerTransitioningDelegate
>

@end

@implementation DemoViewControllerTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self demo];
}

- (void)demo {
    switch (_demoType) {
        case DemoViewControllerTransitionTypeBubble:
        {
            [self prepareBubble];
        }
            break;
        default:
            break;
    }
    
}

- (void)prepareBubble {
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.frame.size.width - 80) / 2,
                              self.view.frame.size.height - 80 - 64,
                              80,
                              80);
    [self.view addSubview:button];
    [button setTitle:@"+" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:60];
    
    button.layer.cornerRadius = 40;
    [button addTarget:self action:@selector(actionBubble:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)actionBubble:(UIButton *)sender {
    DemoViewControllerTransitionPresentedViewController *presentedVC = [[DemoViewControllerTransitionPresentedViewController alloc] init];
    
    // 设置transitioningDelegate, 然后在其中实现协议方法即可.
    presentedVC.transitioningDelegate = self;
    [self presentViewController:presentedVC animated:YES completion:nil];
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    // 指定的继承UIViewControllerAnimatedTransitioning协议的对象.
    // 其中的协议方法即指定了转场动画.
    return [[AnimatorPresentTransition alloc] initFromViewController:presented toViewController:presenting];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return nil;
}

@end