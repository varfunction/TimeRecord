//
//  TRPhotoPickerDelegate.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRTimeModel.h"

static NSString *NOTIFICATION_NAME_PICK_PHOTO_COMPLETE = @"NOTIFICATION_NAME_PICK_PHOTO_COMPLETE";
static NSString *NOTIFICATION_USERINFO_PICK_PHOTO = @"NOTIFICATION_USERINFO_PICK_PHOTO";
static NSString *NOTIFICATION_USERINFO_PICK_PHOTO_URL = @"NOTIFICATION_USERINFO_PICK_PHOTO_URL";
static NSString *NOTIFICATION_USERINFO_PICK_PHOTO_LOCATION = @"NOTIFICATION_USERINFO_PICK_PHOTO_LOCATION";
static NSString *NOTIFICATION_USERINFO_PICK_PHOTO_DATE = @"NOTIFICATION_USERINFO_PICK_PHOTO_DATE";

@interface TRPhotoPickerDelegate : NSObject <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) TRTimeModel *timeModel;

@end
