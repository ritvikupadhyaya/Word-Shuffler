//
//  ViewController.h
//  WordShuffler
//
//  Created by Jerry Jiang on 4/11/14.
//  Copyright (c) 2014 Zhilin Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFTTTJazzHands.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *original;
@property (weak, nonatomic) IBOutlet UITextView *shuffled;
@property (nonatomic, strong) IFTTTAnimator *animator;



@end
