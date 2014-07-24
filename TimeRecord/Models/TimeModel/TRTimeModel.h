//
//  TRTimeModel.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRTimePhotoModel.h"

@interface TRTimeModel : NSObject

@property (nonatomic, copy) NSString *timeID;
@property (nonatomic, strong) TRTimePhotoModel *timeHomePhoto;

// TRTimePhotoModel
@property (nonatomic, strong) NSMutableArray *timePhotos;

@end
