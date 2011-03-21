function varargout = ViewUnit(varargin)
% ViewUnit takes
%                        a MATLAB_SBML Unit structure
%                 and drives a GUI that illustrates the unit structure fields and values 
%
%       NOTE: at present there is no output from this function but it could
%       be edited to allow creation and editing of the unit

%  Filename    :   ViewUnit.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
%
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
%
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->


% Edit the above text to modify the response to help ViewUnit

% Last Modified by GUIDE v2.5 30-Sep-2003 14:22:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ViewUnit_OpeningFcn, ...
                   'gui_OutputFcn',  @ViewUnit_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ViewUnit is made visible.
function ViewUnit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ViewUnit (see VARARGIN)

% Choose default command line output for ViewUnit
handles.output = hObject;

% get the input argument and assign to the handle
Unit = varargin{1};
handles.Unit = Unit;

% determine sbml level
if (isSBML_Unit(Unit, 1))
    Level = 1;
elseif (isSBML_Unit(Unit, 2))
    Level = 2;
else
    error('Structure supplied is not a SBML Unit');
end;
handles.Level = Level;

% display items common to both levels
set(handles.UnitKind, 'String', Unit.kind);
set(handles.Exponent, 'String', Unit.exponent);
set(handles.Scale, 'String', Unit.scale);

% dislay items for level 2 only
% hide display otherwise
if (Level == 2)
    set(handles.Multiplier, 'String', Unit.multiplier);
    set(handles.Offset, 'String', Unit.offset);
else
    set(handles.Multiplier, 'Visible', 'off');
    set(handles.Offset, 'Visible', 'off');
    set(handles.Multiplier_text, 'Visible', 'off');
    set(handles.Offset_text, 'Visible', 'off');
end; 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ViewUnit wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ViewUnit_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% NO OUTPUT FROM THIS FUNCTION

% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% close the gui

if isequal(get(handles.figure1, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, use UIRESUME
    uiresume(handles.figure1);
    delete(handles.figure1);
else
    % The GUI is no longer waiting, just close it
    delete(handles.figure1);
end


