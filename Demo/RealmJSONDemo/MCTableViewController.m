//
//  MCTableViewController.m
//  RealmJSONDemo
//
//  Created by Matthew Cheok on 27/7/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCTableViewController.h"
#import "MCEpisode.h"
#import "MCEpisodesPage.h"

@import Realm;
@import Realm_JSON;

#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>

@interface MCTableViewController ()

@property (nonatomic, strong) RLMResults *results;
@property (nonatomic, strong) RLMNotificationToken *token;

@end

@implementation MCTableViewController

#pragma mark - Methods

- (IBAction)reloadData {
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:@"https://www.nsscreencast.com/api/episodes.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            MCEpisodesPage *page = [[MCEpisodesPage alloc] initWithJSONDictionary:responseObject];
            [page shallowCopy];
            [page deepCopy];
            dispatch_async(dispatch_get_main_queue(), ^{
                RLMRealm *realm = [RLMRealm defaultRealm];
                
                [realm beginWriteTransaction];
                NSArray *result = [MCEpisode createOrUpdateInRealm:realm withJSONArray:responseObject[@"episodes"]];
                [realm commitWriteTransaction];
                
                NSLog(@"results count: %@", @(result.count));
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)refreshData {
    self.results = [[MCEpisode allObjectsInRealm:[RLMRealm defaultRealm]] sortedResultsUsingKeyPath:@"publishedDate" ascending:NO];
	[self.tableView reloadData];
    
    NSLog(@"first episode %@", [[self.results firstObject] JSONDictionary]);
}

#pragma mark - UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.token = [[RLMRealm defaultRealm] addNotificationBlock: ^(NSString *notification, RLMRealm *realm) {
	    [self refreshData];
	}];
	[self refreshData];
	[self reloadData];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSDateFormatter *dateFormatter = nil;
	if (!dateFormatter) {
		dateFormatter = [[NSDateFormatter alloc] init];
		dateFormatter.dateStyle = NSDateFormatterMediumStyle;
		dateFormatter.timeStyle = NSDateFormatterShortStyle;
	}

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	MCEpisode *episode = self.results[indexPath.row];

	cell.textLabel.text = episode.title;
	cell.detailTextLabel.text = [dateFormatter stringFromDate:episode.publishedDate];
	cell.imageView.image = nil;
	cell.backgroundColor = episode.episodeType == MCEpisodeTypePaid ? [UIColor colorWithRed:0.996 green:0.839 blue:0.843 alpha:1]: nil;

	__weak UITableViewCell *weakCell = cell;
	[cell.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:episode.thumbnailURL]] placeholderImage:nil success: ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
	    weakCell.imageView.image = image;
	    [weakCell setNeedsLayout];
	} failure:nil];

	return cell;
}

@end
