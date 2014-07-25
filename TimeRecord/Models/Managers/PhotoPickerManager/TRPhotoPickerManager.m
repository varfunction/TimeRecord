//
//  TRPhotoPickerManager.m
//  TimeRecord
//
//  Created by ocean tang on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRPhotoPickerManager.h"
#import "TRLevelDB.h"

@interface TRPhotoPickerManager ()

@property (nonatomic, weak) TRLevelDB *levelDB;
@property (nonatomic, strong) ALAssetsLibrary *library;

@end

@implementation TRPhotoPickerManager

+ (instancetype)sharedInstance
{
    static TRPhotoPickerManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TRPhotoPickerManager alloc] init];
        instance.systemPhotos = [NSMutableArray array];
    });
    
    return instance;
}

- (void)loadSystemAlbumPhoto;
{
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self);
        self.library = [[ALAssetsLibrary alloc] init];
        //Load Photo
        [self.library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            NSLog(@"group = %@, stop = %d", group, *stop);
            if (group) {
                [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    if (result) {
                        NSString *type = [result valueForProperty:ALAssetPropertyType];
                        if ([type isEqualToString:ALAssetTypePhoto]) {
                            NSURL *url= [result valueForProperty:ALAssetPropertyAssetURL];
                            NSDate *date = [result valueForProperty:ALAssetPropertyDate];
                            CLLocation *location = [result valueForProperty:ALAssetPropertyLocation];
                            
                            TRPhotoPickerModel *model = [[TRPhotoPickerModel alloc] init];
                            model.thumbPhoto = [MWPhoto photoWithImage:[UIImage imageWithCGImage:result.thumbnail]];
                            model.originPhoto = [MWPhoto photoWithURL:url];
                            model.location = location;
                            model.date = date;
                            model.selected = NO;
                            [self.systemPhotos addObject:model];
//                            [self.systemPhotos addObject:url];
                        }
                    }
                }];
            } else {
                *stop = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME_LOAD_SYSTEM_PHOTO_COMPLETE object:self userInfo:nil];                    
                });
            }
//            if (group == nil) {
//                *stop = YES;
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.collectionView reloadData];
//                }) ;
//            }
        } failureBlock:^(NSError *error) {
            NSAssert(false, @"error");
        }];
    });
}

@end
