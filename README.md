## Fortran codes for Poisson numerical integral operation on gravity field element
https://www.zcyphygeodesy.com/en/h-nd-149.html
## [Algorithm purpose]
&emsp;```From the ellipsoidal height grid of the boundary surface and the residual anomalous gravity field element grid on the surface, compute the residual anomalous gravity field element on or outside the geoid by the Poisson integral. ```  
&emsp;```The Poisson integral is the solution of the first boundary value problem in the mathematical sense, and the boundary surface need be not an equipotential surface.```  
&emsp;```The edge effect of the Poisson integral here is small, which can effectively suppress the attenuation of short-wave signals, and is suitable for upward and downward analytical continuation.```  
&emsp;```You can call this function repeatedly to iteratively perform the Poisson integral operation. In general, once iteration and at most 3 iterations are sufficient to meet the accuracy requirements in most cases.```
![](https://24192633.s21i.faiusr.com/2/ABUIABACGAAg8_zltwYo8NG05gIwpQ047gg.jpg)
## [Main program for test entrance]
    Poissonnumericalintegral.f90
    Input parameters: dr - the integral radius (m).
    Input parameters: calcpntfl - the calculation point file name on the equipotential boundary surface. The record format of the input calculation point file: ID (point no / point name), longitude (decimal degrees), latitude (decimal degrees), ellipsoidal height (m), ......
    Input parameters: sfhhgrdfl - the ellipsoidal height grid file of the boundary surface . The grid will be employed to calculate the integral distance where the height anomaly grid is located.
    Input parameters: gravgrdfl - the residual field element grid file name on the surface.
    The same grid specifications are required for the ellipsoidal height grid of the boundary  surface and residual field element grid on the surface.
## (1) Module for numerical integral of Poisson on residual field element
    Possionnumintegral(calcpntfl,sfhhgrdfl,gravgrdfl,dr)
    The output file reslt.txt, whose record format: Behind the record of the calculation point file, appends 1 column of the integral value of residual field element.
## (2) Module for Poisson integral operation on residual field element
    real*8 function PoissonBLH(BLH,gra,sfh,nlat,nlon,hd,dr,GRS)
    Input parameters: BLH(3) - longitude (decimal degrees), latitude (decimal degrees), ellipsoidal height (m) of the calculation point.
    Input parameters: sfh(nlat,nlon) - the ellipsoidal height grid of the boundary surface, which employed to calculate the integral distance.
    Input parameters: gra(nlat,nlon) - the residual field element grid on the surface.
    Input parameters: hd(6) - the grid specification parameters (minimum and maximum longitude, minimum and maximum latitude, longitude and latitude intervals of a cell grid).
    Input parameters: GRS(6) - gm, ae, j2, omega, 1/f, default value
    Return - the calculated residual field element at the calculation point (in same unit with the input residual field element).
## (3) Other auxiliary modules
    BLH_RLAT(GRS, BLH, RLAT); BLH_XYZ(GRS, BLH, XYZ)
    CGrdPntD2(lon,lat,dt,row,col,hd); PickRecord(line, kln, rec, nn)
## [For compile and link]
    Fortran90, 132 Columns fixed format. Fortran compiler for any operating system. No external link library required.
The zip compression package includes the test project in visual studio 2017 - intel fortran integrated environment, DOS executable test file and all input and output data.
