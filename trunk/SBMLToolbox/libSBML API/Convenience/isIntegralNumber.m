function value = isIntegralNumber(number)
%
%   isIntegralNumber 
%             takes a number n
%             and returns 1 if it is an integer 0 otherwise
%
%       NOTE: MATLAB's isinteger is only true if the number has been
%       declared as an int; whereas the default type for numbers in MATLAB
%       is double
%
%       value = isIntegralNumber(number)

value = 0;

if (isinteger(number))
    value = 1;
elseif (isnumeric(number))
    % if it is an integer 
    if (number == fix(number))
        value = 1;
    end;
end;


