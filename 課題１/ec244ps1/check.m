% Script to use with logit.m to check the inputs and specifications of the model
% Written by Kenneth Train, Dec 11, 2007

function ok=check

global NCS NROWS XMAT
global IDV NAMES B PREDICT

ok=0;

disp('Checking the data and specifications.');
disp('');

if ceil(NCS) ~= NCS | NCS < 1;
   disp(['NCS must be a positive integer, but it is set to ' num2str(NCS)]);
   disp('Program terminated.');
   return
end

if ceil(NROWS) ~= NROWS | NROWS < 1;
   disp(['NROWS must be a positive integer, but it is set to ' num2str(NROWS)]);
   disp('Program terminated.');
   return
end

if sum(sum(ceil(IDV) ~= IDV | IDV < 1),1) ~ 0;
   disp('IDV must contain positive integers only, but it contains other values.');
   disp('Program terminated.');
   return
end

if ( size(XMAT,1) ~= NROWS)
      disp(['XMAT has ' num2str(size(XMAT,1)) ' rows']);
      disp(['but it should have NROWS= '  num2str(NROWS)   ' rows.']);
      disp('Program terminated.');
      return
end

if sum(XMAT(:,1) > NCS) ~= 0
     disp(['The first column of XMAT has a value greater than NCS= ' num2str(NCS)]);
     disp('Program terminated.');
     return
end

if sum(XMAT(:,1) < 1) ~= 0
     disp('The first column of XMAT has a value less than 1.');
     disp('Program terminated.');
     return
end

k=(XMAT(2:NROWS,1) ~= XMAT(1:NROWS-1,1)) & (XMAT(2:NROWS,1) ~= (XMAT(1:NROWS-1,1)+1));
if sum(k) ~= 0
    disp('The first column of XMAT does not ascend from 1 to NCS.');
    disp('Program terminated.')
    return
end

if sum(XMAT(:,3) ~= 0 & XMAT(:,3) ~= 1) ~= 0
     disp('The third column of XMAT has a value other than 1 or 0.');
     disp('Program terminated.');
     return
end

for s=1:NCS
    k=(XMAT(:,1) == s);
    if sum(XMAT(k,3)) > 1
       disp('The third column of XMAT indicates more than one chosen alternative');
       disp(['for choice situation ' num2str(s)]);
       disp('Program terminated.');
       return
    end
    if sum(XMAT(k,3)) < 1
       disp('The third column of XMAT indicates that no alternative was chosen');
       disp(['for choice situation ' num2str(s)]);
       disp('Program terminated.');
       return
    end 
end

if sum(sum(isnan(XMAT)),2) ~= 0
   disp('XMAT contains missing data.');
   disp('Program terminated.');
   return
end;

if sum(sum(isinf(XMAT)),2) ~= 0
   disp('XMAT contains an infinite value.');
   disp('Program terminated.');
   return
end;

if sum(sum(isinf(XMAT)),2) ~= 0
   disp('XMAT contains an infinite value.');
   disp('Program terminated.');
   return
end;

if size(IDV,1) ~= 1;
   disp(['IDV must have 1 row and yet it is set to have ' num2str(size(IDV,1))]);
   disp('Program terminated.');
   return
end;

if sum(IDV > size(XMAT,2)) ~= 0;
   disp('IDV identifies a variable that is outside XMAT.');
   disp('IDV is');
   IDV
   disp('when each element must be no greater than')
   disp([num2str(size(XMAT,2)) ' which is the number of columns in XMAT.']);
   disp('Program terminated.');
   return
end;

if sum(IDV <= 3) ~= 0;
   disp('Each element in IDV must exceed 3');
   disp('since the first three variables in XMAT cannot be explanatory variables.');
   disp('But IDV is');
   IDV(:,1)
   disp('which has an element below 3.')
   disp('Program terminated.');
   return
end;


if size(NAMES,1) ~= 1;
   disp(['NAMES must have 1 row and yet it is set to have ' num2str(size(NAMES,1))]);
   disp('Program terminated.');
   return
end;

if size(IDV,2) ~= size(NAMES,2);
   disp(['IDV and NAMES must have the same length but IDV has length ' num2str(size(IDV,2))]);
   disp(['while NAMES has length ' num2str(size(NAMES,2))]);
   disp('Program terminated.');
   return
end; 

if size(B,1) ~= 1;
   disp(['B must have 1 row and yet it is set to have ' num2str(size(B,1))]);
   disp('Program terminated.');
   return
end;
  
if size(B,2) ~= size(IDV,2);
   disp(['B must have the same length as IDV but instead has length ' num2str(size(B,2))]);
   disp('Program terminated.');
   return
end; 

if (PREDICT ~= 0) & (PREDICT ~= 1) & (PREDICT ~= 2);
   disp(['PREDICT must be 0, 1, or 2, but it is set to ' num2str(PREDICT)]);
   disp('Program terminated.');
   return
end
if (PREDICT >0) & sum(ceil(XMAT(:,2)) ~= XMAT(:,2),1) > 0;
   disp('The second colum of XMAT must contain positive integers only, in order to do predictions.')
   disp('but it contains other values.');
   disp('Program terminated.');
   return
end


ok=1;

