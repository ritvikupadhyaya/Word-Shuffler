//
//  ViewController.h
//  WordShuffler
//
//  Created by Ritvik Upadhyaya and Jerry Jiang on 4/11/14.
//  Copyright (c) 2014 Ritvik Upadhyaya and Zhilin Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFTTTJazzHands.h"
#import <MessageUI/MessageUI.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *original;
@property (weak, nonatomic) IBOutlet UITextView *shuffled;
@property (nonatomic, strong) IFTTTAnimator *animator;
- (IBAction)share:(id)sender;
- (IBAction)fb:(id)sender;



@end
