//
//  TRPhotoBrowser.m
//  TimeRecord
//
//  Created by ocean tang on 14-8-8.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRPhotoBrowser.h"

@interface TRPhotoBrowser ()

@property (nonatomic, assign) BOOL isHidden;
@property (nonatomic, strong) UIScrollView *heightScrollView;
@property (nonatomic, strong) UIScrollView *widthScrollView;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(back:)];
    
    CGFloat width = self.view.width;
    CGFloat height = self.view.height - 64;
    
    self.widthScrollView = [[UIScrollView alloc] init];
    self.widthScrollView.frame = self.view.bounds;
    self.widthScrollView.pagingEnabled = YES;
    self.widthScrollView.bounces = NO;
    
    
    UIImageView *firstImage = [[UIImageView alloc] init];
    firstImage.frame = self.view.bounds;
    firstImage.width = width;
    firstImage.height = height;
    firstImage.backgroundColor = [UIColor greenColor];
    [self.widthScrollView addSubview:firstImage];
    
    UIImageView *secondImage = [[UIImageView alloc] init];
    secondImage.frame = self.view.bounds;
    secondImage.left = firstImage.right;
    secondImage.width = width;
    secondImage.height = height;
    secondImage.backgroundColor = [UIColor yellowColor];
    [self.widthScrollView addSubview:secondImage];
    
    self.widthScrollView.contentSize = CGSizeMake(2 * width, height);
    
    self.heightScrollView = [[UIScrollView alloc] init];
    self.heightScrollView.frame = self.view.bounds;
    self.heightScrollView.pagingEnabled = YES;
    self.heightScrollView.bounces = NO;
    
    
    UIImageView *thirdImage = [[UIImageView alloc] init];
    thirdImage.top = self.view.bottom - 64;
    thirdImage.width = width;
    thirdImage.height = height;
    thirdImage.backgroundColor = [UIColor grayColor];
    [self.heightScrollView addSubview:thirdImage];
    
    self.heightScrollView.contentSize = CGSizeMake(width, 2 * height);
    
    [self.view addSubview:self.heightScrollView];
    [self.heightScrollView addSubview:self.widthScrollView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    [UIView animateWithDuration:0.3 animations:^{
        if (self.isHidden) {
            navBar.top = 20;
        }else{
            navBar.top = -navBar.height;
        }
    } completion:^(BOOL finished) {
        self.isHidden = !self.isHidden;
    }];
}

- (void)back:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
