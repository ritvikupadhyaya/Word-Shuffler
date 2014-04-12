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
    original.textColor = [UIColor whiteColor];
    [original setAlpha:0.4];
    original.delegate = self;
    shuffled.text = @"Shuffled";
    shuffled.textColor = [UIColor whiteColor];
    [shuffled setAlpha:0.5];
    shuffled.delegate = self;
    
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if ([original.text  isEqual: @"Original"]) {
        original.text = @"";
        original.textColor = [UIColor whiteColor];
        [original setAlpha:1.0];
        shuffled.textColor = [UIColor whiteColor];
        [shuffled setAlpha:1.0];
        return YES;
    }
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(original.text.length == 0){
        original.textColor = [UIColor whiteColor];
        [original setAlpha:0.4];
        original.text = @"Original";
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([original isFirstResponder] && ([touch view]!= original)) {
        [original resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)enshuffle:(UIButton *)sender {

    NSString *originalText = original.text;
    originalText = original.text;
    shuffled.text = @"";
    
    NSCharacterSet *validChars = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    NSCharacterSet *invalidChars = [validChars invertedSet];
    
    NSMutableString *tmpWord = @"";
    for (int i=0; i< originalText.length; i++) {
        unichar *singleChar = [originalText characterAtIndex:i];
        if ([validChars characterIsMember:singleChar]) {
            tmpWord = [tmpWord stringByAppendingString:[NSString stringWithFormat:@"%C",singleChar]];
        } else {
            if (tmpWord != @"") {
                [shuffled insertText:[ViewController shuffleWord:tmpWord]];
                tmpWord = @"";
            }
            [shuffled insertText:[NSString stringWithFormat:@"%C",singleChar]];
        }
    }
    if (tmpWord != @"") {
        [shuffled insertText:[ViewController shuffleWord:tmpWord]];
        tmpWord = @"";
    }
    [original resignFirstResponder];
}

@end
