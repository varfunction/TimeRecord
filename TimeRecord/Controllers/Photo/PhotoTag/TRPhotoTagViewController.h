//
//  TRPhotoTagViewController.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-23.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRTimeModel.h"

@interface TRPhotoTagViewController : UITableViewController

@property (nonatomic, strong) TRTimeModel *timeModel;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) NSURL *selectedImageURL;
@property (nonatomic, strong) NSArray *locationArray;


@end
