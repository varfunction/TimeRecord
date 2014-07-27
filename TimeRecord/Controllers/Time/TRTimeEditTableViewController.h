//
//  TRTimeEditViewController.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-25.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MWPhotoBrowser.h>

@interface TRTimeEditTableViewController : UITableViewController <UICollectionViewDelegate, UICollectionViewDataSource, MWPhotoBrowserDelegate>
@property (nonatomic, copy) NSString *timeID;

@property (nonatomic, strong) NSURL *timeImage;
@property (nonatomic, copy) NSString *timeTitle;
@property (nonatomic, copy) NSString *timeDesc;

// NSString
@property (nonatomic, copy) NSMutableArray *timeTags;

// TRPhotoPickerModel
@property (nonatomic, strong) NSMutableArray *selectedModels;

@end
