//
//  ViewController.m
//  WLPullToRefresh
//
//  Created by Lane on 8/27/15.
//  Copyright (c) 2015 Lane. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) NSArray *array;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.array=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",nil];
    
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.refreshControl=[[UIRefreshControl alloc] init];
    [self.myTableView addSubview:self.refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"idCell" forIndexPath:indexPath];
    cell.textLabel.text=self.array[indexPath.row];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

- (void) doSomething{
    NSLog(@"ready to do something");
    self.timer=[NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(endWork) userInfo:nil repeats:true];
    NSLog(@"something have done");
}

- (void) endWork{
    [self.refreshControl endRefreshing];
    [self.timer invalidate];
    self.timer=nil;
    NSLog(@"end the work");
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.refreshControl.refreshing) {
        [self doSomething];
    }
}

@end
