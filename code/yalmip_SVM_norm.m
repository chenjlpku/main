function [aopt,bopt] = yalmip_SVM_norm(M1,catag,gamma)
    % 这里M1行是基因，列是样本
    M1=M1';
    n=size(M1,1);
    m=size(M1,2);
    
    sdpvar b;
    a = sdpvar(n,1,'full');
    u = sdpvar(m,1,'full');

    objective_function = 1/2*(a'*a) + gamma*(sum(u));

    constraints = [u>=0;
%                    sum(abs(a))^2<=theta;
               catag'.*(a'*M1 - b) >= 1 - u'];
               
    optimize(constraints,objective_function);

    aopt = value(a);
    bopt = value(b); 
end