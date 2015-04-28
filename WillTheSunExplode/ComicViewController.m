//
//  ComicViewController.m
//  WillTheSunExplode
//
//  Created by Keaton Burleson on 4/28/15.
//  Copyright (c) 2015 Keaton Burleson. All rights reserved.
//

#import "ComicViewController.h"

@interface ComicViewController ()
@property (strong, nonatomic)IBOutlet UIWebView *comicView;
@end

@implementation ComicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *urlforWebView=[NSURL URLWithString:@"http://imgs.xkcd.com/comics/frequentists_vs_bayesians.png"];
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:urlforWebView];
    [_comicView loadRequest:urlRequest];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)back:(id)sender{
     [self dismissViewControllerAnimated:YES completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
