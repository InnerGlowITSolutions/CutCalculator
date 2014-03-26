//
//  CalculationViewController.m
//  CutCalculator
//
//  Created by Rajesh on 20/03/14.
//  Copyright (c) 2014 Innerglow IT Solutions. All rights reserved.
//

#import "CalculationViewController.h"

@interface CalculationViewController ()

-(void)lblCreation:(NSString *)lblText label:(UILabel *)fromLabel;
-(void)txtFldCreation:(NSString *)txtFldText textField:(UITextField *)fromtxtFld;
-(void)settingFramesForUI;
-(void)depthOfCutSlider;
-(void)cuttingSpeedSlider;
-(void)unHideobjects;

@end

@implementation CalculationViewController

@synthesize dropDownTblView;
@synthesize tableArray;
@synthesize searchBar;
@synthesize lblType,lblDia,lblShapeOfCut,lblWorkMaterial,lblFluterCnt,lblDepthOfCut,lblRev,lblCuttingSpeed;
@synthesize typeTxtFld,diaTxtFld,workMaterialTxtFld,fluterCntTxtFld;
@synthesize imgViewSide,imgViewSlot;
@synthesize lblArr,txtFldArr;

/*- (id)init
{
    if (self)
    {
        NSString* nibName = NSStringFromClass([self class]);
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            self = [super initWithNibName:nibName bundle:nil];
        }
        else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            self = [super initWithNibName:[nibName stringByAppendingString:@"Pad"] bundle:nil];
        }
        return self;
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/


#pragma mark- viewdidload


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dbAccess=[[DBModel alloc]init];
    
    UINavigationBar *navBar=[[UINavigationBar alloc]init];
    [navBar setFrame:CGRectMake(0,0,CGRectGetWidth(self.view.frame),40)];
    [navBar setBackgroundColor:[UIColor blueColor]];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Language" style:UIBarButtonItemStylePlain target:self action:@selector(languageSel)];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"Calculation"];
    [navItem setRightBarButtonItem:doneItem animated:YES];
    [navBar setItems:[NSArray arrayWithObject:navItem] animated:YES];
    [self.view addSubview:navBar];
   
    searchcheck=0;
    tableArray=[[NSMutableArray alloc]init];

    //Constant array
    millTypeArr=[NSArray arrayWithObjects:@"2 Flutes Long Neck Short Flute End Mill",@"2 Flutes Micro Square End Mill",@"2 Flutes Micro Ball Nose End Mill",@"2 Flutes Aluminum End Mills",@"3 Flutes Aluminum End Mills",@"T-Blade cutter(tooth level)",@"T-Blade cutter (wrong tooth)",@"Corner rounding cutter",@"L-groove cutter",@"V-groove cutter",@"2 flutes drill end mill",@"Micro-diameter drill",@"High-speed drill",@"For aluminium mills",@"Extra Length mills",@"Micro diameter ball/end mill", nil];
    
    workMaterialArr=[NSArray arrayWithObjects:@"Cast Iron",@"Carbon Steel, Alloy Steel – 750N/mm2",@"Carbon Steel, Alloy Steel – 30 HRC",@"Pre-hardened Steel, Pre-heated Steel – 40 HRC",@"Stainless Steel",@"Aluminum Alloy",@"Silicoaluminum Si<=10%", nil];
    
    fluterCntArr=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    
    diaArr=[NSArray arrayWithObjects:@"0.5",@"0.4",@"0.6",@"0.8",@"0.25",@"0.45", nil];

    
    //labels
    lblType=[[UILabel alloc]init];
    lblDia=[[UILabel alloc]init];
    lblShapeOfCut=[[UILabel alloc]init];
    lblWorkMaterial=[[UILabel alloc]init];
    lblFluterCnt=[[UILabel alloc]init];
    lblDepthOfCut=[[UILabel alloc]init];
    lblRev=[[UILabel alloc]init];
    lblCuttingSpeed=[[UILabel alloc]init];
    
    //sliderLbls
    depthOfCutSliderLbl=[[UILabel alloc]init];
    revSliderLbl=[[UILabel alloc]init];
    cutSpeedSliderLbl=[[UILabel alloc]init];
    
    
    //range lbls
    zeroLblDOC=[[UILabel alloc]init];
    zeroLblRev=[[UILabel alloc]init];
    zeroLblCS=[[UILabel alloc]init];
    maxLblDOC=[[UILabel alloc]init];
    maxLblRev=[[UILabel alloc]init];
    maxLblCS=[[UILabel alloc]init];

    modeLbl=[[UILabel alloc]init];

    productNolbl=[[UILabel alloc]init];

    lblArr=[NSArray arrayWithObjects:lblType,lblDia,lblShapeOfCut,lblWorkMaterial,lblFluterCnt,lblDepthOfCut,lblRev,lblCuttingSpeed,depthOfCutSliderLbl,revSliderLbl,cutSpeedSliderLbl,zeroLblDOC,zeroLblRev,zeroLblCS,maxLblDOC,maxLblRev,maxLblCS,modeLbl,productNolbl, nil];
    NSArray *lblNamesArr=[NSArray arrayWithObjects:@"Type",@"Diameter",@"Shape of cut",@"Work Material",@"Fluter Count",@"Depth Of Cut",@"Rev (min)",@"Cutting Speed (mm/min)",@"0",@"0",@"0",@"0",@"0",@"0",@"max",@"max",@"max",@"Ineffective Mode",@"Product No.", nil];
    for (int i=0; i<lblArr.count; i++)
    {
        [self lblCreation:[lblNamesArr objectAtIndex:i] label:[lblArr objectAtIndex:i]];
    }
    
    //UITextField
    typeTxtFld=[[UITextField alloc]init];
    diaTxtFld=[[UITextField alloc]init];
    workMaterialTxtFld=[[UITextField alloc]init];
    fluterCntTxtFld=[[UITextField alloc]init];

    txtFldArr=[NSArray arrayWithObjects:typeTxtFld,diaTxtFld,workMaterialTxtFld,fluterCntTxtFld, nil];
    NSArray *txtFldNamesArr=[NSArray arrayWithObjects:@"Mill Type",@"Diameter",@"Work Material",@"Fluter Count", nil];
    for (int i=0; i<txtFldArr.count; i++)
    {
        [self txtFldCreation:[txtFldNamesArr objectAtIndex:i] textField:[txtFldArr objectAtIndex:i]];
    }
    
    //UIslider
    depthOfCutSlider=[[UISlider alloc]init];
    depthOfCutSlider.minimumValue=0;
    
    
    UIImage *bgImage = [UIImage imageNamed:@"Slider11.png"];
    depthOfCutSlider.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
    UIImage *sliderTrackImage = [[UIImage imageNamed: @"box.png"] stretchableImageWithLeftCapWidth: 2 topCapHeight: 10];
    UIImage *sliderTrackImage2 = [[UIImage imageNamed: @"box.png"] stretchableImageWithLeftCapWidth: 2 topCapHeight: 10];
    [depthOfCutSlider setMinimumTrackImage: sliderTrackImage forState: UIControlStateNormal];
    [depthOfCutSlider setMaximumTrackImage:sliderTrackImage2 forState: UIControlStateNormal];

    UIImage *sliderThumbImage = [[UIImage imageNamed: @"Thumb.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
    [depthOfCutSlider setThumbImage:sliderThumbImage
                                forState:UIControlStateNormal];
    
    [depthOfCutSlider addTarget:self
                      action:@selector(depthOfCutSlider)
            forControlEvents:UIControlEventValueChanged];
    //depthOfCutSlider.value=0.7;
    depthOfCutSlider.userInteractionEnabled=NO;
    [self.view addSubview:depthOfCutSlider];
    
    revSlider=[[UISlider alloc]init];
    revSlider.minimumValue=0;
    //revSlider.maximumValue=40000;
    //revSlider.maximumTrackTintColor=[UIColor redColor];
    //revSlider.minimumTrackTintColor=[UIColor greenColor];
    
    revSlider.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    [revSlider setMinimumTrackImage: sliderTrackImage forState: UIControlStateNormal];
    [revSlider setMaximumTrackImage:sliderTrackImage2 forState: UIControlStateNormal];
    [revSlider setThumbImage:sliderThumbImage
                           forState:UIControlStateNormal];

    
    [revSlider addTarget:self
                         action:@selector(revSlider)
               forControlEvents:UIControlEventValueChanged];
    revSlider.userInteractionEnabled=NO;
    [self.view addSubview:revSlider];
    
    cuttingSpeedSlider=[[UISlider alloc]init];
    cuttingSpeedSlider.minimumValue=0;
    //cuttingSpeedSlider.maximumValue=2000;
    //cuttingSpeedSlider.maximumTrackTintColor=[UIColor redColor];
    //cuttingSpeedSlider.minimumTrackTintColor=[UIColor greenColor];
   
    cuttingSpeedSlider.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    [cuttingSpeedSlider setMinimumTrackImage: sliderTrackImage forState: UIControlStateNormal];
    [cuttingSpeedSlider setMaximumTrackImage:sliderTrackImage2 forState: UIControlStateNormal];
    [cuttingSpeedSlider setThumbImage:sliderThumbImage
                    forState:UIControlStateNormal];
    
    [cuttingSpeedSlider addTarget:self
                  action:@selector(cuttingSpeedSlider)
        forControlEvents:UIControlEventValueChanged];
    cuttingSpeedSlider.userInteractionEnabled=NO;
    [self.view addSubview:cuttingSpeedSlider];
    
    //uiimageview for side and slot
    imgViewSide = [[UIImageView alloc]init];
    imgViewSide.image = [UIImage imageNamed:@"SideB.png"];
    [self.view addSubview:imgViewSide];
    imgViewSide.userInteractionEnabled=YES;
    
    imgViewSlot = [[UIImageView alloc]init];
    imgViewSlot.image = [UIImage imageNamed:@"SlotB.png"];
    [self.view addSubview:imgViewSlot];
    imgViewSlot.userInteractionEnabled=YES;
    
    //hide images and slider
    depthOfCutSlider.hidden=TRUE;
    cuttingSpeedSlider.hidden=TRUE;
    revSlider.hidden=TRUE;

    imgViewSlot.hidden=TRUE;
    imgViewSide.hidden=TRUE;


    //uitableview
    dropDownTblView = [[UITableView alloc] initWithFrame:
                       CGRectMake(20, 85, 42, 30) style:UITableViewStylePlain];
    dropDownTblView.delegate = self;
    dropDownTblView.dataSource = self;
    dropDownTblView.scrollEnabled = YES;
    dropDownTblView.hidden = YES;
    dropDownTblView.layer.borderWidth = 2;
    dropDownTblView.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.view addSubview:dropDownTblView];

    //UIsearchbar
    searchBar=[[UISearchBar alloc]init];
    searchBar.delegate=self;
	[searchBar setTintColor:[UIColor blackColor]];
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"searchProduct.png"] forState:UIControlStateNormal];
	[self.view addSubview:searchBar];
    searchBar.barTintColor = [UIColor whiteColor];

    [searchBar setTranslucent:NO];
    [self.searchBar setImage:[UIImage imageNamed:@"box.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.searchBar setSearchTextPositionAdjustment:UIOffsetMake(-12, 0)];

    //[self.searchBar setBackgroundImage:[UIImage imageNamed:@"searchProduct.png"]];
    //frame setting for view objects
    [self settingFramesForUI];
    depthOfCutSliderLbl.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
    revSliderLbl.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
    cutSpeedSliderLbl.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
    modeLbl.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
    modeLbl.textColor=[UIColor grayColor];
}

-(void)unHideobjects{
    //hide images and slider
    depthOfCutSlider.hidden=FALSE;
    cuttingSpeedSlider.hidden=FALSE;
    revSlider.hidden=FALSE;
    imgViewSlot.hidden=FALSE;
    imgViewSide.hidden=FALSE;
    
    for (UILabel *lbl in lblArr) {
        lbl.hidden=FALSE;
    }
    for (UITextField *txtfld in txtFldArr) {
        txtfld.hidden=FALSE;
    }
}

#pragma mark- slider
-(void)depthOfCutSlider{
    depthOfCutSliderLbl.text=[NSString stringWithFormat:@"%.3f",depthOfCutSlider.value];

}
-(void)revSlider{
    
    int rev= [[finalSliderValuesArr objectAtIndex:0] intValue];
    
    
    int revCal=(revSlider.value/rev)*100;
    
    int calFactor=cuttingSpeedSlider.maximumValue-(cuttingSpeedSlider.maximumValue/3);

    int speedCal=calFactor/100;

    [cuttingSpeedSlider setValue:revCal*speedCal animated:YES];
    revSliderLbl.text=[NSString stringWithFormat:@"%.1f",revSlider.value];
    cutSpeedSliderLbl.text=[NSString stringWithFormat:@"%.1f",cuttingSpeedSlider.value];
    
    
    if (revSlider.value>=(revSlider.maximumValue/3)*2) {
        modeLbl.text=@"Dangerous mode";
        modeLbl.textColor=[UIColor redColor];
    }
    else if (revSlider.value<(revSlider.maximumValue/3)){
        modeLbl.text=@"Ineffective mode";
        modeLbl.textColor=[UIColor grayColor];
    }
    else{
        modeLbl.text=@"Optimum mode";
        modeLbl.textColor=[UIColor greenColor];
    }
}

-(void)cuttingSpeedSlider
{
     int rev= [[finalSliderValuesArr objectAtIndex:1] intValue];
    
     int revCal=(cuttingSpeedSlider.value/rev)*100;
    
     int calFactor=revSlider.maximumValue-(revSlider.maximumValue/3);
    
     int speedCal=calFactor/100;
    
     [revSlider setValue:revCal*speedCal animated:YES];
     revSliderLbl.text=[NSString stringWithFormat:@"%.1f",revSlider.value];
     cutSpeedSliderLbl.text=[NSString stringWithFormat:@"%.1f",cuttingSpeedSlider.value];
    
    if (cuttingSpeedSlider.value>=(cuttingSpeedSlider.maximumValue/3)*2) {
        modeLbl.text=@"Dangerous mode";
        modeLbl.textColor=[UIColor redColor];
    }
    else if (cuttingSpeedSlider.value<(cuttingSpeedSlider.maximumValue/3)){
        modeLbl.text=@"Ineffective mode";
        modeLbl.textColor=[UIColor grayColor];
    }
    else{
        modeLbl.text=@"Optimum mode";
        modeLbl.textColor=[UIColor greenColor];
    }
}

#pragma mark- lblCreation

-(void)lblCreation:(NSString *)lblText label:(UILabel *)fromLabel{
    fromLabel.text = lblText;
    //UIFont * customFont = [UIFont fontWithName:ProximaNovaSemibold size:12]; //custom font
    //CGSize labelSize = [text sizeWithFont:customFont constrainedToSize:CGSizeMake(380, 20) lineBreakMode:NSLineBreakByTruncatingTail];
    fromLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    fromLabel.numberOfLines = 1;
    fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    //fromLabel.adjustsFontSizeToFitWidth = YES;
    //fromLabel.minimumScaleFactor = 10.0f/12.0f;
    fromLabel.clipsToBounds = YES;
    fromLabel.backgroundColor = [UIColor clearColor];
    fromLabel.textColor = [UIColor blackColor];
    fromLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:fromLabel];
    
    if ([lblText isEqualToString:@"Type"]||[lblText isEqualToString:@"Product No."]) {
        fromLabel.hidden=FALSE;
    }
    else
    {
        fromLabel.hidden=TRUE;
    }
}

#pragma mark- txtFldCreation

-(void)txtFldCreation:(NSString *)txtFldText textField:(UITextField *)fromtxtFld{
    fromtxtFld.borderStyle = UITextBorderStyleRoundedRect;
    fromtxtFld.font = [UIFont systemFontOfSize:12];
    fromtxtFld.placeholder = txtFldText;
    fromtxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
    fromtxtFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    fromtxtFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    fromtxtFld.textAlignment = NSTextAlignmentCenter;
	[fromtxtFld setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    if ([txtFldText isEqualToString:@"Diameter"]) {
        fromtxtFld.keyboardType = UIKeyboardTypeDecimalPad;
    }
    else
    {
        //fromtxtFld.userInteractionEnabled=NO;
        fromtxtFld.keyboardType = UIKeyboardTypeDefault;
    }
    
    if ([txtFldText isEqualToString:@"Fluter Count"]) {
        fromtxtFld.returnKeyType = UIReturnKeyDone;
    }
    else
    {
        fromtxtFld.returnKeyType = UIReturnKeyNext;
    }
    
    fromtxtFld.delegate = self;
    [self.view addSubview:fromtxtFld];
    
    if ([txtFldText isEqualToString:@"Mill Type"]) {
        fromtxtFld.hidden=FALSE;
    }
    else{
        fromtxtFld.hidden=TRUE;
    }
}

#pragma mark- settingFramesForUI

-(void)settingFramesForUI
{
    //uisearchbar
    searchBar.frame=CGRectMake(120, 85, 180, 30);
    
    //UIlabel frames
    productNolbl.frame=CGRectMake(10, 85, 100, 30);
    lblType.frame=CGRectMake(10, 48, 42, 30);
    lblDia.frame=CGRectMake(10, 130, 100, 30);
    lblShapeOfCut.frame=CGRectMake(10, 175, 150, 30);
    lblWorkMaterial.frame=CGRectMake(10, 265, 100, 30);
    lblFluterCnt.frame=CGRectMake(10, 310, 100, 30);
    lblDepthOfCut.frame=CGRectMake(10, 355, 150, 30);
    lblRev.frame=CGRectMake(10, 420, 80, 30);
    lblCuttingSpeed.frame=CGRectMake(10, 485, 180, 30);
    
    //UIslider frames
    cuttingSpeedSlider.frame=CGRectMake(10, 520, 300, 10);
    depthOfCutSlider.frame=CGRectMake(10, 388, 300, 10);
    revSlider.frame=CGRectMake(10, 453, 300, 10);
    
    modeLbl.frame=CGRectMake(CGRectGetWidth(self.view.frame)/2-30, CGRectGetHeight(self.view.frame)-20, 150, 15);

    //Slider Value labels
    depthOfCutSliderLbl.frame=CGRectMake(CGRectGetWidth(self.view.frame)-45, 355, 50, 30);
    revSliderLbl.frame=CGRectMake(CGRectGetWidth(self.view.frame)-45, 420, 50, 30);
    cutSpeedSliderLbl.frame=CGRectMake(CGRectGetWidth(self.view.frame)-45, 485, 50, 30);
    
    //range lbls
    zeroLblDOC.frame=CGRectMake(10, lblDepthOfCut.frame.origin.y+50, 20, 15);
    zeroLblRev.frame=CGRectMake(10, lblRev.frame.origin.y+50, 300, 15);
    zeroLblCS.frame=CGRectMake(10, lblCuttingSpeed.frame.origin.y+58, 300, 15);
    maxLblDOC.frame=CGRectMake(CGRectGetWidth(self.view.frame)-35, lblDepthOfCut.frame.origin.y+50, 50, 15);
    maxLblRev.frame=CGRectMake(CGRectGetWidth(self.view.frame)-35, lblRev.frame.origin.y+50, 50, 15);
    maxLblCS.frame=CGRectMake(CGRectGetWidth(self.view.frame)-35, lblCuttingSpeed.frame.origin.y+58, 50, 15);

    //UItextfield frames
    typeTxtFld.frame=CGRectMake(130, 48, 160, 30);
    diaTxtFld.frame=CGRectMake(130, 130, 160, 30);
    workMaterialTxtFld.frame=CGRectMake(130, 265, 160, 30);
    fluterCntTxtFld.frame=CGRectMake(130, 310, 100, 30);
    
    //Imageview frames
    imgViewSide.frame=CGRectMake(60, 205,  50, 50);
    imgViewSlot.frame=CGRectMake(170, 205, 50, 50);
}

#pragma mark- UITableview Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [tableArray count];    //count number of row from counting array hear cataGorry is An Array
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    // [cell.imageView setImageWithURL:[NSURL URLWithString:@"  http://example.com/image.jpg"]
    // placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.textLabel.text = [tableArray objectAtIndex:[indexPath row]];
    if (cell.textLabel.text.length>9) {
        cell.textLabel.numberOfLines = 2;
    }
    //cell.textLabel.adjustsFontSizeToFitWidth=YES;
    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 12.0 ];
    cell.textLabel.font  = myFont;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *strSelected=[tableArray objectAtIndex:indexPath.row];
    switch (selectedTextField) {
        case 1:{
            typeTxtFld.text=strSelected;
            [self unHideobjects];
            if ([typeTxtFld.text isEqualToString:@"2 Flutes Long Neck Short Flute End Mill"]) {
                workMaterialArr=[NSArray arrayWithObjects:@"Carbon Steel, Alloy Steel – 750N/mm2",@"Carbon Steel, Alloy Steel – 30 HRC",@"Pre-hardened Steel, Pre-heated Steel – 40 HRC", nil];
                millsID=@"1";
                mTypeID=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
                NSLog(@"%@",mTypeID);
                lblDepthOfCut.hidden=FALSE;
                depthOfCutSlider.hidden=FALSE;
                fluterCntTxtFld.hidden=FALSE;
                lblFluterCnt.hidden=FALSE;
                
                depthOfCutSliderLbl.hidden=FALSE;
                zeroLblDOC.hidden=FALSE;
                maxLblDOC.hidden=FALSE;
                
                lblRev.frame=CGRectMake(10, 420, 80, 30);
                lblCuttingSpeed.frame=CGRectMake(10, 485, 180, 30);
                cuttingSpeedSlider.frame=CGRectMake(10, 520, 300, 10);
                revSlider.frame=CGRectMake(10, 453, 300, 10);
                
                
                revSliderLbl.frame=CGRectMake(CGRectGetWidth(self.view.frame)-45, 420, 50, 30);
                cutSpeedSliderLbl.frame=CGRectMake(CGRectGetWidth(self.view.frame)-45, 485, 50, 30);
                                zeroLblRev.frame=CGRectMake(10, lblRev.frame.origin.y+50, 300, 15);
                zeroLblCS.frame=CGRectMake(10, lblCuttingSpeed.frame.origin.y+50, 300, 15);
                maxLblRev.frame=CGRectMake(CGRectGetWidth(self.view.frame)-35, lblRev.frame.origin.y+50, 50, 15);
                maxLblCS.frame=CGRectMake(CGRectGetWidth(self.view.frame)-35, lblCuttingSpeed.frame.origin.y+50, 50, 15);
                
                
            }
            else
            {
                workMaterialArr=[NSArray arrayWithObjects:@"Cast Iron",@"Carbon Steel, Alloy Steel – 750N/mm2",@"Carbon Steel, Alloy Steel – 30 HRC",@"Pre-hardened Steel, Pre-heated Steel – 40 HRC",@"Stainless Steel",@"Aluminum Alloy",@"Silicoaluminum Si<=10%", nil];
                depthOfCutSlider.hidden=TRUE;
                fluterCntTxtFld.hidden=TRUE;
                lblFluterCnt.hidden=TRUE;
                lblDepthOfCut.hidden=TRUE;
                
                depthOfCutSliderLbl.hidden=TRUE;
                zeroLblDOC.hidden=TRUE;
                maxLblDOC.hidden=TRUE;
                
                lblCuttingSpeed.frame=CGRectMake(10, 455, 180, 30);
                cuttingSpeedSlider.frame=CGRectMake(10, 495, 300, 10);
                lblRev.frame=CGRectMake(10, 340, 80, 30);
                revSlider.frame=CGRectMake(10, 373, 300, 10);
                
                
                revSliderLbl.frame=CGRectMake(CGRectGetWidth(self.view.frame)-45, lblRev.frame.origin.y, 50, 30);
                cutSpeedSliderLbl.frame=CGRectMake(CGRectGetWidth(self.view.frame)-45, lblCuttingSpeed.frame.origin.y, 50, 30);
               
                zeroLblRev.frame=CGRectMake(10, lblRev.frame.origin.y+50, 50, 15);
                zeroLblCS.frame=CGRectMake(10, lblCuttingSpeed.frame.origin.y+58, 50, 15);
                maxLblRev.frame=CGRectMake(CGRectGetWidth(self.view.frame)-35, lblRev.frame.origin.y+50, 50, 15);
                maxLblCS.frame=CGRectMake(CGRectGetWidth(self.view.frame)-35, lblCuttingSpeed.frame.origin.y+58, 50, 15);
            }

            if ([strSelected isEqualToString:@"2 flutes drill end mill"]||[strSelected isEqualToString:@"Micro-diameter drill"]||[strSelected isEqualToString:@"High-speed drill"]) {
                [imgViewSide setImage:[UIImage imageNamed:@"SideG.png"]];
                [imgViewSlot setImage:[UIImage imageNamed:@"SlotB.png"]];
                imgViewSide.userInteractionEnabled=NO;
                imgViewSlot.userInteractionEnabled=NO;
            }
            else
            {
                imgViewSide.userInteractionEnabled=YES;
                imgViewSlot.userInteractionEnabled=YES;
            }
            break;
        }
        case 2:
        {
            workMaterialTxtFld.text=strSelected;
            materialID=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
            //diaArr=[dbAccess fetchDiaArr:millsID materialID:materialID mtypeID:mTypeID];
            break;
        }
        case 3:
        {
            fluterCntTxtFld.text=strSelected;
            materialID=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
            
            finalSliderValuesArr=[dbAccess fetchSliderValues:millsID mtypeID:mTypeID material:materialID diameter:diaTxtFld.text fluteCount:fluterCntTxtFld.text];
            NSLog(@"finalSliderValuesArr %@",finalSliderValuesArr);
            
            //depthOfCutSlider.maximumValue=[[finalSliderValuesArr objectAtIndex:2] floatValue]*2;
            //revSlider.maximumValue=[[finalSliderValuesArr objectAtIndex:0] floatValue]*2;
            //cuttingSpeedSlider.maximumValue= [[finalSliderValuesArr objectAtIndex:1] floatValue]*2;
            
            depthOfCutSlider.maximumValue=[[finalSliderValuesArr objectAtIndex:2] floatValue]+([[finalSliderValuesArr objectAtIndex:2] floatValue])/2;
            revSlider.maximumValue=[[finalSliderValuesArr objectAtIndex:0] floatValue]+([[finalSliderValuesArr objectAtIndex:0] floatValue])/2;
            cuttingSpeedSlider.maximumValue=[[finalSliderValuesArr objectAtIndex:1] floatValue]+([[finalSliderValuesArr objectAtIndex:1] floatValue])/2;
            
            
            depthOfCutSlider.value=[[finalSliderValuesArr objectAtIndex:2] floatValue];
            
            revSlider.value=[[finalSliderValuesArr objectAtIndex:0] floatValue];
            cuttingSpeedSlider.value=[[finalSliderValuesArr objectAtIndex:1] floatValue];
            
            depthOfCutSliderLbl.text=[NSString stringWithFormat:@"%@",[finalSliderValuesArr objectAtIndex:2]];
            revSliderLbl.text=[NSString stringWithFormat:@"%@",[finalSliderValuesArr objectAtIndex:0]];
            cutSpeedSliderLbl.text=[NSString stringWithFormat:[finalSliderValuesArr objectAtIndex:1],[finalSliderValuesArr objectAtIndex:1]];
            
            revSlider.userInteractionEnabled=YES;
            cuttingSpeedSlider.userInteractionEnabled=YES;
            
            modeLbl.text=@"Optimum mode";
            modeLbl.textColor=[UIColor greenColor];
            break;
        }
        case 4:
        {
            diaTxtFld.text=strSelected;
            materialID=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
            fluterCntArr=[dbAccess fetchFluteArr:millsID diameter:strSelected mtypeID:mTypeID material:materialID];
            
            if (![millsID isEqualToString:@"1"]) {
                finalSliderValuesArr=[dbAccess fetchSliderValues:millsID mtypeID:mTypeID material:materialID diameter:diaTxtFld.text fluteCount:fluterCntTxtFld.text];
               
                revSlider.maximumValue=[[finalSliderValuesArr objectAtIndex:0] floatValue]*2;
                cuttingSpeedSlider.maximumValue= [[finalSliderValuesArr objectAtIndex:1] floatValue]*2;
                
                revSlider.value=[[finalSliderValuesArr objectAtIndex:0] floatValue]+([[finalSliderValuesArr objectAtIndex:0] floatValue])/2;
                cuttingSpeedSlider.value=[[finalSliderValuesArr objectAtIndex:1] floatValue]+([[finalSliderValuesArr objectAtIndex:1] floatValue])/2;                NSLog(@"finalSliderValuesArr %@",finalSliderValuesArr);
                
                revSliderLbl.text=[NSString stringWithFormat:@"%@",[finalSliderValuesArr objectAtIndex:0]];
                cutSpeedSliderLbl.text=[NSString stringWithFormat:[finalSliderValuesArr objectAtIndex:1],[finalSliderValuesArr objectAtIndex:1]];
                
                revSlider.userInteractionEnabled=YES;
                cuttingSpeedSlider.userInteractionEnabled=YES;
                
                modeLbl.text=@"Optimum mode";
                modeLbl.textColor=[UIColor greenColor];
            }
            break;
        }
        default:
            break;
    }
    if (searchcheck==1)
    {
        searchBar.text=strSelected;
        [self unHideobjects];

        dropDownTblView.hidden=YES;
        searchcheck=0;
        [searchBar resignFirstResponder];

    }
    dropDownTblView.hidden=YES;
    searchBar.hidden=FALSE;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

#pragma mark -
#pragma mark SearchBar_Delegates
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)search_Bar{
    searchcheck=1;
    dropDownTblView.hidden=FALSE;
    dropDownTblView.frame=CGRectMake(searchBar.frame.origin.x+5, searchBar.frame.origin.y+37, searchBar.frame.size.width-10,200);
	tableArray=[millTypeArr mutableCopy];
    [dropDownTblView reloadData];
    return  YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)search_Bar
{
    NSLog(@"searchBarSearchButtonClicked");
	[search_Bar resignFirstResponder];
}
- (void)searchBar:(UISearchBar *)search_Bar textDidChange:(NSString *)searchText
{
    [dropDownTblView reloadData];
	str_searchText=searchText;
	if([str_searchText isEqualToString:@""])
	{
		[search_Bar resignFirstResponder];
        tableArray=[millTypeArr copy];
		[dropDownTblView reloadData];
	}
    else
    {
        NSPredicate *textPredicate =
        [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",searchText];
        NSArray *searchedArr =
        [tableArray filteredArrayUsingPredicate:textPredicate];
        [tableArray removeAllObjects];
        tableArray=[searchedArr copy];
        [dropDownTblView reloadData];
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)search_Bar
{
    NSLog(@"searchBarCancelButtonClicked");
    [tableArray removeAllObjects];
    tableArray=[millTypeArr copy];
    [dropDownTblView reloadData];
}

#pragma mark- UITextfield Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //[tableArray removeAllObjects];
    if(textField==typeTxtFld){
        selectedTextField=1;
        searchBar.hidden=TRUE;
        tableArray=[millTypeArr mutableCopy];
        [dropDownTblView reloadData];
        dropDownTblView.hidden=FALSE;
        dropDownTblView.frame=CGRectMake(textField.frame.origin.x, textField.frame.origin.y+30, textField.frame.size.width+30,300);
        return NO;
    }
    if(textField==diaTxtFld){
        searchBar.hidden=FALSE;
        selectedTextField=4;
        tableArray=[diaArr mutableCopy];
        [dropDownTblView reloadData];
        dropDownTblView.hidden=FALSE;
        dropDownTblView.frame=CGRectMake(textField.frame.origin.x, textField.frame.origin.y+30, textField.frame.size.width,100);
        return NO;
    }
    if(textField==workMaterialTxtFld){
        selectedTextField=2;
        tableArray=[workMaterialArr mutableCopy];
        [dropDownTblView reloadData];

        dropDownTblView.hidden=FALSE;
        dropDownTblView.frame=CGRectMake(textField.frame.origin.x, textField.frame.origin.y+30, textField.frame.size.width+30,100);
        return NO;
    }
    if(textField==fluterCntTxtFld)
    {
        selectedTextField=3;
        tableArray=[fluterCntArr mutableCopy];
        [dropDownTblView reloadData];

        dropDownTblView.hidden=FALSE;
        dropDownTblView.frame=CGRectMake(textField.frame.origin.x, textField.frame.origin.y+30, textField.frame.size.width,100);
        return NO;
    }
    searchBar.hidden=FALSE;

    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==typeTxtFld){
		[diaTxtFld becomeFirstResponder];
        searchBar.hidden=FALSE;
}
    else if(textField==diaTxtFld)
		[workMaterialTxtFld becomeFirstResponder];
    else if(textField==workMaterialTxtFld)
    {
        [fluterCntTxtFld becomeFirstResponder];
    }
    else if(textField==fluterCntTxtFld)
    {
        [fluterCntTxtFld resignFirstResponder];
    }
    dropDownTblView.hidden=TRUE;
    return YES;
}

#pragma mark- Touch Delegate
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if (touch.view == imgViewSide)
    {
        [imgViewSide setImage:[UIImage imageNamed:@"SideH.png"]];
        [imgViewSlot setImage:[UIImage imageNamed:@"SlotB.png"]];
    }
    else if (touch.view == imgViewSlot){
        [imgViewSide setImage:[UIImage imageNamed:@"SideB.png"]];
        [imgViewSlot setImage:[UIImage imageNamed:@"SlotH.png"]];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];
	[typeTxtFld resignFirstResponder];
    [diaTxtFld resignFirstResponder];
    [workMaterialTxtFld resignFirstResponder];
    [fluterCntTxtFld resignFirstResponder];
    dropDownTblView.hidden=TRUE;
    searchBar.hidden=FALSE;
    [searchBar resignFirstResponder];

}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
-(void)languageSel{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
