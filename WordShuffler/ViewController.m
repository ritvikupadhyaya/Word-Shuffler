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

+ (NSString *)shuffleWord:(NSString *)word {
    if (word.length <=2) {
        return word;
    }
    NSMutableString *result = [word characterAtIndex:0];
    result
    return result;
}

- (IBAction)enshuffle:(UIButton *)sender {

    NSString *originalText = original.text;
    originalText = original.text;
    shuffled.text = @"";
    
    NSMutableArray *listwords = [originalText componentsSeparatedByString:@" "];
    if (listwords.count > 1) {
        for (int i=0; i<listwords.count; i++) {
            //shuffled.text = [listwords objectAtIndex:i];
            //[shuffled insertText:[NSString stringWithFormat: @"%d", listwords.count]];
            //NSString *shuffledWord = [ViewController shuffleWord:[listwords objectAtIndex:i]];
            //[listwords replaceObjectAtIndex:i withObject:shuffledWord];
            [shuffled insertText:[ViewController shuffleWord:[listwords objectAtIndex:i]]];
            [shuffled insertText:@" "];
        }
    } else {
        [shuffled insertText:[ViewController shuffleWord:originalText]];
    }
}

@end
