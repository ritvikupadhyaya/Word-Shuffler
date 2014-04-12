//
//  iPadController.m
//  WordShuffler
//
//  Created by Ritvik Upadhyaya on 12/04/14.
//  Copyright (c) 2014 Zhilin Jiang. All rights reserved.
//

#import "iPadController.h"

@interface iPadController ()

@end

@implementation iPadController
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

- (IBAction)enshuffle:(id)sender {
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
                [shuffled insertText:[iPadController shuffleWord:tmpWord]];
                tmpWord = @"";
            }
            [shuffled insertText:[NSString stringWithFormat:@"%C",singleChar]];
        }
    }
    if (tmpWord != @"") {
        [shuffled insertText:[iPadController shuffleWord:tmpWord]];
        tmpWord = @"";
    }
    [original resignFirstResponder];
}

@end
