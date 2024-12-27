!  Poissonnumericalintegral.f90 
!
!  FUNCTIONS:
!  Poissonnumericalintegral - Entry point of console application.
!
!****************************************************************************
      program Poissonnumericalintegral
      implicit none
	character*800::calcpntfl,sfhhgrdfl,gravgrdfl
	integer knd
	real*8::dr
!---------------------------------------------------------------------
      !输入计算点文件名
      !Input the calculation point file on the boundary surface.
      write(calcpntfl,*)'calcpnt.txt'
      !输入边界面大地高格网文件名
      !Input the ellipsoidal height grid file of the boundary  surface.
      write(sfhhgrdfl,*)'landgeoidhgt.dat'
      !输入边界面上残差场元格网文件名。
      !Input residual gravity field element grid file on the boundary  surface.
      !程序要求等位面大地高格网及其面上残差场元格网有相同的格网规格
      !The same grid specifications required for the ellipsoidal height grid of the boundary
      !surface and residual field element grid on the surface.
      write(gravgrdfl,*)'resGMlgeoid541_1800.ksi'
      !输入积分半径(m)
      dr=120.d3!Integral radius (m)
      write(*, *)"    Begin compulation......"
      call Possionnumintegral(calcpntfl,sfhhgrdfl,gravgrdfl,dr)
      pause
      end

