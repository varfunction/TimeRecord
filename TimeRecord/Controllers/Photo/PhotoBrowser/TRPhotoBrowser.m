//
//  TRPhotoBrowser.m
//  TimeRecord
//
//  Created by ocean tang on 14-8-8.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRPhotoBrowser.h"

#define WIDTH_PAGE (self.view.width)
#define HEIGHT_PAGE (self.view.height)
#define CONTENT_MODEL UIViewContentModeScaleAspectFill
#define PADDING                  10

@interface TRPhotoBrowser ()

@property (nonatomic, assign) BOOL isHidden;
@property (nonatomic, strong) UIScrollView *verticalScrollView;
@property (nonatomic, strong) UIImageView *blurredImageView;
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UIScrollView *horizonScrollView;
@property (nonatomic, strong) NSArray *reuseImageViewArray;

@property (nonatomic, strong) UIImageView *testImage;

@property (nonatomic, assign) NSUInteger currentReuseIndex;
@property (nonatomic, assign) NSUInteger currentPhotoIndex;
@property (nonatomic, assign) BOOL preloading;

@end

@implementation TRPhotoBrowser

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithDelegate:(id <TRPhotoBrowserDelegate>)delegate {
    if ((self = [self init])) {
        _delegate = delegate;
	}
	return self;
}

- (void)initScrollView
{
    CGFloat width = WIDTH_PAGE;
    CGFloat height = HEIGHT_PAGE;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor clearColor];
    
    
    // 垂直滚动view
    self.verticalScrollView = [[UIScrollView alloc] init];
    self.verticalScrollView.pagingEnabled = YES;
    self.verticalScrollView.bounces = NO;
    self.verticalScrollView.frame = self.view.bounds;
    self.verticalScrollView.height = height;
    self.verticalScrollView.width = width;
    self.verticalScrollView.backgroundColor = [UIColor clearColor];
    self.verticalScrollView.contentSize = CGSizeMake(width, 2 * height);
    self.verticalScrollView.delegate = self;
    
    self.verticalScrollView.clipsToBounds = YES;
    
    self.blurredImageView = [[UIImageView alloc] init];
    self.blurredImageView.contentMode = CONTENT_MODEL;
    self.blurredImageView.alpha = 0;
    self.blurredImageView.frame = self.view.bounds;
    self.blurredImageView.width = width;
    self.blurredImageView.height = height;
    
//    [self.verticalScrollView addSubview:self.blurredImageView];
//    [self reloadBluredImage];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:30];
    label.text = @"hello world";
    label.frame = CGRectMake(10, 0, 300, 50);
    label.top = self.blurredImageView.bottom;
//    [self.verticalScrollView addSubview:label];

    [self.view addSubview:self.verticalScrollView];
    
    // 水平滚动view
    
    // Setup paging scrolling view
	CGRect pagingScrollViewFrame = [self frameForHorizonScrollView];
	self.horizonScrollView = [[UIScrollView alloc] initWithFrame:pagingScrollViewFrame];
	self.horizonScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.horizonScrollView.pagingEnabled = YES;
	self.horizonScrollView.delegate = self;
	self.horizonScrollView.showsHorizontalScrollIndicator = NO;
	self.horizonScrollView.showsVerticalScrollIndicator = NO;
//	self.horizonScrollView.backgroundColor = [UIColor blackColor];
    self.horizonScrollView.contentSize = [self contentSizeForHorizonScrollView];
    self.horizonScrollView.bounces = NO;
    
    NSLog(@"horizon frame:%@ contenSize:%@", NSStringFromCGRect(_horizonScrollView.frame), NSStringFromCGSize(_horizonScrollView.contentSize));
    
//    self.horizonScrollView = [[UIScrollView alloc] init];
//    self.horizonScrollView.pagingEnabled = YES;
//    self.horizonScrollView.bounces = NO;
//    self.horizonScrollView.frame = self.view.bounds;
//    self.horizonScrollView.height = height;
//    self.horizonScrollView.width = width;
//    self.horizonScrollView.backgroundColor = [UIColor clearColor];
//    
//    self.horizonScrollView.delegate = self;
    
//    int numberOfPhoto = [self.delegate numberOfPhotosInPhotoBrowser:self];
//    self.horizonScrollView.contentSize = CGSizeMake(numberOfPhoto * width, height);
    
    for (UIImageView *imageView in self.reuseImageViewArray) {
        [self.horizonScrollView addSubview:imageView];
    }
    
    [self.verticalScrollView addSubview:self.horizonScrollView];
    
    [self.verticalScrollView addSubview:self.blurredImageView];
    [self reloadBluredImage];
    [self.verticalScrollView addSubview:label];
    
    // 手势绑定
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(tapWidthScrollView:)];
    
    [self.verticalScrollView addGestureRecognizer:tapGes];
    
}

- (CGRect)frameForHorizonScrollView {
    CGRect frame = self.view.bounds;// [[UIScreen mainScreen] bounds];
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);
    return CGRectIntegral(frame);
}

- (CGSize)contentSizeForHorizonScrollView {
    // We have to use the paging scroll view's bounds to calculate the contentSize, for the same reason outlined above.
    CGRect bounds = _horizonScrollView.bounds;
    return CGSizeMake(bounds.size.width * [self.delegate numberOfPhotosInPhotoBrowser:self], bounds.size.height);
}

- (void)initImageView
{
    NSMutableArray *temp = [NSMutableArray array];
    CGPoint prevPoint = CGPointZero;
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = WIDTH_PAGE;
        imageView.height = HEIGHT_PAGE;
        imageView.left = prevPoint.x + PADDING;
        prevPoint = CGPointMake(imageView.right + PADDING, 0);
        
        imageView.image = [self.delegate photoBrowser:self photoAtIndex:i];
        imageView.contentMode = CONTENT_MODEL;
        imageView.clipsToBounds = YES;
        [temp addObject:imageView];
    }
    self.reuseImageViewArray = [NSArray arrayWithArray:temp];
    
    self.currentReuseIndex = 0;
}

- (void)reloadBluredImage
{
    @weakify(self);
    self.verticalScrollView.scrollEnabled = NO;
    _preloading = YES;
    UIImageView *currentDisplayImage = _reuseImageViewArray[_currentReuseIndex];
    [self.blurredImageView setImageToBlur:currentDisplayImage.image blurRadius:10 completionBlock:^() {
        @strongify(self);
        self.verticalScrollView.scrollEnabled = YES;
        self.preloading = NO;
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(back:)];
    
    [self initImageView];
    [self initScrollView];
    
    return;
    
    CGFloat width = self.view.width;
    CGFloat height = self.view.height - 64;
    
    self.horizonScrollView = [[UIScrollView alloc] init];
    self.horizonScrollView.frame = self.view.bounds;
    self.horizonScrollView.pagingEnabled = YES;
    self.horizonScrollView.bounces = NO;
    
    
    UIImageView *firstImage = [[UIImageView alloc] init];
    firstImage.frame = self.view.bounds;
    firstImage.width = width;
    firstImage.height = height;
    firstImage.backgroundColor = [UIColor greenColor];
    [self.horizonScrollView addSubview:firstImage];
    
    UIImageView *secondImage = [[UIImageView alloc] init];
    secondImage.frame = self.view.bounds;
    secondImage.left = firstImage.right;
    secondImage.width = width;
    secondImage.height = height;
    secondImage.backgroundColor = [UIColor yellowColor];
    [self.horizonScrollView addSubview:secondImage];
    
    self.horizonScrollView.contentSize = CGSizeMake(2 * width, height);
    
    self.verticalScrollView = [[UIScrollView alloc] init];
    self.verticalScrollView.frame = self.view.bounds;
    self.verticalScrollView.pagingEnabled = YES;
    self.verticalScrollView.bounces = NO;
    
    
    UIImageView *thirdImage = [[UIImageView alloc] init];
    thirdImage.top = self.view.bottom - 64;
    thirdImage.width = width;
    thirdImage.height = height;
    thirdImage.backgroundColor = [UIColor grayColor];
    [self.verticalScrollView addSubview:thirdImage];
    
    
    
    self.verticalScrollView.contentSize = CGSizeMake(width, 2 * height);
    
    [self.verticalScrollView addSubview:self.horizonScrollView];
    [self.view addSubview:self.verticalScrollView];
//    [self.widthScrollView addSubview:self.heightScrollView];
//    [self.view addSubview:self.widthScrollView];
}

- (void)presentedFromViewController:(UIViewController *)viewController
                         completion:(void (^)(void))completion
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    nav.navigationBar.barStyle = UIBarStyleBlack;
    nav.navigationBar.tintColor = [UIColor whiteColor];
    
    [viewController presentViewController:nav animated:YES completion:^{
        if (completion) {
            completion();
        }
    }];
     
}

- (void)tapWidthScrollView:(id)sender
{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    [UIView animateWithDuration:0.3 animations:^{
        if (self.isHidden) {
            navBar.top = 0;
        }else{
            navBar.top = -navBar.height;
        }
    } completion:^(BOOL finished) {
        self.isHidden = !self.isHidden;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.verticalScrollView) {
        CGFloat height = scrollView.bounds.size.height;
        CGFloat position = MAX(scrollView.contentOffset.y, 0.0);
        CGFloat offsetY = scrollView.contentOffset.y;
        self.blurredImageView.top = offsetY;
        UIImageView *currentImageView = _reuseImageViewArray[_currentReuseIndex];
        currentImageView.top = offsetY;
        
        CGFloat percent = MIN(position / height, 1.0);
        self.blurredImageView.alpha = percent;
//        currentImageView.alpha = 1-percent;
    } else if (scrollView == self.horizonScrollView) {
        if (_preloading) return;
        
        
        // Calculate current page
//        CGRect visibleBounds = self.horizonScrollView.bounds;
//        NSInteger index = (NSInteger)(floorf(CGRectGetMidX(visibleBounds) / CGRectGetWidth(visibleBounds)));
//        if (index < 0) index = 0;
//        if (index > [_delegate numberOfPhotosInPhotoBrowser:self] - 1) index = [_delegate numberOfPhotosInPhotoBrowser:self] - 1;
//        NSLog(@"%d, %f, %f", index, CGRectGetMidX(visibleBounds), CGRectGetWidth(visibleBounds));
//        _currentPhotoIndex = index;
//        _currentReuseIndex = index;
//        NSLog(@"pindex:%d, rindex:%d", _currentPhotoIndex, _currentReuseIndex);
        
//        CGFloat offsetX = scrollView.contentOffset.x;
//        NSInteger index = offsetX / WIDTH_PAGE;
//        if (index != _currentPhotoIndex) {
//            _currentPhotoIndex = index;
//            _currentReuseIndex = index;
//            
//            [scrollView setContentOffset:CGPointMake(index * WIDTH_PAGE, 0) animated:YES];
//            NSLog(@"diff index");
//        } else {
//            NSLog(@"same index");
//        }
        
//        NSLog(@"pindex:%d, rindex:%d", _currentPhotoIndex, _currentReuseIndex);
        
//        NSUInteger previousCurrentPage = _currentPageIndex;
//        _currentPageIndex = index;
//        if (_currentPageIndex != previousCurrentPage) {
//            [self didStartViewingPageAtIndex:index];
//        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.horizonScrollView) {
        
        NSLog(@"%@", NSStringFromCGRect(scrollView.bounds));
        CGFloat offsetX = scrollView.contentOffset.x;
        NSUInteger index = offsetX / WIDTH_PAGE;
        
        if (_currentPhotoIndex != index) {
            UIImageView *currentDisplayImage = _reuseImageViewArray[index];
            NSLog(@"index1:%d, %@",index, NSStringFromCGRect(currentDisplayImage.frame));
//            currentDisplayImage.left += PADDING;
             NSLog(@"index2:%d, %@",index, NSStringFromCGRect(currentDisplayImage.frame));
        }
        _currentPhotoIndex = offsetX / WIDTH_PAGE;
        _currentReuseIndex = offsetX / WIDTH_PAGE;
        
        
//        NSLog(@"pindex:%d, rindex:%d", _currentPhotoIndex, _currentReuseIndex);
//
//        [self reloadBluredImage];
    }
}

- (void)back:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
