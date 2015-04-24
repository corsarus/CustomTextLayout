//
//  TextAroundShapeViewController.m
//  CustomTextLayout
//
//  Created by Catalin (iMac) on 21/04/2015.
//  Copyright (c) 2015 corsarus. All rights reserved.
//

#import "TextAroundShapeViewController.h"
#import "CustomTextStorage.h"

@interface TextAroundShapeViewController ()

@property (nonatomic, strong) CustomTextStorage *customTextStorage;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *excludedArea;
@property (nonatomic, strong) CAShapeLayer *excludedShape;

@end

@implementation TextAroundShapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addExcludedArea];
    [self setupCustomTextStack];
}

#pragma mark - Accessors

- (CustomTextStorage *)customTextStorage
{
    if (!_customTextStorage) {
        _customTextStorage = [[CustomTextStorage alloc] init];
    }
    
    return _customTextStorage;
}

- (void)addExcludedArea
{
        
    // Create a square exclusion area of 120 points side and place it in the center of the screen
    self.excludedArea = [[UIView alloc] init];
    
    self.excludedArea.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.excludedArea];
    
    [self.excludedArea addConstraint:[NSLayoutConstraint constraintWithItem:self.excludedArea
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:0.0 constant:120.0]];
    [self.excludedArea addConstraint:[NSLayoutConstraint constraintWithItem:self.excludedArea
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:0.0 constant:120.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.excludedArea
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.excludedArea
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0 constant:0.0]];
}

#pragma mark - Text layout

- (void)setupCustomTextStack
{
    // Create the layout manager and associate it to the text storage
    NSLayoutManager *customLayoutManager =[[NSLayoutManager alloc] init];
    [self.customTextStorage addLayoutManager:customLayoutManager];
    
    // Create the text container and associate it to the layout manager
    NSTextContainer *customTextContainer = [[NSTextContainer alloc] initWithSize:CGSizeZero];
    [customLayoutManager addTextContainer:customTextContainer];
    
    // Initialize the text view with the previously created text container
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds textContainer:customTextContainer];
    self.textView.editable = NO;
    [self.view addSubview:self.textView];
    
    // The text view extends to the screen edges
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textView]|"
                                                                     options:NSLayoutFormatAlignAllCenterY
                                                                     metrics:nil
                                                                        views:@{@"textView": self.textView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textView]|"
                                                                      options:NSLayoutFormatAlignAllCenterX
                                                                      metrics:nil
                                                                        views:@{@"textView": self.textView}]];
}

#pragma mark - View controller

- (void)viewDidLayoutSubviews
{
    
    self.textView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
    
    // Convert the excludedArea to the text view coordinates
    CGRect excludedAreaInTextContainer = [self.textView convertRect:self.excludedArea.frame fromView:self.view];
    UIBezierPath *exclusionPath = [UIBezierPath bezierPathWithOvalInRect:excludedAreaInTextContainer];
    self.textView.textContainer.exclusionPaths = @[exclusionPath];
    
    // Stroke the exclusion path
    [self.excludedShape removeFromSuperlayer];
    self.excludedShape = [CAShapeLayer layer];
    self.excludedShape.path = exclusionPath.CGPath;
    self.excludedShape.strokeColor = [UIColor blueColor].CGColor;
    self.excludedShape.fillColor = nil;
    self.excludedShape.lineWidth = 2.0f;
    [self.textView.layer addSublayer:self.excludedShape];
    
}


@end
