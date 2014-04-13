//
//  ViewController.m
//  WordShuffler
//
//  Created by Ritvik Upadhyaya and Jerry Jiang on 4/11/14.
//  Copyright (c) 2014 Ritvik Upadhyaya and Zhilin Jiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize original;
@synthesize shuffled;

- (void)viewDidLoad{
    original.text = @"Original";
    original.textColor = [UIColor whiteColor];
    [original setAlpha:0.4];
    original.delegate = self;
    shuffled.text = @"Shuffled";
    shuffled.textColor = [UIColor whiteColor];
    [shuffled setAlpha:0.4];
    shuffled.delegate = self;
    
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if ([original.text  isEqual: @"Original"]) {
        original.text = @"";
        original.textColor = [UIColor whiteColor];
        [original setAlpha:1.0];
        shuffled.text = @"";
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
        shuffled.textColor = [UIColor whiteColor];
        [shuffled setAlpha:0.4];
        shuffled.text = @"Shuffled";
        [original resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSString *)shuffleWord:(NSString *)word {
    if (word.length <= 3) {
        return word;
    }
    NSMutableString *result = [NSString stringWithFormat:@"%C",[word characterAtIndex:0]];
    if (word.length == 4) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%C",[word characterAtIndex:2]]];
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%C",[word characterAtIndex:1]] ];
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%C",[word characterAtIndex:3]] ];
        return result;
    }
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
    if(original.text.length == 0){
        original.textColor = [UIColor whiteColor];
        [original setAlpha:0.4];
        original.text = @"Original";
        [original resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)enshuffle:(UIButton *)sender {
    
    NSString *originalText = original.text;
    originalText = original.text;
    shuffled.text = @"";
    
    if (original.alpha != 1.0) {
        [shuffled setAlpha:0.4];
        shuffled.text = @"Shuffled";
        return;
    }
    
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

- (IBAction)showEmail:(id)sender {
    NSString *body = shuffled.text;
    if(shuffled.alpha == 0.4){
        body = @"";
    }
    body = [body stringByAppendingString:[NSString stringWithFormat:@"%@\r\n",@"\n\nSent via Word Shuffler"]];
    // Email Subject
    NSString *emailTitle = @"";
    // Email Content
    NSString *messageBody = shuffled.text;
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:body isHTML:NO];
   
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)share:(id)sender {
    [self showEmail:sender];
}
@end
