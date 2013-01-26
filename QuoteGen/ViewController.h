//
//  ViewController.h
//  QuoteGen
//
//  Created by Brian Crider on 11/30/12.
//  Copyright (c) 2012 FedEx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSArray *myQuotes;
@property (nonatomic, strong) NSMutableArray *movieQuotes;

@property (nonatomic, strong) IBOutlet UITextView *quoteText;

- (IBAction) quoteButtonTapped: (id) sender;

@property (nonatomic, strong) IBOutlet UISegmentedControl *quoteOpt;

@end
