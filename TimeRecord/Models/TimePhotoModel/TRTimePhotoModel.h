//
//  TRTimePhotoModel.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRTimePhotoModel : NSObject

@property (nonatomic, copy) NSString *photoTitle;
@property (nonatomic, copy) NSString *photoDesc;
@property (nonatomic, strong) NSURL *originPhotoURL;
@property (nonatomic, strong) UIImage *thumbPhoto;

// NSString
@property (nonatomic, strong) NSArray *photoTag;

@property (nonatomic, copy) CLLocation *photoLocation;

@property (nonatomic, strong) NSDate *photoDate;

@end
