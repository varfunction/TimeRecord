//
//  TRPhotoTagViewController.m
//  TimeRecord
//
//  Created by ocean tang on 14-7-23.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRPhotoTagViewController.h"

@interface TRPhotoTagViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TRPhotoTagViewController

+ (instancetype)instantiate
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PhotoTag" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"SBID_TRPhotoTagViewController"];
}

- (void)awakeFromNib
{
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView.image = self.image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textView resignFirstResponder];
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
