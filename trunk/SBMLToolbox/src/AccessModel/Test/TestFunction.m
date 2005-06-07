function y = TestFunction(varargin)
y = 0;
if (nargin < 3)
    error('Cannot compare output if none supplied');
end;

func = varargin{1};
fhandle = str2func(func);

model = varargin{2};

number = varargin{3};
fail = 0;
switch number
    case 0
        [a] = feval(fhandle, model);
        fail = fail + ~isempty(a);
    case 1
        [a] = feval(fhandle, model);
        fail = fail + ~isequal(a, varargin{4});
    case 2
        [a, b] = feval(fhandle, model);
        fail = fail + ~isequal(a, varargin{4});
        fail = fail + ~isequal(b, varargin{5});
    case 3
        [a, b, c] = feval(fhandle, model);
        fail = fail + ~isequal(a, varargin{4});
        fail = fail + ~isequal(b, varargin{5});
        fail = fail + ~isequal(c, varargin{6});
    otherwise
        error('too many output');
end;
 
if (fail > 0)
    y = 1;
end;



