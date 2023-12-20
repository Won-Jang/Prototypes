/* [Plate dimensions - taille platine] */
// Longueur Length
L=104.3;
// Largeur  Width
W=56.4;
// Rayon des coins ou 0 - Corner radius or 0
RC=3;
// Epaisseur  Thickness
E=2.23;

/* [Dimensions servo] */
//Longueur Length




//Trous rectangulaires X Y longX largY

//DB25
//TS=[[0,4.15,0,0,"DSUB25.stl"]];       // Back
TS=[[0,-5.2,0,0,"DSUB25.stl"]];          // Front
// Potentiometres    X Y angle calage, dia trou dia calage

//Base rectangulaire
difference() {
  union() {  
    cube([L-RC*2,W,E],center=true);
     // for x   
  } // uni


    // trous par objet STL
    for(N=[0:len(TS)-1]) {  
        translate([TS[N][0],TS[N][1],TS[N][2]]) rotate([0,0,TS[N][3]]) import(TS[N][4]);  
        echo("TS[N][1]: ", TS[N][1]);
    }  // for N

   
  
  
}  // diff

