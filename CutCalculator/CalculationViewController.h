//
//  CalculationViewController.h
//  CutCalculator
//
//  Created by Rajesh on 20/03/14.
//  Copyright (c) 2014 Innerglow IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import "DBModel.h"

@class DBModel;
@interface CalculationViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    BOOL Slot,Side;
    
    UILabel *recommendLblrev,*recommendLblCuttingSpeed,*recommendLblDOC,*recommendLblWOC;
    
    UILabel *lblType,*lblDia,*lblShapeOfCut,*lblWorkMaterial,*lblFluterCnt,*lblDepthOfCut,*lblRev,*lblCuttingSpeed,*productNolbl,*lblWidthOfCutSlider;
    
    UITextField *typeTxtFld,*diaTxtFld,*workMaterialTxtFld,*fluterCntTxtFld;
    
    UITableView *dropDownTblView;
    
    NSMutableArray *tableArray;
    
    NSArray *millTypeArr,*workMaterialArr,*fluterCntArr,*diaArr;
    
    UISlider *depthOfCutSlider,*revSlider,*cuttingSpeedSlider,*widthOfCutSlider;
    
    //UILabel *depthOfCutSliderLbl,*revSliderLbl,*cutSpeedSliderLbl;
    
    UILabel *zeroLblDOC,*zeroLblRev,*zeroLblCS,*maxLblDOC,*maxLblRev,*maxLblCS,*maxLblWOC,*zeroLblWOC;
    
    UILabel *modeLbl;
    
    UIImageView *imgViewSide,*imgViewSlot,*drillImage;
    
    UIView *lineView;
    
    int selectedTextField,searchcheck;
    
    UISearchBar *searchBar;
    
    NSString *str_searchText;
    
    NSString *millsID,*materialID,*mTypeID,*fluteCount;
    
    NSArray *finalSliderValuesArr;
    
    DBModel *dbAccess;
   
    NSArray *txtFldArr,*lblArr;
    
    NSArray *productIDArr;
}

@property(nonatomic,strong)    NSArray *txtFldArr,*lblArr,*productIDArr;
@property(nonatomic,strong)NSMutableArray *tableArray;
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UITableView *dropDownTblView;
@property(nonatomic,strong)UILabel *lblType,*lblDia,*lblShapeOfCut,*lblWorkMaterial,*lblFluterCnt,*lblDepthOfCut,*lblRev,*lblCuttingSpeed;
@property(nonatomic,strong)UITextField *typeTxtFld,*diaTxtFld,*workMaterialTxtFld,*fluterCntTxtFld;
@property(strong,nonatomic)    UIImageView *imgViewSide,*imgViewSlot;

@end
