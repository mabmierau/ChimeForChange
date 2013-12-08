//
//  CCDetailView.h
//  GlobeFun
//
//  Created by Mary Ann Brennan on 12/7/13.
//  Copyright (c) 2013 Mary Ann Brennan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCDetailView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentsLabel;
@property (nonatomic, strong) UIImageView *imageView;

//- (id)initWithFrame:(CGRect)frame dictionary:(NSDictionary *)dictionary;
- (void)setDictionary:(NSDictionary *)dictionary;
@end
