//
//  CCDetailView.m
//  GlobeFun
//
//  Created by Mary Ann Brennan on 12/7/13.
//  Copyright (c) 2013 Mary Ann Brennan. All rights reserved.
//

#import "CCDetailView.h"

@implementation CCDetailView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 150)];
        self.imageView.backgroundColor = [UIColor redColor];
//        [self addSubview:self.imageView];

        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        self.titleLabel.text = @"test";
        self.titleLabel.textColor = [UIColor colorWithRed:248/255.0 green:174/255.0 blue:52/255.0 alpha:1.0];
        self.titleLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.titleLabel];

        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

//- (id)initWithFrame:(CGRect)frame
//{
////    return [self initWithFrame:frame dictionary:nil];
////}
////
////- (id)initWithFrame:(CGRect)frame dictionary:(NSDictionary *)dictionary
////{
////    NSString *index = [dictionary objectForKey:@"Index"];
//    if (self = [super init]) {
//        //        self.backgroundColor = [UIColor redColor];
//    }
//    return  self;
//}

- (void)setDictionary:(NSDictionary *)dictionary
{
    NSString *index = [dictionary objectForKey:@"Index"];
//    if (self.imageView) {
//        [self.imageView removeFromSuperview];
//    }
    NSLog(@"%@", [NSString stringWithFormat:@"image_%@", index]);
//    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"image_%@", index]]];
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image_%@", index]];
//    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, 150);
    self.titleLabel.text = [dictionary objectForKey:@"Title"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
