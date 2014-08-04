//
//  TRTimeTagView.m
//  TimeRecord
//
//  Created by ocean tang on 14-7-28.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRTimeTagListView.h"

#define CORNER_RADIUS 10.0f
#define LABEL_MARGIN_DEFAULT 5.0f
#define BOTTOM_MARGIN_DEFAULT 5.0f
#define FONT_SIZE_DEFAULT 13.0f
#define HORIZONTAL_PADDING_DEFAULT 7.0f
#define VERTICAL_PADDING_DEFAULT 3.0f
#define BACKGROUND_COLOR [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00]
#define TEXT_COLOR [UIColor blackColor]
#define TEXT_SHADOW_COLOR [UIColor whiteColor]
#define TEXT_SHADOW_OFFSET CGSizeMake(1.0f, 1.0f)
#define BORDER_COLOR [UIColor lightGrayColor].CGColor
#define BORDER_WIDTH 1.0f
#define HIGHLIGHTED_BACKGROUND_COLOR [UIColor colorWithRed:0.40 green:0.80 blue:1.00 alpha:0.5]
#define DEFAULT_AUTOMATIC_RESIZE NO
#define DEFAULT_SHOW_TAG_MENU NO

@interface TRTimeTagListView ()

// TRTagView
@property (nonatomic, strong) NSMutableArray *timeTags;

@end

@implementation TRTimeTagListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        self.timeTags = [NSMutableArray array];
    }
    return self;
}

- (void)pushTag:(TRTimeTagView *)tag
{
    [_timeTags insertObject:tag atIndex:0];
    [self addSubview:tag];
}

- (void)insertTag:(TRTimeTagView *)tag atIndex:(NSUInteger)index
{
    [_timeTags insertObject:tag atIndex:index];
    [self addSubview:tag];
}

- (void)removeTagAtIndex:(NSUInteger)index
{
    TRTimeTagView *tag = [_timeTags objectAtIndex:index];
    [tag removeFromSuperview];
    [_timeTags removeObjectAtIndex:index];
}

- (void)replaceTagAtIndex:(NSUInteger)index withTag:(TRTimeTagView *)tag
{
    TRTimeTagView *tagBefore = [_timeTags objectAtIndex:index];
    [tagBefore removeFromSuperview];
    [_timeTags removeObjectAtIndex:index];
    [self addSubview:tag];
    [_timeTags insertObject:tag atIndex:index];
}

- (void)resizeAllRect
{
    CGRect prevRect = CGRectZero;
    for (int i = 0; i < _timeTags.count; i++) {
        TRTimeTagView *curTag = _timeTags[i];
        CGFloat prevRight = prevRect.origin.x + prevRect.size.width;
        CGFloat prevBottom = prevRect.origin.y + prevRect.size.height;
        if (prevRight + _horizonLabelMargin + curTag.width + _horizonLabelMargin > self.width) {
            // new line
            CGRect tempRect = CGRectMake(_horizonLabelMargin, (prevBottom + _verticalLabelMargin), curTag.width, curTag.height);
            curTag.frame = tempRect;
        } else {
            // append
            CGRect tempRect = CGRectMake(prevRight + _horizonLabelMargin, prevRect.origin.y, curTag.width, curTag.height);
            curTag.frame = tempRect;
        }
        prevRect = curTag.frame;
    }
}

- (void)display
{
    
    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = NO;
    
    for (TRTimeTagView *tagView in self.timeTags) {
        
        
        [tagView updateWithString:@"111111"
                             font:[UIFont systemFontOfSize:15]
               constrainedToWidth:self.frame.size.width - (5 * 2)
                          padding:CGSizeMake(5, 5)
                     minimumWidth:100
         ];
        
        if (gotPreviousFrame) {
            CGRect newRect = CGRectZero;
            if (previousFrame.origin.x + previousFrame.size.width + tagView.frame.size.width + 5 > self.frame.size.width) {
                newRect.origin = CGPointMake(0, previousFrame.origin.y + tagView.frame.size.height + 5);
            } else {
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + 5, previousFrame.origin.y);
            }
            newRect.size = tagView.frame.size;
            [tagView setFrame:newRect];
        }
        
        previousFrame = tagView.frame;
        gotPreviousFrame = YES;
        
        //        [tagView setBackgroundColor:[self getBackgroundColor]];
        [tagView setCornerRadius:5];
        [tagView setBorderColor:BORDER_COLOR];
        [tagView setBorderWidth:1];
        [tagView setTextColor:[UIColor whiteColor]];
        [tagView setTextShadowColor:[UIColor brownColor]];
        [tagView setTextShadowOffset:TEXT_SHADOW_OFFSET];
        

        [tagView.button addTarget:self action:@selector(touchDownInside:) forControlEvents:UIControlEventTouchDown];
        [tagView.button addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [tagView.button addTarget:self action:@selector(touchDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [tagView.button addTarget:self action:@selector(touchDragInside:) forControlEvents:UIControlEventTouchDragInside];

    }
    self.contentSize = CGSizeMake(self.frame.size.width, previousFrame.origin.y + previousFrame.size.height + 5 + 1.0f);
}

- (void)touchDownInside:(id)sender
{
    UIButton *button = (UIButton*)sender;
}

- (void)touchUpInside:(id)sender
{
    UIButton *button = (UIButton*)sender;
    TRTimeTagView *tagView = (TRTimeTagView *)[button superview];
//    [tagView setBackgroundColor:[self getBackgroundColor]];
//    
//    if ([self.tagDelegate respondsToSelector:@selector(selectedTag:tagIndex:)]) {
//        [self.tagDelegate selectedTag:tagView.label.text tagIndex:tagView.tag];
//    }
//    
//    if ([self.tagDelegate respondsToSelector:@selector(selectedTag:)]) {
//        [self.tagDelegate selectedTag:tagView.label.text];
//    }
    

        UIMenuController *menuController = [UIMenuController sharedMenuController];
        UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(test:)];
        menuController.menuItems = @[copy];
        
        [menuController setTargetRect:tagView.frame inView:self];
        [menuController setMenuVisible:YES animated:YES];
        //        menuController.m
        
        [tagView becomeFirstResponder];
}

- (void)touchDragExit:(id)sender
{
    UIButton *button = (UIButton*)sender;
}

- (void)touchDragInside:(id)sender
{
    UIButton *button = (UIButton*)sender;
}

@end

@interface TRTimeTagView ()

@end

@implementation TRTimeTagView

- (id)init
{
    if (self = [super init]) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_label setTextColor:TEXT_COLOR];
        [_label setShadowColor:TEXT_SHADOW_COLOR];
        [_label setShadowOffset:TEXT_SHADOW_OFFSET];
        [_label setBackgroundColor:[UIColor clearColor]];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_label];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [_button setFrame:self.frame];
        [self addSubview:_button];
        
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:CORNER_RADIUS];
        [self.layer setBorderColor:BORDER_COLOR];
        [self.layer setBorderWidth:BORDER_WIDTH];
    }
    int rand =  arc4random() % 4;
    UIColor *color = [UIColor brownColor];
    switch (rand) {
        case 0:
            color = [UIColor colorWithHexString:@"#91d180"];
            break;
        case 1:
            color = [UIColor colorWithHexString:@"#81b0f1"];
            break;
        case 2:
            color = [UIColor colorWithHexString:@"#f1d038"];
            break;
        case 3:
            color = [UIColor colorWithHexString:@"#ff5d73"];
            break;
        default:
            break;
    }
    if (self.backgroundColor == nil) {
        [self setBackgroundColor:color];
        NSLog(@"color....");
    }
    return self;
}

- (void)updateWithString:(NSString*)text
                    font:(UIFont*)font
      constrainedToWidth:(CGFloat)maxWidth
                 padding:(CGSize)padding
            minimumWidth:(CGFloat)minimumWidth
{
    CGSize textSize = [text sizeWithFont:font forWidth:maxWidth lineBreakMode:NSLineBreakByTruncatingTail];
    _label.text = text;
    
    textSize.width = MAX(textSize.width, minimumWidth);
    textSize.height += padding.height*2;
    
    self.frame = CGRectMake(0, 0, textSize.width+padding.width*2, textSize.height);
    _label.frame = CGRectMake(padding.width, 0, MIN(textSize.width, self.frame.size.width), textSize.height);
    _label.font = font;
    
    [_button setAccessibilityLabel:self.label.text];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    [self.layer setCornerRadius:cornerRadius];
}

- (void)setBorderColor:(CGColorRef)borderColor
{
    [self.layer setBorderColor:borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    [self.layer setBorderWidth:borderWidth];
}

- (void)setLabelText:(NSString*)text
{
    [_label setText:text];
}

- (void)setTextColor:(UIColor *)textColor
{
    [_label setTextColor:textColor];
}

- (void)setTextShadowColor:(UIColor*)textShadowColor
{
    [_label setShadowColor:textShadowColor];
}

- (void)setTextShadowOffset:(CGSize)textShadowOffset
{
    [_label setShadowOffset:textShadowOffset];
}

@end
