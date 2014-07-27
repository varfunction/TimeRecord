//
//  TRPhotoPickerManager.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRTimeModel.h"
#import "TRTimePhotoModel.h"
#import "TRPhotoPickerModel.h"

static NSString *NOTIFICATION_NAME_LOAD_SYSTEM_PHOTO_COMPLETE = @"NOTIFICATION_NAME_LOAD_SYSTEM_PHOTO_COMPLETE";

@interface TRPhotoPickerManager : NSObject

// TRPhotoPickerModel
@property (nonatomic, strong) NSMutableArray *systemPhotos;

+ (instancetype)sharedInstance;

- (void)loadSystemAlbumPhoto;

@end
