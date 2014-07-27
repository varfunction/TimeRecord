//
//  TRTimeManager.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRTimeModel.h"
#import "TRTimePhotoModel.h"

static NSString *NOTIFICATION_NAME_CREATE_TIME_COMPLETE = @"NOTIFICATION_NAME_CREATE_TIME_COMPLETE";

@interface TRTimeManager : NSObject

// TRTimeModel
@property (nonatomic, strong) NSMutableArray *allTime;

+ (instancetype)sharedInstance;

- (TRTimeModel *)createEmptyTime;

- (void)saveTimeForTimeID:(NSString *)timeID photos:(NSMutableArray *)photosArray;

@end
