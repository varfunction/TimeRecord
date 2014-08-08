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
#import "DWTagList.h"
#import "TRTimeTagListView.h"

@interface TRTimeTagTableCell : UITableViewCell
@end

@implementation TRTimeTagTableCell

- (void)setContent:(TRTimeModel *)model
{
//    // Initalise and set the frame of the tag list
//    DWTagList *tagList = [[DWTagList alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    
//    tagList.showTagMenu = YES;
//    tagList.font = [UIFont systemFontOfSize:18];
//    tagList.labelMargin = 20;
//    tagList.horizontalPadding = 20;
//    tagList.verticalPadding = 20;
//    
//    // Add the items to the array
//    NSArray *array = [[NSArray alloc] initWithObjects:@"Foo", @"Tag Label 1", @"Tag Label 2", @"Tag Label 3", @"Tag Label 4", @"Tag Label 5", @"Tag Label 1", @"Tag Label 2", @"Tag Label 3", @"Tag Label 4", @"Tag Label 5", @"Tag Label 1", @"Tag Label 2", @"Tag Label 3", @"Tag Label 4", @"Tag Label 5", @"Tag Label 1", @"Tag Label 2", @"Tag Label 3", @"Tag Label 4", @"Tag Label 5", @"Tag Label 1", @"Tag Label 2", @"Tag Label 3", @"Tag Label 4", @"Tag Label 5", @"Tag Label 1", @"Tag Label 2", @"Tag Label 3", @"Tag Label 4", @"Tag Label 5", @"Tag Label 1", @"Tag Label 2", @"Tag Label 3", @"Tag Label 4", @"Tag Label 5", @"Tag Label 1", @"Tag Label 2", @"Tag Label 3", @"Tag Label 4", @"Tag Label 5", nil];
//    [tagList setTags:array];
    
    TRTimeTagListView *tagList = [[TRTimeTagListView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    tagList.verticalLabelMargin = 5;
    tagList.horizonLabelMargin = 5;
    
    for (int i = 0; i < 100; i++) {
        TRTimeTagView *view = [[TRTimeTagView alloc] initWithTitle:[NSString stringWithFormat:@"%d", i] font:[UIFont systemFontOfSize:13] padding:CGSizeMake(5, 5) maxWidth:300 minWidth:60];
        [tagList pushTag:view];
    }
    
    // Add the taglist to your UIView
    [self.contentView addSubview:tagList];
}

@end

@interface TRTimeTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UILabel *timeTitle;
@property (weak, nonatomic) IBOutlet UILabel *timeDesc;

@property (strong, nonatomic) TRTimeModel *model;

@end

@implementation TRTimeTableCell

- (void)setContent:(TRTimeModel *)model
{
    int rand =  arc4random() % 4;
    UIColor *color = [UIColor brownColor];
    switch (rand) {
        case 0:
            color = [UIColor colorWithHexString:@"#91d180"];
            break;
        case 1:
            color = [UIColor colorWithHexString:@"#81b0f1"];
            break;
        case 2:
            color = [UIColor colorWithHexString:@"#f1d038"];
            break;
        case 3:
            color = [UIColor colorWithHexString:@"#ff5d73"];
            break;
        default:
            break;
    }
    
    self.timeView.backgroundColor = color;
    
    self.timeView.layer.borderWidth = 2.0;
    self.timeView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.timeView.layer.cornerRadius = 5;
    
//    self.timeView.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.timeView.layer.shadowOpacity = 0.8;
//    self.timeView.layer.shadowRadius = 5.0;
//    self.timeView.layer.shadowOffset = CGSizeMake(0, 1);
    
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
    
//    [self.tableView setPagingEnabled:YES];
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
    
//    TRTimeTagTableCell *cell = (TRTimeTagTableCell *)[tableView dequeueReusableCellWithIdentifier:@"RUID_TRTimeTagTableCell" forIndexPath:indexPath];
//    TRTimeModel *timeModel = [TRTimeManager sharedInstance].allTime[indexPath.row];
//    
//    [cell setContent:timeModel];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
//    return tableView.frame.size.height - 49 - 44 - 20;//[self.tabBarController tabBar].frame.size.height;
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
        vc.timeID = timeModel.timeID;
        vc.timeTitle = timeModel.timeHomePhoto.photoTitle;
        vc.timeDesc = timeModel.timeHomePhoto.photoDesc;
        vc.timeTags = [NSMutableArray arrayWithArray:timeModel.timeHomePhoto.photoTag];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
