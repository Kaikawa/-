XMAT=load('datawide.asc');   %Read in the ascii file as a matrix called XMAT, which has 900 rows and 19 columns
disp('Check that size is 900 x 19'); 
size(XMAT)

idcase=XMAT(:,1);
idcase=repmat(idcase,1,5);
idcase=reshape(idcase',900*5,1); %Take transpose of idcase because reshape reads down columns

idalt=[1 2 3 4 5];
idalt=repmat(idalt,900,1);
idalt=reshape(idalt',900*5,1); 

depvar=XMAT(:,2);
newdep=zeros(900,5);
for n=1:900
   c=depvar(n,1);
   newdep(n,c)=1;
end
newdep=reshape(newdep',900*5,1);

ic=reshape(XMAT(:,3:7)',900*5,1);
oc=reshape(XMAT(:,8:12)',900*5,1);

YMAT=[idcase idalt newdep ic oc];

for n=13:19
   demog=repmat(XMAT(:,n),1,5);
   demog=reshape(demog',900*5,1);
   YMAT=[YMAT demog];
end

disp('Check that YMAT has 4500 rows and 12 columns');
size(YMAT)

dlmwrite('datalong.asc', YMAT,'delimiter',' ','newline','pc'); 

