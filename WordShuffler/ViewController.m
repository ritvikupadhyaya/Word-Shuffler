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

- (void)viewDidLoad{
    original.text = @"Original";
    original.textColor = [UIColor lightGrayColor];
    original.delegate = self;
    shuffled.text = @"Shuffled";
    shuffled.textColor = [UIColor lightGrayColor];
    shuffled.delegate = self;
    
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    original.text = @"";
    original.textColor = [UIColor blackColor];
    shuffled.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(original.text.length == 0){
        original.textColor = [UIColor lightGrayColor];
        original.text = @"Comment";
        [original resignFirstResponder];
    }
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
    
    return word;
}

- (IBAction)enshuffle:(UIButton *)sender {

    NSString *originalText = original.text;
    originalText = original.text;
    NSMutableArray *listwords = [originalText componentsSeparatedByString:@" "];
    for (int i=0; i< listwords.count; i++) {
        [listwords replaceObjectAtIndex:i withObject:[ViewController shuffleWord:[listwords objectAtIndex:i]]];
    }
    shuffled.text = originalText;
}

@end
