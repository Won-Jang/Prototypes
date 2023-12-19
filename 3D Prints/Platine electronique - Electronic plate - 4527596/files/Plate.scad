/* [Plate dimensions - taille platine] */
// Longueur Length
L=70;
// Largeur  Width
W=50;
// Rayon des coins ou 0 - Corner radius or 0
RC=0;
// Epaisseur  Thickness
E=2;

/* [Dimensions servo] */
//Longueur Length
SL=41.3;
//Largeur Width
SW=20.7;
//Jeu  Tolerance
SD=0.8;
/* [Renforts  ] */
//ajouter en longueur - Add in length
SPX=14.0;       //Renfort
//ajouter en largeur  - Add in width
SPY=6.0;
// Epaisseur ) Tickness
E1=4.0;

/* [Trous de fixation servo fixing holes] */
//Espacement en longueur Distance in length
TX=50.3;
//Espacement en largeur Distance in width
TY=10.3;
//Diamètre
TD=4.0;

module dummy() {}; // END OF CUSTOMIZER PARAMETERS
// FIN DES PARAMETRES POUR CUSTOMIZER

// FOLLOWING PARMS MUST BE EDITED HERE
// LES PARAMETRES SUIVANTS DOIVENT ETRE EDITES ICI

//Trous circulaires de fixation et autres  X Y dia
T=[
[-90,40,5],   // trous coins  Corner holes
[-90,-40,5],
[90,40,5],
[90,-40,5],

[67.5,0,15]
];
//Trous rectangulaires X Y longX largY

//DB25
TS=[
[0,0,0,0,"DSUB25.stl"]];

// Potentiometres    X Y angle calage, dia trou dia calage


/* [Positions des servos (centre X,Y  , angle]  */


//===============  NE RIEN CHANGER PLUS LOIN =======
//===============  DO NOT EDIT AFTER THIS POINT =======

module Servo(x,y,a) {
    translate([x,y,-5]) rotate([0,0,a]) cube([SL,SW,20],center=true);
    
    Trous(x,y,a);
}  // Servo

module Trous(x,y,a) {
    translate([x,y,-5]) rotate([0,0,a]) {
    
    for(X=[-TX/2,+TX/2]) {
        for (Y=[-TY/2,+TY/2]) {           
           translate([X,Y,-5]) cylinder(d=TD,h=20,$fn=60);          
        }  // for X
    }  // for Y
} // rotate    
}  // Trous

module Pot(x,y,a,D1,D2) {
    translate([x,y,-10]) cylinder(d=D1,h=40,$fn=120);
    translate([x+D2*2*cos(a),y+D2*2*sin(a)-D2/4,-10]) cylinder(d=D2,h=40,$fn=120);
}  // Pot


//Base rectangulaire
difference() {
  union() {  
    cube([L-RC*2,W,E],center=true);
    cube([L,W-RC*2,E],center=true);
    for(x=[-L/2+RC,L/2-RC]) {    
        for(y=[-W/2+RC,W/2-RC]) {    
          translate([x,y,-E/2]) cylinder(r=RC,h=E,$fn=240);
      } // for y
    }  // for x   
  } // uni
  
    // on enleve ce qui suit

    // trous circulaires
    for(N=[0:len(T)-1]) {  
        translate([T[N][0],T[N][1],-5]) cylinder(d=T[N][2],h=20,$fn=120);
    }   // for N circ
 
    // trous rectangulaires
    for(N=[0:len(R)-1]) {  
        translate([R[N][0],R[N][1],-5]) cube([R[N][2],R[N][3],20],center=true);
    }   // for N rect 

    // trous pour servos
    for(N=[0:len(S)-1]) {  
        Servo(S[N][0],S[N][1],S[N][2]);  
    }  // for N

    // trous par objet STL
    for(N=[0:len(TS)-1]) {  
        translate([TS[N][0],TS[N][1],TS[N][2]]) rotate([0,0,TS[N][3]]) import(TS[N][4]);  
    }  // for N

   
  
  
}  // diff

