//
//  TRTimeCreateTableViewController.m
//  TimeRecord
//
//  Created by ocean tang on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRTimeCreateTableViewController.h"
#import "TRTimeManager.h"

@interface TRTimeCreateTableViewController ()

@end

@implementation TRTimeCreateTableViewController

+ (instancetype)instantiate
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Time" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"SBID_TRTimeCreateTableViewController"];
}

- (void)awakeFromNib
{
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleBordered) target:self action:@selector(dismissController)];
}

- (void)dismissController
{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressedCreateEmptyTime:(id)sender
{
    TRTimeManager *manager = [TRTimeManager sharedInstance];
    [manager createEmptyTime];
    [self dismissController];
}

@end
