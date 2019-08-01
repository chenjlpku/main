function y=NewgeneMat(w,geneMat)
   ind=find(w~=0);
   y=geneMat(:,ind);
end