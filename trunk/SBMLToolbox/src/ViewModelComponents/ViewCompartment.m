function varargout = ViewCompartment(varargin)
% ViewCompartment takes
%                        a MATLAB_SBML Compartment structure
%                 and drives a GUI that illustrates the compartment structure fields and values 
%
%       NOTE: at present there is no output from this function but it could
%       be edited to allow creation and editing of the compartment

%  Filename    :   ViewCompartment.m
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


% Edit the above text to modify the response to help ViewCompartment

% Last Modified by GUIDE v2.5 30-Sep-2003 14:39:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ViewCompartment_OpeningFcn, ...
                   'gui_OutputFcn',  @ViewCompartment_OutputFcn, ...
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


% --- Executes just before ViewCompartment is made visible.
function ViewCompartment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ViewCompartment (see VARARGIN)

% Choose default command line output for ViewCompartment
handles.output = hObject;

% get the input argument and assign to the handle
Compartment = varargin{1};
handles.Compartment = Compartment;

% determine sbml level
if (isSBML_Compartment(Compartment, 1))
    Level = 1;
elseif (isSBML_Compartment(Compartment, 2))
    Level = 2;
else
    error('Structure supplied is not a SBML Compartment');
end;
handles.Level = Level;

% display items common to both levels
set(handles.Units, 'String', Compartment.units);
set(handles.Outside, 'String', Compartment.outside);

% dislay items for each level only
% hide display otherwise if not included within a level
if (Level == 1)
    set(handles.Name, 'String', Compartment.name);
    if (Compartment.isSetVolume == 1)
        Volume = double(Compartment.volume);
        set(handles.Volume, 'String', num2str(Volume));
    else
        set(handles.Volume, 'String', 'Not set');
    end;
    set(handles.OptName, 'Visible', 'off');
    set(handles.OptionalName, 'Visible', 'off');
    set(handles.Spatial_text, 'Visible', 'off');
    set(handles.ListSpatialDims, 'Visible', 'off');
    set(handles.ConstantCheck, 'Visible', 'off');
else
    set(handles.Name, 'String', Compartment.id);
    % determine whether the optional name field has a value
    if (isempty(Compartment.name))
        set(handles.OptName, 'Visible', 'off');
        set(handles.OptionalName, 'Visible', 'off');
    else
        set(handles.OptionalName, 'String', Compartment.name);
    end;
    set(handles.VolumeText, 'String', 'Size');
    if (Compartment.isSetSize == 1)
        Size = double(Compartment.size);
        set(handles.Volume, 'String', num2str(Size));
    else
        set(handles.Volume, 'String', 'Not set');
    end;
    ListSpatialDims = {'0', '1', '2', '3'};
    set(handles.ListSpatialDims, 'String', ListSpatialDims);
    handles.SpatialIndex = double(Compartment.spatialDimensions) + 1;
    set(handles.ListSpatialDims, 'Value', handles.SpatialIndex);
    set(handles.ConstantCheck, 'Value', Compartment.constant);
end;
    
% disable all editable boxes at present
set(handles.Volume, 'Enable', 'off');
set(handles.Outside, 'Enable', 'off');
set(handles.Units, 'Enable', 'off');
set(handles.ListSpatialDims, 'Enable', 'off');
set(handles.ConstantCheck, 'Enable', 'off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ViewCompartment wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ViewCompartment_OutputFcn(hObject, eventdata, handles)
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

% ----------------------------------------------------------------

% CALLBACK FUNCTIONS FOR FUTURE EXPANSION

% ---------------------------------------------------------------

function Volume_Callback(hObject, eventdata, handles)
% hObject    handle to Volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function Units_Callback(hObject, eventdata, handles)
% hObject    handle to Units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function Outside_Callback(hObject, eventdata, handles)
% hObject    handle to Outside (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function ConstantCheck_Callback(hObject, eventdata, handles)
% hObject    handle to ConstantCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function ListSpatialDims_Callback(hObject, eventdata, handles)
% hObject    handle to ListSpatialDims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% ---------------------------------------------------------------------

% CREATION FUNCTIONS

% ---------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function Volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

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

function Outside_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Outside (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function ListSpatialDims_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListSpatialDims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



