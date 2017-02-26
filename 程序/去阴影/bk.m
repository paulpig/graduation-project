function v=bk(x)  
    N = size(x);                      
    b = sort(x);  
    nMax = b((N(1)-47) : (N(1)-1),:);  
    v = mean(nMax);  
end  