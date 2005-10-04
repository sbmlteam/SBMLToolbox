function y = TestFunction(varargin)
y = 0;
if (nargin < 3)
    error('Need at least 3 inputs');
end;

func = varargin{1};
fhandle = str2func(func);

number_in = varargin{2};
number_out = varargin{3};

if (nargin < 3+number_in+number_out)
    error('incorrect number of arguments');
end;

start_out = 4 + number_in;

fail = 0;
switch number_out
    case 0
        switch number_in
            case 1
                [a] = feval(fhandle, varargin{4});
            case 2
                [a] = feval(fhandle, varargin{4}, varargin{5});
        end;
        fail = fail + ~isempty(a);
    case 1
        switch number_in
            case 1
                [a] = feval(fhandle, varargin{4});
            case 2
                [a] = feval(fhandle, varargin{4}, varargin{5});
        end;
        fail = fail + ~isequal(a, varargin{start_out});
    case 2
        switch number_in
            case 1
                [a, b] = feval(fhandle, varargin{4});
            case 2
                [a, b] = feval(fhandle, varargin{4}, varargin{5});
        end;
        fail = fail + ~isequal(a, varargin{start_out});
        fail = fail + ~isequal(b, varargin{start_out+1});
    case 3
        switch number_in
            case 1
                [a, b, c] = feval(fhandle, varargin{4});
            case 2
                [a, b, c] = feval(fhandle, varargin{4}, varargin{5});
        end;
        fail = fail + ~isequal(a, varargin{start_out});
        fail = fail + ~isequal(b, varargin{start_out+1});
        fail = fail + ~isequal(c, varargin{start_out+2});
    otherwise
        error('too many output');
end;
 
if (fail > 0)
    y = 1;
end;



