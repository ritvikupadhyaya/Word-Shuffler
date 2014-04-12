//
//  ViewController.m
//  WordShuffler
//
//  Created by Jerry Jiang on 4/11/14.
//  Copyright (c) 2014 Zhilin Jiang. All rights reserved.
//

#import "ViewController.h"
#import "IFTTTJazzHands.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize original;
@synthesize shuffled;

- (void)viewDidLoad{
    self.animator = [IFTTTAnimator new];
    IFTTTFrameAnimation *frameAnimation = [IFTTTFrameAnimation new];
    frameAnimation.view = original;
    [self.animator addAnimation:frameAnimation];
    [frameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:30 andFrame:CGRectMake(10, 10, 100, 100)]];
    [frameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:60 andFrame:CGRectMake(150, 10, 200, 200)]];
    original.text = @"Original";
    original.textColor = [UIColor lightGrayColor];
    original.delegate = self;
    shuffled.text = @"Shuffled";
    shuffled.textColor = [UIColor lightGrayColor];
    shuffled.delegate = self;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.animator animate:scrollView.contentOffset.x];
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
    NSMutableString *result = [NSString stringWithFormat:@"%C",[word characterAtIndex:0]];
    BOOL picked[word.length];
    for (int i=0;i < word.length;i++) {
        picked[i] = NO;
    }
    picked[0] = YES;
    picked[word.length-1] = YES;
    int tmp=0;
    for (int i=1;i < word.length-1;i++) {
        while (picked[tmp]) {
            tmp = arc4random() % (word.length-2) + 1;
        }
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%C",[word characterAtIndex:tmp]]];
        picked[tmp] = YES;
    }
    result = [result stringByAppendingString:[NSString stringWithFormat:@"%C",[word characterAtIndex:(word.length-1)]]];
    return result;
}

- (IBAction)enshuffle:(UIButton *)sender {

    NSString *originalText = original.text;
    originalText = original.text;
    shuffled.text = @"";
    
    NSMutableArray *listwords = [originalText componentsSeparatedByString:@" "];
    if (listwords.count > 1) {
        for (int i=0; i < listwords.count; i++) {
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
    [original resignFirstResponder];
}

@end
