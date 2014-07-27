//
//  TRTimeTableViewController.m
//  TimeRecord
//
//  Created by ocean tang on 14-7-23.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRTimeTableViewController.h"
#import "TRPhotoPicker.h"
#import "TRPhotoTagViewController.h"
#import "TRTimeEditTableViewController.h"
#import "TRTimeManager.h"
#import "TRPhotoBrowserDelegate.h"
#import "TRPhotoPickerDelegate.h"
#import "TRPhotoPickerManager.h"

@interface TRTimeTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UILabel *timeTitle;
@property (weak, nonatomic) IBOutlet UILabel *timeDesc;

@property (strong, nonatomic) TRTimeModel *model;

@end

@implementation TRTimeTableCell

- (void)setContent:(TRTimeModel *)model
{
    self.timeView.layer.borderWidth = 1.0;
    self.timeView.layer.borderColor = [[UIColor clearColor] CGColor];
    self.timeView.layer.cornerRadius = 10;
    
    self.timeView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.timeView.layer.shadowOpacity = 0.8;
    self.timeView.layer.shadowRadius = 10.0;
    self.timeView.layer.shadowOffset = CGSizeMake(0, 1);
    
    self.model = model;
    self.timeTitle.text = model.timeHomePhoto.photoTitle;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
//    [super setHighlighted:highlighted animated:animated];
}

@end

@interface TRTimeTableViewController ()

@property (strong, nonatomic) TRPhotoBrowserDelegate *photoBrowserDelegate;
@property (strong, nonatomic) TRPhotoPickerDelegate *photoPickerDelegate;
@property (strong, nonatomic) TRTimeModel *currentSelectedTime;

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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NOTIFICATION_NAME_CREATE_TIME_COMPLETE
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshView:)
                                                 name:NOTIFICATION_NAME_CREATE_TIME_COMPLETE
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NOTIFICATION_NAME_PICK_PHOTO_COMPLETE
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(openPhotoTagViewController:)
                                                 name:NOTIFICATION_NAME_PICK_PHOTO_COMPLETE
                                               object:nil];
    
    [[TRPhotoPickerManager sharedInstance] loadSystemAlbumPhoto];
    
    self.photoBrowserDelegate = [[TRPhotoBrowserDelegate alloc] init];
    self.photoPickerDelegate = [[TRPhotoPickerDelegate alloc] init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:(UIBarButtonItemStylePlain) target:self action:@selector(didPressedRightBarButton)];
}

- (void)refreshView:(NSNotification *)sender
{
    [self.tableView reloadData];
}

- (void)openPhotoTagViewController:(NSNotification *)sender
{
    UIImage *selectedImage = (UIImage *)[sender.userInfo objectForKey:NOTIFICATION_USERINFO_PICK_PHOTO];
    NSURL *url = (NSURL *)[sender.userInfo objectForKey:NOTIFICATION_USERINFO_PICK_PHOTO_URL];
    NSArray *location = (NSArray *)[sender.userInfo objectForKey:NOTIFICATION_USERINFO_PICK_PHOTO_LOCATION];
    TRPhotoTagViewController *tag = [TRPhotoTagViewController instantiate];
    tag.timeModel = self.currentSelectedTime;
    tag.selectedImage = selectedImage;
    tag.selectedImageURL = url;
    tag.locationArray = location;
    [self.navigationController pushViewController:tag animated:YES];
}

- (void)didPressedRightBarButton
{
    [[TRTimeManager sharedInstance] createEmptyTime];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [TRTimeManager sharedInstance].allTime.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRTimeTableCell *cell = (TRTimeTableCell *)[tableView dequeueReusableCellWithIdentifier:@"RUID_TRTimeTableCell" forIndexPath:indexPath];
    TRTimeModel *timeModel = [TRTimeManager sharedInstance].allTime[indexPath.row];
    
    [cell setContent:timeModel];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TRTimeModel *timeModel = [TRTimeManager sharedInstance].allTime[indexPath.row];
    self.currentSelectedTime = timeModel;
    
    if (timeModel.timePhotos.count > 0) {
        // 浏览照片
        self.photoBrowserDelegate.photos = [NSMutableArray arrayWithCapacity:timeModel.timePhotos.count];
        for (TRTimePhotoModel *photo in timeModel.timePhotos) {
            [self.photoBrowserDelegate.photos addObject:[MWPhoto photoWithURL:photo.originPhotoURL]];
        }
        
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self.photoBrowserDelegate];
        
        [self.navigationController pushViewController:browser animated:YES];
    } else {
        // 新增照片
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//        picker.delegate = self.photoPickerDelegate;
//        TRSystemAlbumPicker *systemAlbumPicker = [TRSystemAlbumPicker pickerWithImagePickerController:picker];
//        [systemAlbumPicker presentInViewController:self.navigationController];
        TRTimeEditTableViewController *vc = [TRTimeEditTableViewController instantiate];
        vc.timeTitle = timeModel.timeHomePhoto.photoTitle;
        vc.timeDesc = timeModel.timeHomePhoto.photoDesc;
        vc.timeTags = [NSMutableArray arrayWithArray:timeModel.timeHomePhoto.photoTag];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
