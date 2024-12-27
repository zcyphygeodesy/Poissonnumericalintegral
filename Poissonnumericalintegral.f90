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
      !���������ļ���
      !Input the calculation point file on the boundary surface.
      write(calcpntfl,*)'calcpnt.txt'
      !����߽����ظ߸����ļ���
      !Input the ellipsoidal height grid file of the boundary  surface.
      write(sfhhgrdfl,*)'landgeoidhgt.dat'
      !����߽����ϲвԪ�����ļ�����
      !Input residual gravity field element grid file on the boundary  surface.
      !����Ҫ���λ���ظ߸����������ϲвԪ��������ͬ�ĸ������
      !The same grid specifications required for the ellipsoidal height grid of the boundary
      !surface and residual field element grid on the surface.
      write(gravgrdfl,*)'resGMlgeoid541_1800.ksi'
      !������ְ뾶(m)
      dr=120.d3!Integral radius (m)
      write(*, *)"    Begin compulation......"
      call Possionnumintegral(calcpntfl,sfhhgrdfl,gravgrdfl,dr)
      pause
      end

