// Yet Another Parameterized Projectbox generator
//
//  This is a box for the A4091 active terminator
//

// Label depth: positive = debossed/engraved (FDM), negative = embossed/raised (resin/SLA)
// Override from command line: 0.1 for FDM, -0.4 for resin/SLA
labelDepthVal = -0.4;

// Label text (override from command line for different devices)
labelText = "A4091 Terminator";

include <../YAPP_Box/YAPPgenerator_v3.scad>

//-- which part(s) do you want to print?
printBaseShell        = true;
printLidShell         = true;
printSwitchExtenders  = false;

//-- pcb dimensions -- very important!!!
pcbLength           = 69.6; // Front to back
pcbWidth            = 24; // Side to side
pcbThickness        = 2.2;
                            
//-- padding between pcb and inside wall
paddingFront        = 3;
paddingBack         = 3;
paddingRight        = 3;
paddingLeft         = 3;

//-- Edit these parameters for your own box dimensions
wallThickness       = 2.0;
basePlaneThickness  = 2.0;
lidPlaneThickness   = 2.0;

//-- Total height of box = lidPlaneThickness 
//                       + lidWallHeight 
//--                     + baseWallHeight 
//                       + basePlaneThickness
//-- space between pcb and lidPlane :=
//--      (bottonWallHeight+lidWallHeight) - (standoffHeight+pcbThickness)
baseWallHeight      = 13;
lidWallHeight       = 2;

//-- ridge where base and lid off box can overlap
//-- Make sure this isn't less than lidWallHeight
ridgeHeight         = 4.0;
ridgeSlack          = 0.3;
roundRadius         = 2.0;

//-- Box edge style (added in YAPP v3.2)
//--   0 = all edges rounded (original v30 look)
//--   1 = all edges square
//--   2 = all edges chamfered
//--   3 = square top/bottom, rounded vertical
//--   4 = square top/bottom, chamfered vertical
//--   5 = chamfered top/bottom, rounded vertical
boxType             = 5;

//-- How much the PCB needs to be raised from the base
//-- to leave room for solderings and whatnot
standoffHeight      = 2.0;  //-- used only for pushButton and showPCB
standoffPinDiameter = 3.8;
standoffHoleSlack   = 0.4;
standoffDiameter    = 6.0;

//-- C O N T R O L -------------//-> Default ---------
showSideBySide      = true;     //-> true
previewQuality      = 5;        //-> from 1 to 32, Default = 5
renderQuality       = 32;       //-> from 1 to 32, Default = 8
onLidGap            = 0;
shiftLid            = 5;
colorLid            = "YellowGreen";   
alphaLid            = 1;//0.25;   
colorBase           = "BurlyWood";
alphaBase           = 1;//0.25;
hideLidWalls        = false;    //-> false
hideBaseWalls       = false;    //-> false
showOrientation     = true;
showPCB             = false;
showSwitches        = false;
showPCBmarkers      = false;
showShellZero       = false;
showCenterMarkers   = false;
inspectX            = 0;        //-> 0=none (>0 from back)
inspectY            = 0;        //-> 0=none (>0 from right)
inspectXfromBack    = false;    // View from the inspection cut foreward
inspectYfromLeft    = true;     // View from the inspection cut to the right
inspectZfromTop     = true;
//-- C O N T R O L ---------------------------------------

//===================================================================
// *** PCB Supports ***
// Pin and Socket standoffs 
//-------------------------------------------------------------------
//  Default origin =  yappCoordPCB : pcb[0,0,0]
//
//  Parameters:
//   Required:
//    (0) = posx
//    (1) = posy
//   Optional:
//    (2) = Height to bottom of PCB : Default = standoffHeight
//    (3) = PCB Gap : Default = -1 : Default for yappCoordPCB=pcbThickness, yappCoordBox=0
//    (4) = standoffDiameter    Default = standoffDiameter;
//    (5) = standoffPinDiameter Default = standoffPinDiameter;
//    (6) = standoffHoleSlack   Default = standoffHoleSlack;
//    (7) = filletRadius (0 = auto size)
//    (n) = { <yappBoth> | yappLidOnly | yappBaseOnly }
//    (n) = { yappHole, <yappPin> } // Baseplate support treatment
//    (n) = { <yappAllCorners> | yappFrontLeft | yappFrontRight | yappBackLeft | yappBackRight }
//    (n) = { yappCoordBox, <yappCoordPCB> }  
//    (n) = { yappNoFillet }
//-------------------------------------------------------------------

pcbStands = [
  [5.5,4.735,  yappBoth, yappPin, yappFrontLeft]
 ,[64.1,10.9,  yappPin, yappBoth, yappFrontLeft]
];


//===================================================================
//  *** Cutouts ***
//    There are 6 cutouts one for each surface:
//      cutoutsBase, cutoutsLid, cutoutsFront, cutoutsBack, cutoutsLeft, cutoutsRight
//-------------------------------------------------------------------
//  Default origin = yappCoordBox: box[0,0,0]
//
//                        Required                Not Used        Note
//                      +-----------------------+---------------+------------------------------------
//  yappRectangle       | width, length         | radius        |
//  yappCircle          | radius                | width, length |
//  yappRoundedRect     | width, length, radius |               |     
//  yappCircleWithFlats | width, radius         | length        | length=distance between flats
//  yappCircleWithKey   | width, length, radius |               | width = key width length=key depth
//  yappPolygon         | width, length         | radius        | yappPolygonDef object must be provided
//
//  Parameters:
//   Required:
//    (0) = from Back
//    (1) = from Left
//    (2) = width
//    (3) = length
//    (4) = radius
//    (5) = shape : {yappRectangle | yappCircle | yappPolygon | yappRoundedRect | yappCircleWithFlats | yappCircleWithKey}
//  Optional:
//    (6) = depth : Default = 0/Auto : 0 = Auto (plane thickness)
//    (7) = angle : Default = 0
//    (n) = { yappPolygonDef } : Required if shape = yappPolygon specified -
//    (n) = { yappMaskDef } : If a yappMaskDef object is added it will be used as a mask for the cutout.
//    (n) = { [yappMaskDef, hOffset, vOffset, rotations] } : If a list for a mask is added it will be used as a mask for the cutout. With the Rotation and offsets applied. THis can be used to fine tune the mask placement in the opening.
//    (n) = { <yappCoordBox> | yappCoordPCB }
//    (n) = { <yappOrigin>, yappCenter }
//  (n) = { yappLeftOrigin, <yappGlobalOrigin> } // Only affects Top, Back and Right Faces
//-------------------------------------------------------------------

cutoutsRight =  
[
  // Cutout for SCSI IDC50
 [34.5, 6-pcbThickness ,72.0,10.1, 0, yappRectangle , yappCenter, yappCoordPCB] 

 ];


//===================================================================
//  *** Snap Joins ***
//-------------------------------------------------------------------
//  Default origin = yappCoordBox: box[0,0,0]
//
//  Parameters:
//   Required:
//    (0) = posx | posy
//    (1) = width
//    (n) = yappLeft / yappRight / yappFront / yappBack (one or more)
//   Optional:
//    (n) = { <yappOrigin> | yappCenter }
//    (n) = { yappSymmetric }
//    (n) = { yappRectangle } == Make a diamond shape snap
//-------------------------------------------------------------------

snapJoins =   
[
  [(shellWidth/2),     10, yappFront,yappBack, yappCenter, yappRectangle]
 ,[(shellLength/2),    10, yappLeft, yappCenter, yappRectangle]
];

labelsPlane =
[
    [shellLength/2, shellWidth/2, 180, labelDepthVal, yappLid, "Optima:style=bold", 5,
     labelText, 0, yappTextLeftToRight, yappTextHAlignCenter, yappTextVAlignCenter ]

];

//---- This is where the magic happens ----
YAPPgenerate();
