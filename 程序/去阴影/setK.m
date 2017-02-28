function v=setK(e)  
if e < 20  
    k = 2.5;  
elseif e>=20 && e<=100  
    k = 1 + ((2.5-1)*(100-e))/80;  
elseif e>100 && e<200  
    k = 1;  
else  
    k = 1 + (e-220)/35;  
end  
v = k;  
end  