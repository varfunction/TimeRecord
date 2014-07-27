//
//  TRPhotoPickerModel.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-25.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MWPhoto.h>

@interface TRPhotoPickerModel : NSObject

@property (nonatomic, strong) MWPhoto *thumbPhoto;
@property (nonatomic, strong) MWPhoto *originPhoto;

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) NSDate *date;

@end
