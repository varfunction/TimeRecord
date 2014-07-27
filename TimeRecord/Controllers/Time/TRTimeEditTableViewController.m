//
//  TRTimeEditViewController.m
//  TimeRecord
//
//  Created by ocean tang on 14-7-25.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRTimeEditTableViewController.h"
#import "TRTimeEditManager.h"
#import "TRPhotoPickerManager.h"
#import "TRPhotoEditTableViewController.h"

@interface TRTimeEditCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;

@end

@implementation TRTimeEditCell

@end

@interface TRTimeEditTableViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *timeImageView;
@property (weak, nonatomic) IBOutlet UITextField *timeTitleView;
@property (weak, nonatomic) IBOutlet UITextView *timeDescView;
@property (weak, nonatomic) IBOutlet UILabel *timeTagView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation TRTimeEditTableViewController 

+ (instancetype)instantiate
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Time" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"SBID_TRTimeEditTableViewController"];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.selectedModels = [NSMutableArray array];
    
    for (TRPhotoPickerModel *model in self.selectedModels) {
        TRTimePhotoModel *timePhoto = [[TRTimePhotoModel alloc] init];
        timePhoto.thumbPhoto = model.thumbPhoto.image;
        timePhoto.originPhotoURL = model.originPhoto.photoURL;
        timePhoto.photoLocation = model.location;
        timePhoto.photoDate = model.date;
        
        [[TRTimeEditManager sharedInstance].editPhotos addObject:timePhoto];
    }
    
    self.timeTitleView.text = self.timeTitle;
    self.timeDescView.text = self.timeDesc;
    self.timeTagView.text = [self.timeTags firstObject];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectedModels.count + 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == [collectionView numberOfItemsInSection:indexPath.section]-1) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RUID_TRTimeEditCell_ADD" forIndexPath:indexPath];
        return cell;
    } else {
        TRTimeEditCell *cell = (TRTimeEditCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"RUID_TRTimeEditCell" forIndexPath:indexPath];
        TRTimePhotoModel *timePhoto = ([TRTimeEditManager sharedInstance].editPhotos)[indexPath.item];
        cell.thumbImageView.image = timePhoto.thumbPhoto;
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:@"RUID_TRTimeEditCell_ADD"]) {
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        browser.enableGrid = YES;
        browser.startOnGrid = YES;
        browser.displaySelectionButtons = YES;
        
        [self.navigationController pushViewController:browser animated:YES];
    } else {
        TRPhotoEditTableViewController *vc = [TRPhotoEditTableViewController instantiate];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark MWPhotoBrowser
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return [TRPhotoPickerManager sharedInstance].systemPhotos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < [TRPhotoPickerManager sharedInstance].systemPhotos.count) {
        TRPhotoPickerModel *model = [[TRPhotoPickerManager sharedInstance].systemPhotos objectAtIndex:index];
        return model.originPhoto;
    }
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index
{
    if (index < [TRPhotoPickerManager sharedInstance].systemPhotos.count) {
        TRPhotoPickerModel *model = [[TRPhotoPickerManager sharedInstance].systemPhotos objectAtIndex:index];
        return model.thumbPhoto;
    }
    return nil;
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    NSMutableArray *systemPhotos = [TRPhotoPickerManager sharedInstance].systemPhotos;
    TRPhotoPickerModel *model = [systemPhotos objectAtIndex:index];
    if ([self isSelectedURL:model.originPhoto.photoURL]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isSelectedURL:(NSURL *)url
{
    for (TRPhotoPickerModel *model in self.selectedModels) {
        NSString *modelUrl = [model.originPhoto.photoURL absoluteString];
        if ([modelUrl isEqualToString:[url absoluteString]]) {
            return YES;
        }
    }
    return NO;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    TRPhotoPickerModel *model = [[TRPhotoPickerManager sharedInstance].systemPhotos objectAtIndex:index];
    [self.selectedModels addObject:model];
    
    TRTimePhotoModel *timePhoto = [[TRTimePhotoModel alloc] init];
    timePhoto.thumbPhoto = model.thumbPhoto.image;
    timePhoto.originPhotoURL = model.originPhoto.photoURL;
    timePhoto.photoLocation = model.location;
    timePhoto.photoDate = model.date;
    
    [[TRTimeEditManager sharedInstance].editPhotos addObject:timePhoto];
}

@end
