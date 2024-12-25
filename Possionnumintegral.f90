      subroutine Possionnumintegral(calcpntfl,sfhhgrdfl,gravgrdfl,dr)
      !dr-积分半径(m) Integral radius (m)
      implicit none
	character*800::calcpntfl,sfhhgrdfl,gravgrdfl
 	character*800::line,str,astr
      integer sn,len,astat(8)
	integer i,j,nlon,nlat,kk
	real*8::dr,hd(6),hd1(6),hd2(6),rec(800)
	real*8::GRS(6),BLH(3)
	real*8::PoissonBLH,rst
	real*8,allocatable::gra(:,:),sfh(:,:)
	integer::status=0
!---------------------------------------------------------------------
      GRS(1)= 3.986004415d14; GRS(2)=6378136.3d0; GRS(3)=1.082636277388d-3
      GRS(4) = 7.292115d-5; GRS(5) = 1.d0/298.25641153d0
      open(unit=8,file=gravgrdfl,status="old",iostat=status)
      if(status/=0)goto 902
      read(8,'(a)') line
      call PickRecord(line,len,rec,sn)
      hd(1:6)=rec(1:6)
	nlat=nint((hd(4)-hd(3))/hd(6))
	nlon=nint((hd(2)-hd(1))/hd(5))
	hd(5)=(hd(2)-hd(1))/real(nlon)
	hd(6)=(hd(4)-hd(3))/real(nlat)
 	allocate(gra(nlat,nlon), stat=astat(1))
 	allocate(sfh(nlat,nlon), stat=astat(2))
	if (sum(astat(1:2)) /= 0) then
          close(8);goto 902
	endif
 	do i=1,nlat
	   read(8,*,end=903)(gra(i,j),j=1,nlon)
      enddo
903   close(8)
      open(unit=10,file=sfhhgrdfl,status="old",iostat=status)
      if(status/=0)goto 904
      read(10,'(a)') line
      call PickRecord(line,len,rec,sn)
      hd1(1:6)=rec(1:6)
      if(sum(hd1-hd)>1.d-5)then  !格网规格不同The grid specifications are different
         close(10);goto 904
      endif
 	do i=1,nlat
	   read(10,*,end=905)(sfh(i,j),j=1,nlon)
      enddo
905   close(10)
      open(unit=8,file=calcpntfl,status="old",iostat=status)
      if(status/=0)goto 904
      open(unit=10,file='reslt.txt',status="replace")
      read(8,'(a)') line  !读取头文件read the file header
      write(10,101)trim(line)
      kk=0
      do while(.not.eof(8))  
         read(8,'(a)') line
         call PickRecord(line,len,rec,sn)
         if(sn<4)goto 906
         kk=kk+1;BLH(2)=rec(2);BLH(1)=rec(3);BLH(3)=rec(4)!大地高the ellipsoidal height
         rst=PoissonBLH(BLH,gra,sfh,nlat,nlon,hd,dr,GRS)
         write(10,101)trim(line),rst !the same unit with the input field element
         if(kk/200*200==kk)write(*, '(a,i9)'), '    Calculated point number: ',kk
       enddo
906   close(8)
      close(10)
904   deallocate(gra,sfh)
902   continue
101   format(a,40F12.4)
      write (*,*)'  Complete the computation! The results are saved in the file reslt.txt.'
      end
