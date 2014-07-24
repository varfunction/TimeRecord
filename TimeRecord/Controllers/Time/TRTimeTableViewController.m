//
//  TRTimeTableViewController.m
//  TimeRecord
//
//  Created by ocean tang on 14-7-23.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRTimeTableViewController.h"
#import "TRImagePicker.h"
#import "TRPhotoTagViewController.h"

@interface TRTimeTableCell : UITableViewCell

@end

@implementation TRTimeTableCell

@end

@interface TRTimeTableViewController ()

@end

@implementation TRTimeTableViewController

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:(UIBarButtonItemStylePlain) target:self action:@selector(didPressedRightBarButton)];
}

- (void)didPressedRightBarButton
{
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    picker.delegate = self;
//    [self presentViewController:picker animated:YES completion:NULL];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    TRSystemAlbumPicker *systemAlbumPicker = [TRSystemAlbumPicker pickerWithImagePickerController:picker];
    [systemAlbumPicker presentInViewController:self.navigationController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RUID_TRTimeTableCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"info = %@", info);
    [picker dismissViewControllerAnimated:YES completion:NULL];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    TRPhotoTagViewController *tag = [TRPhotoTagViewController instantiate];
    tag.image = image;
    [self.navigationController pushViewController:tag animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
