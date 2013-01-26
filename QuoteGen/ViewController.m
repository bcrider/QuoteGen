//
//  ViewController.m
//  QuoteGen
//
//  Created by Brian Crider on 11/30/12.
//  Copyright (c) 2012 FedEx. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 1 - Add array of personal quotes
    self.myQuotes = @[
        @"Live and let live",
        @"Don't cry over spilt milk",
        @"May The Force Be With You",
        @"Always look on the bright side of life",
        @"Nobody's perfect",
        @"Can't see the woods for the trees",
        @"Better to have loved and lost then not loved at all",
        @"The early bird catches the worm",
        @"As slow as a wet week"
    ];
 
    // 2 - Load movie quotes
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"plist"];
    self.movieQuotes= [NSMutableArray arrayWithContentsOfFile:plistCatPath];
    
    // Show something other than the default Latin text
    // http://en.wikipedia.org/wiki/Lorem_ipsum
    self.quoteText.text = @"Hello Brian";
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self    .myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


// ORIGINAL USING AN ARRAY
//-(IBAction)quoteButtonTapped:(id)sender
//{
//    // 1 - Get number of rows in array
//    int array_tot = [self.myQuotes count];
//    
//    // 2 - Get random index
//    int index = (arc4random() % array_tot);
//    
//    // 3 - Get the quote string for the index
//    NSString *my_quote = self.myQuotes[index];
//    
//    // 4 - Display the quote in the text view
//    self.quoteText.text = [NSString stringWithFormat:@"Quote:\n\n%@",  my_quote];
//}

// NEW USING A PROPERTY LIST
-(IBAction)quoteButtonTapped:(id)sender
{
    // 1 - Get personal quotes when the final segment is selected
//    if (self.quoteOpt.selectedSegmentIndex == 2)
//    {
//            // 1 - Get number of rows in array
//            int array_tot = [self.myQuotes count];
//        
//            // 2 - Get random index
//            int index = (arc4random() % array_tot);
//        
//            // 3 - Get the quote string for the index
//            NSString *my_quote = self.myQuotes[index];
//        
//            // 4 - Display the quote in the text view
//            self.quoteText.text = [NSString stringWithFormat:@"Quote:\n\n%@",  my_quote];
//
//    }
    
    // NEW - Concatenate all quotes
    if (self.quoteOpt.selectedSegmentIndex == 2)
    {
        // 1.1 - Get array count
        int array_tot = [self.myQuotes count];
        
        // 1.2 - Initialize string for concatenated quotes
        NSString *all_my_quotes = @"";
        NSString *my_quote = nil;
        
        // 1.3 - Iterate through array
        for (int x=0; x < array_tot; x++)
        {
            my_quote = self.myQuotes[x];
            all_my_quotes = [NSString stringWithFormat:@"%@\n%@\n",  all_my_quotes,my_quote];
        }
        self.quoteText.text = [NSString stringWithFormat:@"%@", all_my_quotes];
    }
    // 2 - Get movie quotes
    else
    {
        // 2.1 - determine category
        NSString *selectedCategory = @"classic";
        if (self.quoteOpt.selectedSegmentIndex == 1)
        {
            selectedCategory = @"modern";
        }
        // 2.2 - filter array by category using predicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", selectedCategory];
        NSArray *filteredArray = [self.movieQuotes filteredArrayUsingPredicate:predicate];
        // 2.3 - get total number in filtered array
        int array_tot = [filteredArray count];
        // 2.4 - as a safeguard only get quote when the array has rows in it
        if (array_tot > 0)
        {
            // 2.5 - get random index
            int index = (arc4random() % array_tot);
            
            // 2.6 - get the quote string for the index
            NSString *quote = filteredArray[index][@"quote"];
//            self.quoteText.text = [NSString stringWithFormat:@"Movie Quote:\n\n%@",  quote];
            
            // 2.7 - Check if there is a source
            NSString *source = [[filteredArray objectAtIndex:index] valueForKey:@"source"];
            if (![source length] == 0)
            {
                quote = [NSString stringWithFormat:@"%@\n\n(%@)",  quote, source];
            }
            
            // 2.8 - Customize quote based on category
            if ([selectedCategory isEqualToString:@"classic"])
            {
                quote = [NSString stringWithFormat:@"From Classic Movie\n\n%@",  quote];
            }
            else
            {
                quote = [NSString stringWithFormat:@"Movie Quote:\n\n%@",  quote];
            }
            
            // HARRY POTTER TEST
            if ([source hasPrefix:@"Harry"])
            {
                quote = [NSString stringWithFormat:@"HARRY ROCKS!!\n\n%@",  quote];
            }
            
            // 2.9 - Display quote
            self.quoteText.text = quote;
            
            // 2.10 - Update row to indicate that it has been displayed
            int movie_array_tot = [self.movieQuotes count];
            NSString *quote1 = filteredArray[index][@"quote"];
            for (int x=0; x < movie_array_tot; x++)
            {
                NSString *quote2 = self.movieQuotes[x][@"quote"];
                if ([quote1 isEqualToString:quote2])
                {
                    NSMutableDictionary *itemAtIndex = (NSMutableDictionary *)self.movieQuotes[x];
                    itemAtIndex[@"source"] = @"DONE";
                }
            }
        }
        else
        {
            self.quoteText.text = [NSString stringWithFormat:@"No quotes to display."];
        }
    }
}

@end
