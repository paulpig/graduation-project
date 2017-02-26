function v=minusBk(A,B)  
    F = 255;  
    ret = A;  
    [m,n] = size(A);  
    for i=1 : m  
        for j=1 : n  
            k = setK(B(i,j));  
            if B(i,j) > A(i,j)  
                ret(i,j) = F - k*(B(i,j)-A(i,j));  
                if ret(i,j) < 0.75*F  
                    ret(i,j) = 0.75*F;  
                end  
            else  
                ret(i,j) = F;  
            end  
        end  
    end  
    v=ret;  
end  