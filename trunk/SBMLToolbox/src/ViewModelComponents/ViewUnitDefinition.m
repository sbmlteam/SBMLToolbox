function varargout = ViewUnitDefinition(varargin)
% ViewUnitDefinition takes
%                        a MATLAB_SBML UnitDefinition structure
%                 and drives a GUI that illustrates the unitDefinition structure fields and values 
%
%       NOTE: at present there is no output from this function but it could
%       be edited to allow creation and editing of the unitDefinition

%  Filename    :   ViewUnitDefinition.m
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


% Edit the above text to modify the response to help ViewUnitDefinition

% Last Modified by GUIDE v2.5 29-Sep-2003 12:25:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ViewUnitDefinition_OpeningFcn, ...
                   'gui_OutputFcn',  @ViewUnitDefinition_OutputFcn, ...
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


% --- Executes just before ViewUnitDefinition is made visible.
function ViewUnitDefinition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ViewUnitDefinition (see VARARGIN)

% Choose default command line output for ViewUnitDefinition
handles.output = hObject;

% get the input argument and assign to the handle
UnitDefinition = varargin{1};
handles.UnitDefinition = UnitDefinition;

% determine sbml level
if (isSBML_UnitDefinition(UnitDefinition, 1))
    Level = 1;
elseif (isSBML_UnitDefinition(UnitDefinition, 2))
    Level = 2;
else
    error('Structure supplied is not a SBML UnitDefinition');
end;
handles.Level = Level;

% display items common to both levels
[x,NumUnits] = size(UnitDefinition.unit);
if (NumUnits == 0)
    set(handles.ListUnits, 'String', 'No units listed');
    set(handles.ListUnits, 'Enable', 'off');
    set(handles.ViewUnit, 'Enable', 'off');
    handles.UnitIndex = 1;
else
    for i = 1:NumUnits
        UnitList{i} = UnitDefinition.unit(i).kind;
    end;
    set(handles.ListUnits, 'String', UnitList);
    handles.UnitIndex = 1;
end;

% dislay items for each level only
% hide display otherwise if not included within a level
if (Level == 1)
    set(handles.Name, 'String', UnitDefinition.name);
    set(handles.OptName, 'Visible', 'off');
    set(handles.OptionalName, 'Visible', 'off');
else
    set(handles.Name, 'String', UnitDefinition.id);
    % determine whether the optional name field has a value
    if (isempty(UnitDefinition.name))
        set(handles.OptName, 'Visible', 'off');
        set(handles.OptionalName, 'Visible', 'off');
    else
        set(handles.OptionalName, 'String', UnitDefinition.name);
    end;
end;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ViewUnitDefinition wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ViewUnitDefinition_OutputFcn(hObject, eventdata, handles)
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


% --- Executes on selection change in ListUnits.
function ListUnits_Callback(hObject, eventdata, handles)
% hObject    handle to ListUnits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get the index of the parameter selected
handles.UnitIndex = get(handles.ListUnits, 'Value');
guidata(hObject, handles);


% --- Executes on button press in ViewUnit.
function ViewUnit_Callback(hObject, eventdata, handles)
% hObject    handle to ViewUnit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ViewUnit(handles.UnitDefinition.unit(handles.UnitIndex));

% ---------------------------------------------------------------------

% CREATION FUNCTIONS

% ---------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function ListUnits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListUnits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



