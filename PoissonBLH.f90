      real*8 function PoissonBLH(BLH,gra,sfh,nlat,nlon,hd,dr,GRS)
      !按严密球面积分公式计算Possion积分
      !dr-积分半径m
!-------------------------------------------------------------
      implicit none
	integer::i,j,nlat,nlon,i0,j0,ni,nj
	real*8::dr,gra(nlat,nlon),sfh(nlat,nlon)
	real*8::GRS(6),hd(6),pi,RAD,ds,mdr,rr,r0,r1,tmp,tt
	real*8::BLH(3),XYZ(3),rln(3),BLH0(3),XYZ0(3),BLH1(3),XYZ1(3),rln1(3)
	real*8 CGrdPntD2,L0,L1,SK,rst,gra0
!-----------------------------------------------------------------
      pi=datan(1.d0)*4.d0;RAD=pi/180.d0;BLH0=BLH
      BLH0(3)=CGrdPntD2(BLH(2),BLH(1),sfh,nlat,nlon,hd)!计算点正下方地面点位置
      gra0=CGrdPntD2(BLH(2),BLH(1),gra,nlat,nlon,hd)!计算点正下方地面点扰动场元值
      call BLH_XYZ(GRS,BLH0,XYZ0);r0=dsqrt(XYZ0(1)**2+XYZ0(2)**2+XYZ0(3)**2)
      call BLH_RLAT(GRS,BLH,rln);rr=rln(1);call BLH_XYZ(GRS,BLH,XYZ)
      ni=nint(dr/r0/RAD/hd(6)+1.d0) !积分半径dr对应的地面格网数
      nj=nint(dr/r0/RAD/hd(5)/dcos(rln(2)*RAD)+1.d0)
	i0=nint((BLH(1)-hd(3))/hd(6)+0.5d0)
	j0=nint((BLH(2)-hd(1))/hd(5)+0.5d0)!计算点所在的地面格网i0,j0
      rst=gra0*(r0/rr)**2!!特殊改进
	do i=i0-ni,i0+ni
	  if(i<1.or.i>nlat)goto 9100
        BLH1(1)=hd(3)+(real(i)-0.5d0)*hd(6)
	  do j=j0-nj,j0+nj
	    if(j<1.or.j>nlon)goto 9101
          if(i==i0.and.j==j0)goto 9101
	    BLH1(2)=hd(1)+(real(j)-0.5d0)*hd(5)
          BLH1(3)=sfh(i,j);call BLH_XYZ(GRS,BLH1,XYZ1)
          L0=dsqrt((XYZ1(1)-XYZ0(1))**2+(XYZ1(2)-XYZ0(2))**2+(XYZ1(3)-XYZ0(3))**2)
          if(L0>dr)goto 9101
          L1=dsqrt((XYZ1(1)-XYZ(1))**2+(XYZ1(2)-XYZ(2))**2+(XYZ1(3)-XYZ(3))**2)
          call BLH_RLAT(GRS,BLH1,rln1);r1=rln1(1)
          ds=hd(5)*hd(6)*RAD**2*dcos(rln1(2)*RAD)*r1**2
          rst=rst+(gra(i,j)-gra0)*(rr**2-r1**2)/L1**3*ds/4.d0/pi/rr
9101      continue
	  enddo
9100    continue
	enddo
	PoissonBLH=rst
9002	return
      end
