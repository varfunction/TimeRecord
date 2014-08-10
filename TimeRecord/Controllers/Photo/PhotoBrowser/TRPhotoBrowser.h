//
//  TRPhotoBrowser.h
//  TimeRecord
//
//  Created by ocean tang on 14-8-8.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TRPhotoBrowser;

@protocol TRPhotoBrowserDelegate <NSObject>

- (NSUInteger)numberOfPhotosInPhotoBrowser:(TRPhotoBrowser *)photoBrowser;
- (UIImage *)photoBrowser:(TRPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index;
- (NSString *)photoBrowser:(TRPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index;

@optional

//- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index;
//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index;
//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index;
//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index;
//- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index;
//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected;
//- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser;

@end

@interface TRPhotoBrowser : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) id<TRPhotoBrowserDelegate> delegate;

- (id)initWithDelegate:(id <TRPhotoBrowserDelegate>)delegate;

- (void)presentedFromViewController:(UIViewController *)viewController
                         completion:(void (^)(void))completion;

@end
