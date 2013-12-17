//
//  PostsListController.m
//  Sporty
//
//  Created by Ariel Peremen on 9/9/13.
//
//

#import "PostsListController.h"
#import "CellForAdsList.h"

@interface PostsListController ()

@end

@implementation PostsListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSearchBar:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellPost";
    
    // Creating the cell for the buy list
    CellForAdsList *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil)
    {
        cell=[[NSBundle mainBundle] loadNibNamed:@"CellForAdsList" owner:self options:nil][0];
    }
    //Get cell data
//     *stock=[self.StoksListForBuying objectAtIndex:indexPath.row];
//    [cell setCurrentStock:stock];
    
    //change the cell background
//    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greyCell"]];
    
    
    return cell;
}


//Hight of the cell
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
@end
