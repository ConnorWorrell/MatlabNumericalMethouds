function [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter,test)
%falsePosition 
%Uses false position methoud to find the root of a function
%Dosent work if the function dosen't cross the x axis
%
%Inputs:
%  func - the function being evaluated
%  xl - the lower guess
%  xu - the upper guess
%  es - the desired relative error (defaults to 0.0001%)
%  maxiter - the number of iterations desired (defaults to 200)(if 0 no
%  max)
%  test - true for testing mode (displays graph, shows calculations)
%
%Outputs:
%  root - the estimated root location
%  fx - the function evaluated at the estimated root
%  ea - the approximate relative error (%)
%  iter - how many iterations were performed

if(nargin < 3 || nargin > 6)%test to see if number of arguments is acceptable
    error('There must be between 3 and 5 arguments');
elseif(nargin == 3)%user enters no error or iteration
    es = .0001;%default error
    maxiter = 200;%default iteration
    test = false;%default testing state
elseif(nargin == 4)%user enters error
    maxiter = 200;%default iteration
    test = false;%default testing state
elseif(nargin == 5)%user enters error and iteration
    test = false;%default testing state
end%if user enters error, iteration, and testing state nothing needs to be changed from imputs

if(func(xl)*func(xu)>0)
    error('no change in sign between upper and lower bound');
end

es=es/100;%change input error from percent to decimal
iter = 0;%set initial iteration count to 0
PrevGuess = xu;
Error = 100000;%set error higher than it could be

if(test)%testing features
    figure;%make figure
    p=linspace(xl,xu);%plot graph
    plot(p,func(p));
    hold on%make figures stay open
    syms x;%prepair x for graphs in while loop
end

if(maxiter == 0 && es == 0)%check to see if infinite loop is probable
    error('Infinite loop');
end

while((iter < maxiter || maxiter == 0) && Error > es)
    y1=double(func(xl));%calculate variables for line
    m=double((func(xu)-y1)/(xu-xl));
    
    Guess=-y1/m+xl;%calculate where line itersects zero
    Error = abs((Guess-PrevGuess)/Guess);%calculate error
    PrevGuess=Guess;%record previous guess value for use in error calculation
    
    if(func(xl)*func(Guess)<0)%if sign change between lower and guess
        xu=Guess;
    elseif(func(Guess)*func(xu)<0)%if sign change between upper and guess
        xl=Guess;
    else
        error('No root found');%no sign change means  no  root found
    end
    
    iter = iter + 1;%record iteration
    
    if(test)%testing feature
        fprintf("%.0f %f Guess:%f Value:%f\n",iter,Error,Guess,double(func(Guess)));%display iteration, error, x, f(x)
        line = symfun(m*(x-xl)+y1,x);%plot line that was found
        plot(p,line(p));
    end
    
end

root = Guess;%almost root
fx=double(func(Guess));%calculate y at almost 0 x
ea=Error*100;%change error to percent

if(test)%turn hold off for figures outside of the function
    hold off 
end

end

