//
//  ComposeViewController.m
//  twitter
//
//  Created by Mason Llewellyn on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
- (IBAction)closeComposeAction:(id)sender {
    [self dismissViewControllerAnimated:true
                             completion:nil];
    
}
- (IBAction)postTweetAction:(id)sender {
     __weak typeof(self) weakSelf = self;
    [[APIManager shared] postStatusWithText:self.tweetTextView.text completion:^(Tweet *tweet, NSError *error) {
        /*if (tweet){
            
        }
        else{
            NSLog(@"😫😫😫 Error posting tweet: %@", error.localizedDescription);
        }*/
        [weakSelf dismissViewControllerAnimated:true
                                     completion:nil];
        
    }];
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
