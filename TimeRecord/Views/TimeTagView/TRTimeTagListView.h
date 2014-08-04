//
//  TRTimeTagView.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-28.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRTimeTagView : UIView

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;

- (void)updateWithString:(NSString*)text
                    font:(UIFont*)font
      constrainedToWidth:(CGFloat)maxWidth
                 padding:(CGSize)padding
            minimumWidth:(CGFloat)minimumWidth;
- (void)setLabelText:(NSString*)text;
- (void)setCornerRadius:(CGFloat)cornerRadius;
- (void)setBorderColor:(CGColorRef)borderColor;
- (void)setBorderWidth:(CGFloat)borderWidth;
- (void)setTextColor:(UIColor*)textColor;
- (void)setTextShadowColor:(UIColor*)textShadowColor;
- (void)setTextShadowOffset:(CGSize)textShadowOffset;

@end

@interface TRTimeTagListView : UIScrollView

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) CGFloat horizonLabelMargin;
@property (nonatomic, assign) CGFloat verticalLabelMargin;
@property (nonatomic, assign) CGFloat bottomMargin;
@property (nonatomic, assign) CGFloat horizontalPadding;
@property (nonatomic, assign) CGFloat verticalPadding;
@property (nonatomic, assign) CGFloat minimumWidth;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGColorRef borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *textShadowColor;
@property (nonatomic, assign) CGSize textShadowOffset;
@property (nonatomic, strong) UIColor *highlightedBackgroundColor;

- (void)pushTag:(TRTimeTagView *)tag;

- (void)insertTag:(TRTimeTagView *)tag atIndex:(NSUInteger)index;

- (void)removeTagAtIndex:(NSUInteger)index;

- (void)replaceTagAtIndex:(NSUInteger)index withTag:(TRTimeTagView *)tag;

@end


