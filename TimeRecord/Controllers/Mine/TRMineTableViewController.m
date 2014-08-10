//
//  TRMineTableViewController.m
//  TimeRecord
//
//  Created by ocean tang on 14-7-23.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRMineTableViewController.h"
#import "TRPhotoBrowser.h"

@interface TRMineTableViewController ()

@property (nonatomic, strong) NSMutableArray *srcArray;

@end

@implementation TRMineTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:(UIBarButtonItemStylePlain) target:self action:@selector(didPressedRightBarButton)];
    
    self.srcArray = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++) {
        if (i%3 == 0) {
            UIImage *image = [UIImage imageNamed:@"1-image.png"];
            [self.srcArray addObject:image];
        } else if (i%3 == 1) {
            UIImage *image = [UIImage imageNamed:@"2-image.png"];
            [self.srcArray addObject:image];
        } else if (i%3 == 2) {
            UIImage *image = [UIImage imageNamed:@"3-image.png"];
            [self.srcArray addObject:image];
        }
    }
}

- (void)didPressedRightBarButton
{
    //    CATransition *transition=[CATransition animation];
    //    transition.timingFunction=UIViewAnimationCurveEaseInOut;
    //    transition.duration=0.4;
    //    transition.type=kCATransitionMoveIn;
    //    transition.type=kCATransitionPush;
    //    transition.subtype=kCATransitionFromRight;
    //    [browser.view.layer addAnimation:transition forKey:nil];
    TRPhotoBrowser *browser = [[TRPhotoBrowser alloc] initWithDelegate:self];
    browser.view.frame = self.view.frame;
    
    [browser presentedFromViewController:self completion:^{
        
    }];
}

- (void)dealloc
{
    
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(TRPhotoBrowser *)photoBrowser
{
    return self.srcArray.count;
}

- (UIImage *)photoBrowser:(TRPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    return self.srcArray[index];
}

- (NSString *)photoBrowser:(TRPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index
{
    return @"title";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
