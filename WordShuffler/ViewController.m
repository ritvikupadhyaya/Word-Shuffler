//
//  ViewController.m
//  WordShuffler
//
//  Created by Jerry Jiang on 4/11/14.
//  Copyright (c) 2014 Zhilin Jiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize original;
@synthesize shuffled;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (*NSString)shuffleWord:(NSString *)word {
    if (word.length <=2) {
        return word;
    }
    
    return word;
}

- (IBAction)enshuffle:(UIButton *)sender {

    NSString *originalText = original.text;
    originalText = original.text;
    NSArray *listwords = [originalText componentsSeparatedByString:@" "];
    for (int i=0; i<listwords.count; i++) {
        listwords[i] = shuffleWord(listwords[i]);
    }
    NSString *encodedText;
    shuffled.text = originalText;
}

@end
