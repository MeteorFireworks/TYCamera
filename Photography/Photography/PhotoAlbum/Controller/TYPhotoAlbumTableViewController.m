//
//  FWPhotoAblumTableViewController.m
//  FWLifeApp
//
//  Created by Forrest Woo on 16/9/23.
//  Copyright © 2016年 ForrstWoo. All rights reserved.
//

#import "TYPhotoAlbumTableViewController.h"
#import "TYPhotoManager.h"
#import "UIButton+TextAndImageHorizontalDisplay.h"
#import "TYPhotoCollectionViewController.h"
#import "TYPhotosLayout.h"

@interface TYPhotoAlbumTableViewController ()
{
    NSMutableArray<TYPhotoAlbums *> *mArr;
}

@end

@implementation TYPhotoAlbumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"相册";
    mArr= [[[TYPhotoManager sharedManager] getPhotoAlbums] mutableCopy];
    [self initNavgationBar];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (mArr.count > 0) {
        [mArr removeAllObjects];
        [mArr addObjectsFromArray:[[TYPhotoManager sharedManager] getPhotoAlbums]];
        [self.tableView reloadData];
    }
}

- (void)initNavgationBar
{
    UIButton *rightBar = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBar.frame = CGRectMake(0, 0, 68, 32);
    [rightBar setImage:[UIImage imageNamed:@"Camera"] withTitle:@"相机" forState:UIControlStateNormal];
    [rightBar addTarget:self action:@selector(cameraClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBar];
}

- (void)cameraClicked
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    TYPhotoAlbums *album = mArr[indexPath.row];
    cell.textLabel.text = album.albumName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld张",album.albumImageCount];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    __block UIImage *img = nil;
    [[TYPhotoManager sharedManager] requestImageForAsset:album.firstImageAsset size:CGSizeMake(60 * 3, 60 * 3) resizeMode:PHImageRequestOptionsResizeModeExact completion:^(UIImage *image, NSDictionary *info) {
        img = image;
    }];
    cell.imageView.image = img;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.clipsToBounds = YES;
    return cell;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TYPhotoAlbums *model = [mArr objectAtIndex:indexPath.row];
    TYPhotosLayout *layout = [[TYPhotosLayout alloc] init];
    layout.minimumInteritemSpacing = 1.5;
    layout.minimumLineSpacing = 5.0;
    TYPhotoCollectionViewController *vc = [[TYPhotoCollectionViewController alloc] initWithCollectionViewLayout:layout model:model];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
