//
//  CCViewController.m
//  GlobeFun
//
//  Created by Mary Ann Brennan on 12/7/13.
//  Copyright (c) 2013 Mary Ann Brennan. All rights reserved.
//

#import "CCViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface CCViewController ()

@property (nonatomic, strong) WhirlyGlobeViewController *globeViewController;
@property (nonatomic, strong) MaplyViewControllerLayer *baseLayer;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *detailView;
@property (nonatomic, strong) UIView *globeView;
@property (nonatomic, strong) UIColor *darkGreyColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) NSArray *objects;

@end

@implementation CCViewController

@synthesize globeViewController;
@synthesize baseLayer;
@synthesize tableView;
@synthesize detailView;
@synthesize globeView;
@synthesize darkGreyColor;
@synthesize textColor;
@synthesize objects;

- (void)viewDidLoad
{
    [super viewDidLoad];

    darkGreyColor = [UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1.0];
    textColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.title = @"Chime For Change";

    self.view.backgroundColor = darkGreyColor;

    CGFloat yValue = 10.0;

    // hide nav bar
    self.navigationController.navigationBarHidden = YES;
    CGFloat globeFrameSide = self.view.frame.size.width;
    yValue = 0;

//    // don't hide nav bar
//    CGFloat globeFrameSide = 265.0;

//    CGRect globeFrame = CGRectMake(0, 0, self.view.frame.size.width, 275);
    CGRect globeFrame = CGRectMake((self.view.frame.size.width - globeFrameSide)/2.0, yValue, globeFrameSide, globeFrameSide);
    yValue += globeFrame.size.height;
    

    globeView = [[UIView alloc] initWithFrame:globeFrame];

//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, yValue, self.view.frame.size.width, 20)];
//    titleLabel.backgroundColor = darkGreyColor;
//    titleLabel.textColor = textColor;
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = @"Featured Stories and Projects";
//    yValue += titleLabel.frame.size.height;
//    [self.view addSubview:titleLabel];
    yValue += 10.0;

    [self initObjects];

    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, yValue, self.view.frame.size.width - 10.0, self.view.frame.size.height - globeFrame.size.height)];
    tableView.backgroundColor = darkGreyColor;
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0]];
    tableView.rowHeight = 75;
    tableView.dataSource = self;
    tableView.delegate = self;

    globeViewController = [[WhirlyGlobeViewController alloc] init];
    [globeView addSubview:globeViewController.view];
    globeViewController.view.frame = globeView.bounds;
    [self addChildViewController:globeViewController];

    globeViewController.delegate = self;
    
    // Set the background color for the globe
    globeViewController.clearColor = darkGreyColor;
    
    // We'll let the toolkit create a thread per image layer.
    globeViewController.threadPerLayer = true;

    // sf
    [globeViewController animateToPosition:WGCoordinateMakeWithDegrees( -90.230759, 15.783471) time:0.5];

    globeViewController.height = 1;

    [self.view addSubview:globeView];
    [self.view addSubview:tableView];
//    [self.view addSubview:detailView];

    [self performSelector:@selector(changeMapContents) withObject:nil afterDelay:0.0];
}

- (void)initObjects
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"Objects.plist"];
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    NSLog(@"%d", plistData.count);
    [plistData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"%@", key);
    }];
    self.objects = [plistData objectForKey:@"Objects"];
}

- (void)changeMapContents
{
    
    globeViewController.keepNorthUp = YES;
    globeViewController.pinchGesture = YES;
    globeViewController.rotateGesture = YES;

//    WGViewControllerLayer *layer = [globeViewController addSphericalEarthLayerWithImageSet:@"lowres_wtb_info"];
//    baseLayer = (MaplyViewControllerLayer *)layer;
//    baseLayer.drawPriority = 0;
////    screenLabelColor = [UIColor whiteColor];
////    screenLabelBackColor = [UIColor whiteColor];
////    labelColor = [UIColor blackColor];
////    labelBackColor = [UIColor whiteColor];
////    vecColor = [UIColor whiteColor];
////    vecWidth = 4.0;

    MaplyMBTileSource *tileSource = [[MaplyMBTileSource alloc] initWithMBTiles:@"geography-class"];
//    if (zoomLimit != 0 && zoomLimit < tileSource.maxZoom)
//        tileSource.maxZoom = zoomLimit;
    MaplyQuadImageTilesLayer *layer = [[MaplyQuadImageTilesLayer alloc] initWithCoordSystem:tileSource.coordSys tileSource:tileSource];
    baseLayer = layer;
    layer.handleEdges = true;
    layer.coverPoles = true;
    layer.requireElev = false;
    layer.waitLoad = false;
    [globeViewController addLayer:layer];
    layer.drawPriority = 0;
    
    NSMutableDictionary *hintDict = [NSMutableDictionary dictionary];
    [hintDict setObject:[NSNumber numberWithBool:NO] forKey:kWGRenderHintCulling];
    [hintDict setObject:[NSNumber numberWithBool:NO] forKey:kWGRenderHintZBuffer];
    [globeViewController setHints:hintDict];

    [self addShapes];
}

- (void)addShapes
{
    NSMutableArray *cylinders = [[NSMutableArray alloc] init];
    for (NSDictionary *object in self.objects) {
        MaplyShapeCylinder *cylinder = [[MaplyShapeCylinder alloc] init];
        float lng = ((NSNumber *)[object valueForKey:@"Lng"]).floatValue;
        float lat = ((NSNumber *)[object valueForKey:@"Lat"]).floatValue;
        cylinder.baseCenter = MaplyCoordinateMakeWithDegrees(lng, lat);
        cylinder.radius = 0.01;
        cylinder.height = 0.06;
        cylinder.selectable = true;
        cylinder.userObject = object;
        [cylinders addObject:cylinder];
    }

//    NSDictionary *desc = @{kMaplyColor : [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.8], kMaplyFade: @(1.0)};
    NSDictionary *desc = @{kMaplyColor : [UIColor whiteColor], kMaplyFade: @(1.0)};

    [globeViewController addShapes:cylinders desc:desc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    NSDictionary *object = [objects objectAtIndex:indexPath.row];
//    cell.textLabel.text = [object objectForKey:@"Title"];
//    cell.textLabel.textColor = textColor;
//    cell.backgroundColor = darkGreyColor;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.numberOfLines = 2;
//    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;

    cell.textLabel.text = [object objectForKey:@"Type"];
    cell.textLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
//    cell.textLabel.font = [cell.detailTextLabel.font fontWithSize:10];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    cell.detailTextLabel.text = [object objectForKey:@"Title"];
    cell.detailTextLabel.textColor = textColor;
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.detailTextLabel.font = [cell.detailTextLabel.font fontWithSize:18];
    cell.backgroundColor = darkGreyColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *object = [self.objects objectAtIndex:indexPath.row];
    float lng = ((NSNumber *)[object valueForKey:@"Lng"]).floatValue;
    float lat = ((NSNumber *)[object valueForKey:@"Lat"]).floatValue;

    [globeViewController animateToPosition:WGCoordinateMakeWithDegrees(lng, lat) time:0.6];
}

@end
