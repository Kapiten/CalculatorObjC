//
//  ViewController.m
//  CalculatorObjC
//
//  Created by Admin on 2024/01/16.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblAnswer;
@property (weak, nonatomic) IBOutlet UITextView *txtExpression;

@end

@implementation ViewController

NSString *lastEntry;
BOOL standBy = false;
BOOL symboled = false;
BOOL dotted = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    standBy=true;
    lastEntry = [[NSString alloc] init];
}

- (IBAction)tapNumber:(UIButton *)sender {
    if(standBy){[self clearAll]; [_txtExpression setText:@""];standBy=false;}
    
    if([lastEntry isEqualToString:@"0"]&&symboled) {
        if(_txtExpression.text.length>0){_txtExpression.text = [_txtExpression.text substringToIndex:_txtExpression.text.length-1];}
        [self appendExpression:sender.titleLabel.text];
    }
    
    else {[self appendExpression:sender.titleLabel.text];}
    
    symboled=symboled&&[sender.titleLabel.text isEqualToString:@"0"];
    lastEntry =sender.titleLabel.text;
}
- (IBAction)tapPoint:(UIButton *)sender {
    if(!dotted){if(symboled){[self appendExpression: @"0"];} [self appendExpression: sender.titleLabel.text]; dotted=true;}
}

- (IBAction)tapSymbol:(UIButton *)sender {
    NSString *currSym = @"";
    
    if(_txtExpression.text.length<1||symboled){if(sender.tag<3||dotted){_txtExpression.text = [_txtExpression.text stringByAppendingString:@"0"];}else{_txtExpression.text = [_txtExpression.text stringByAppendingString:@"1"];}symboled=false;}
    
    if (!symboled) {
        switch (sender.tag) {
            case 1: currSym = @"+"; break;
            case 2: currSym = @"-"; break;
            case 3: currSym = @"÷"; break;
            case 4: currSym = @"×"; break;
            default: break;
        }
        
        [self appendExpression: currSym];
        symboled=true;
        dotted=false;
        lastEntry = sender.titleLabel.text;
    }
}

- (IBAction)tapClear:(UIButton *)sender {[self clearAll];}

- (IBAction)tapBackspace:(UIButton *)sender {if(standBy){return;}[_txtExpression setText:[_txtExpression.text substringToIndex:_txtExpression.text.length-1]];}

- (IBAction)tapEqual:(UIButton *)sender {
    NSString *currVal = @"";
    NSString *currSym = @"";
    double currAns = 0;
    int symIndx = 0;
    bool signAlt = false;
    NSArray *arrNums = [_txtExpression.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"+-÷×"]];
    NSMutableArray *arrSymsA = [_txtExpression.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"1234567890."]].mutableCopy;
    NSMutableArray *arrSyms = [[NSMutableArray alloc] init];
    for(NSString *aStr in arrSymsA) {
        if(![aStr isEqualToString:@""]){[arrSyms addObject:aStr];}
    }
//    NSLog(@"%@%@", @"ExpressCharsNumbs:", [_txtExpression.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"+-÷×"]]);
//    NSLog(@"%@%@", @"ExpressCharsSyms:", [_txtExpression.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"1234567890."]]);
    for(NSString *aNum in arrNums) {
        if([currSym isEqualToString:@""]){currAns=aNum.doubleValue;currSym = ((NSString *)[arrSyms objectAtIndex:symIndx]);symIndx +=1;signAlt=true;}
        else {
            if(signAlt) {currSym = ((NSString *)[arrSyms objectAtIndex:symIndx]);symIndx +=1;}
            else {
                if([currSym isEqualToString: @"+"]) {currAns += aNum.doubleValue;}
                if([currSym isEqualToString: @"-"]) {currAns -= aNum.doubleValue;}
                if([currSym isEqualToString: @"÷"]) {currAns /= aNum.doubleValue;}
                if([currSym isEqualToString: @"×"]) {currAns *= aNum.doubleValue;}
            }
            
        }
        
        signAlt = !signAlt;
    }
    
    currVal = [[NSString alloc] initWithFormat:@"%f", currAns];
    
    for (int a=currVal.length-1; a>=0; a--) {
        NSString *aStr = [[NSString alloc] initWithFormat:@"%C", [currVal characterAtIndex:a]];
        NSLog(@"%@%@", @"aStr:", aStr);
        int finalInd = a;
        if(![aStr isEqualToString:@"."]){finalInd=a+1;}
        if(![aStr isEqualToString:@"0"]){currVal = [currVal substringToIndex:finalInd]; break;}
    }
    
//    if((NSInteger)currAns%2==0){currVal = [[NSString alloc] initWithFormat:@"%d", currVal];}
    [_lblAnswer setText:[currVal stringByAppendingString: @"="]];
    standBy = true;
        
    NSLog(@"%@%f", @"Answer:", currVal.doubleValue);
}

- (void)clearAll {
    [_txtExpression setText:@"Expression"];
    [_lblAnswer setText:@"Answer"];
    standBy=true;
}

- (void) appendExpression:(NSString *)val {
    [_txtExpression setText:[_txtExpression.text stringByAppendingString:val]];
    NSRange bottom = NSMakeRange(_txtExpression.text.length -1, 1);
    [_txtExpression scrollRangeToVisible:bottom];
}

@end
