//
//  XSYLoveBeenIntroductionController.m
//  LoveBeen
//
//  Created by xin on 2017/2/18.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenIntroductionController.h"

@interface XSYLoveBeenIntroductionController ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray<UIImage *> *imageArray;
@property (nonatomic, strong) UIScrollView *introductionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *jumpToMainControllerButton;
@end

@implementation XSYLoveBeenIntroductionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settings];
    [self initialScrollView];
    [self addScrollViewChildView];
    [self addPageControl];
    [self setHadUseAppBefore];
}

- (void)settings{
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)initialScrollView{
    _introductionView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _introductionView.contentSize = CGSizeMake(ScreenWidth * IntroductionPageNumber, ScreenHeight);
    _introductionView.bounces = NO;
    _introductionView.delegate = self;
    [self.view addSubview:_introductionView];
}

- (void)addScrollViewChildView{
    for (int i = 0; i < IntroductionPageNumber; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.imageArray[i]];
        imageView.frame = CGRectMake(i * ScreenWidth, 0, ScreenWidth, ScreenHeight);
        [_introductionView addSubview:imageView];
        if (i == IntroductionPageNumber - 1) {
            imageView.userInteractionEnabled = YES;
            _jumpToMainControllerButton = [[UIButton alloc] init];
            UIImage *jumpImage = [UIImage imageNamed:@"homepage_knownbtn"];
            [_jumpToMainControllerButton setBackgroundImage:jumpImage forState:UIControlStateNormal];
            _jumpToMainControllerButton.bounds = CGRectMake(0, 0, ScreenWidth * 0.5,jumpImage.size.height / jumpImage.size.width * ScreenWidth * 0.5 );
            _jumpToMainControllerButton.center = CGPointMake(self.view.center.x, ScreenHeight - 90);
            [_jumpToMainControllerButton addTarget:self action:@selector(clickChangeRootViewControllerButton:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:_jumpToMainControllerButton];
        }
        _introductionView.showsHorizontalScrollIndicator = NO;
        _introductionView.pagingEnabled = YES;
    }
}

- (void)addPageControl{
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.bounds = CGRectMake(0, 0, ScreenWidth * 0.4, 40);
    _pageControl.center = CGPointMake(self.view.center.x, self.view.bounds.size.height - 20);
    _pageControl.numberOfPages = IntroductionPageNumber;
    [self.view addSubview:_pageControl];
}

#pragma mark - event -
- (void)clickChangeRootViewControllerButton:(UIButton *)button{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeRootViewController object:nil userInfo:@{CurrentRootViewController:@"XSYLoveBeenTabbarController"}];
}

- (void)setHadUseAppBefore{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kHadUserAppBefore];
}

#pragma mark - scrollView delagate -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / ScreenWidth + 0.5);
}

#pragma mark - lazy -
- (NSArray<UIImage *> *)imageArray{
    if (_imageArray == nil) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < IntroductionPageNumber; i ++) {
            UIImage *image = [UIImage imageNamed:[IntroductionImageName stringByAppendingString:[NSString stringWithFormat:@"%d",i]]];
            [tempArray addObject:image];
        }
        _imageArray = tempArray;
    }
    return _imageArray;
}
@end
