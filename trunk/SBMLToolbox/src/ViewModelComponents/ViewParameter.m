function varargout = ViewParameter(varargin)
% ViewParameter takes
%                        a MATLAB_SBMLParameter structure
%                 and drives a GUI that illustrates the parameter structure fields and values 
%
%       NOTE: at present there is no output from this function but it could
%       be edited to allow creation and editing of the parameter

% VIEWPARAMETER M-file for ViewParameter.fig
%
%  Filename    : ViewParameter.m
%  Description : drives GUI that browses a sbml-matlab parameter
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2003-10-01
%  Revision    : $Id$
%  Source      : $Source$
%
%  Copyright 2003 California Institute of Technology, the Japan Science
%  and Technology Corporation, and the University of Hertfordshire
%
%  This library is free software; you can redistribute it and/or modify it
%  under the terms of the GNU Lesser General Public License as published
%  by the Free Software Foundation; either version 2.1 of the License, or
%  any later version.
%
%  This library is distributed in the hope that it will be useful, but
%  WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
%  MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
%  documentation provided hereunder is on an "as is" basis, and the
%  California Institute of Technology, the Japan Science and Technology
%  Corporation, and the University of Hertfordshire have no obligations to
%  provide maintenance, support, updates, enhancements or modifications.  In
%  no event shall the California Institute of Technology, the Japan Science
%  and Technology Corporation or the University of Hertfordshire be liable
%  to any party for direct, indirect, special, incidental or consequential
%  damages, including lost profits, arising out of the use of this software
%  and its documentation, even if the California Institute of Technology
%  and/or Japan Science and Technology Corporation and/or University of
%  Hertfordshire have been advised of the possibility of such damage.  See
%  the GNU Lesser General Public License for more details.
%
%  You should have received a copy of the GNU Lesser General Public License
%  along with this library; if not, write to the Free Software Foundation,
%  Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%
%  The original code contained here was initially developed by:
%
%      Sarah Keating
%      Science and Technology Research Centre
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):
%
%      VIEWPARAMETER, by itself, creates a new VIEWPARAMETER or raises the existing
%      singleton*.
%
%      H = VIEWPARAMETER returns the handle to a new VIEWPARAMETER or the handle to
%      the existing singleton*.
%
%      VIEWPARAMETER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIEWPARAMETER.M with the given input arguments.
%
%      VIEWPARAMETER('Property','Value',...) creates a new VIEWPARAMETER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ViewParameter_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ViewParameter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ViewParameter

% Last Modified by GUIDE v2.5 30-Sep-2003 15:09:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ViewParameter_OpeningFcn, ...
                   'gui_OutputFcn',  @ViewParameter_OutputFcn, ...
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


% --- Executes just before ViewParameter is made visible.
function ViewParameter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ViewParameter (see VARARGIN)

% Choose default command line output for ViewParameter
handles.output = hObject;

% get the input argument and assign to the handle
Parameter = varargin{1};
handles.Parameter = Parameter;

% determine sbml level
if (isSBML_Parameter(Parameter, 1))
    Level = 1;
elseif (isSBML_Parameter(Parameter, 2))
    Level = 2;
else
    error('Structure supplied is not a SBML Parameter');
end;

% display items common to both levels
if (Parameter.isSetValue == 1)
    Value = double(Parameter.value);
    set(handles.InitialValue, 'String', num2str(Value));
else
    set(handles.InitialValue, 'String', 'Not set');
end;
set(handles.Units, 'String', Parameter.units);

% dislay items for each level only
% hide display otherwise if not included within a level
if (Level == 1)
    set(handles.Name, 'String', Parameter.name);
    set(handles.OptName, 'Visible', 'off');
    set(handles.OptionalName, 'Visible', 'off');
    set(handles.ConstantCheck, 'Visible', 'off');
else
    set(handles.Name, 'String', Parameter.id);
    % determine whether the optional name field has a value
    if (isempty(Parameter.name))
        set(handles.OptName, 'Visible', 'off');
        set(handles.OptionalName, 'Visible', 'off');
    else
        set(handles.OptionalName, 'String', Parameter.name);
    end;
    set(handles.ConstantCheck, 'Value', Parameter.constant);
end;


% disable all editable boxes at present
set(handles.InitialValue, 'Enable', 'off');
set(handles.Units, 'Enable', 'off');
set(handles.ConstantCheck, 'Enable', 'off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ViewParameter wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ViewParameter_OutputFcn(hObject, eventdata, handles)
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
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.figure1);
    delete(handles.figure1);
else
    % The GUI is no longer waiting, just close it
    delete(handles.figure1);
end

% ----------------------------------------------------------------

% CALLBACK FUNCTIONS FOR FUTURE EXPANSION

% ---------------------------------------------------------------

function Units_Callback(hObject, eventdata, handles)
% hObject    handle to Units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function InitialValue_Callback(hObject, eventdata, handles)
% hObject    handle to InitialValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function ConstantCheck_Callback(hObject, eventdata, handles)
% hObject    handle to ConstantCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% ---------------------------------------------------------------------

% CREATION FUNCTIONS

% ---------------------------------------------------------------------

% --- Executes during object creation, after setting all properties.

function Units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function InitialValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InitialValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
