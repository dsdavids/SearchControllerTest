//
//  DetailViewController.h
//  Search Test
//
//  Created by Dean S. Davids on 9/13/16.
//  Copyright © 2016 Dean S. Davids. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

