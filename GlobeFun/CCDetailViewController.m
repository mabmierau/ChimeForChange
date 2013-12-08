//
//  CCDetailViewController.m
//  GlobeFun
//
//  Created by Mary Ann Brennan on 12/7/13.
//  Copyright (c) 2013 Mary Ann Brennan. All rights reserved.
//

#import "CCDetailViewController.h"

@interface CCDetailViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentsLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) UILabel *pictureTitleLabel;
@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation CCDetailViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.title =
//        // Custom initialization
//    }
//    return self;
//}

@synthesize dictionary;

- (id)initWithDictionary:(NSDictionary *)aDictionary {
    if (self = [super init]) {
        self.dictionary = aDictionary;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60)];

    self.navigationController.navigationBarHidden = NO;

    UIColor *darkGreyColor = [UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1.0];
    self.view.backgroundColor = darkGreyColor;

    self.title = [dictionary objectForKey:@"Type"];

    NSString *index = [dictionary objectForKey:@"Index"];
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"image_%@.jpg", index]]];
//    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    self.imageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.imageView];

    UIView *pictureTitleLabelContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    pictureTitleLabelContainer.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:0.25];
    self.pictureTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(6.0, 6.0, pictureTitleLabelContainer.frame.size.width - 12, 20)];
    self.pictureTitleLabel.text = [dictionary objectForKey:@"Title"];
    self.pictureTitleLabel.textColor = [UIColor whiteColor];
    self.pictureTitleLabel.backgroundColor = [UIColor clearColor];
    self.pictureTitleLabel.numberOfLines = 0;
    [self.pictureTitleLabel sizeToFit];
    [pictureTitleLabelContainer addSubview:self.pictureTitleLabel];
    pictureTitleLabelContainer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.pictureTitleLabel.frame.size.height + 12);
    [self.contentView addSubview:pictureTitleLabelContainer];

//    self.pictureTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
//    self.pictureTitleLabel.text = [dictionary objectForKey:@"Title"];
//    self.pictureTitleLabel.textColor = [UIColor whiteColor];
//    self.pictureTitleLabel.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:0.25];
//    self.pictureTitleLabel.numberOfLines = 0;
//    [self.pictureTitleLabel sizeToFit];
//    [self.contentView addSubview:self.pictureTitleLabel];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, self.view.frame.size.width - 20, 290)];
    self.titleLabel.text = [dictionary objectForKey:@"Contents"];
//    self.titleLabel.textColor = [UIColor colorWithRed:248/255.0 green:174/255.0 blue:52/255.0 alpha:1.0];
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.titleLabel.backgroundColor = darkGreyColor;
    self.titleLabel.numberOfLines = 0;
//    self.titleLabel.sizeToFit = NO;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel sizeToFit];

    self.contentView.contentSize = CGSizeMake(self.view.frame.size.width, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height);
    [self.view addSubview:self.contentView];
    self.view.backgroundColor = darkGreyColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
