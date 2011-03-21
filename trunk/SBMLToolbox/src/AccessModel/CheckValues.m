function varargout = CheckValues(varargin)
% CheckValues 
%         takes an SBMLModel
%         
%   displays a GUI that allows the user to view and/or edit the values
%         for the initial concentration/amount of species and parameter values
% 
%     and returns
%         1) an array of values for the initial concentration/amount of the species
%         2) an array of values for the parameters

%
%  Filename    : CheckValues.m
%  Description : takes a SBMLModel and returns an array of values for the species
%                   and an array of the values of each parameter
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-02-02
%  Revision    : $Id$
%  Source      : $Source $
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
%
%
% CHECKVALUES M-file for CheckValues.fig
%      CHECKVALUES, by itself, creates a new CHECKVALUES or raises the existing
%      singleton*.
%
%      H = CHECKVALUES returns the handle to a new CHECKVALUES or the handle to
%      the existing singleton*.
%
%      CHECKVALUES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHECKVALUES.M with the given input arguments.
%
%      CHECKVALUES('Property','Value',...) creates a new CHECKVALUES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CheckValues_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CheckValues_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CheckValues_OpeningFcn, ...
                   'gui_OutputFcn',  @CheckValues_OutputFcn, ...
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


% --- Executes just before CheckValues is made visible.
function CheckValues_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CheckValues (see VARARGIN)

% retrieve input arguments

SBMLModel = varargin{1};

[Species, SpeciesValues] = GetSpecies(SBMLModel);


[Parameter, ParameterValues] = GetAllParametersUnique(SBMLModel);

% keep a copy of initial values
handles.InitialSpeciesValues = SpeciesValues;
handles.InitialParameterValues = ParameterValues;

handles.SpeciesValues = SpeciesValues;
handles.ParameterValues = ParameterValues;

handles.Species = Species;
handles.Parameter = Parameter;

% populate listboxes
NumSpecies = length(SpeciesValues);
for i = 1:NumSpecies
    ListSp(i) = Species(i);
end;

NumParams = length(ParameterValues);
for i = 1:NumParams
    ListParam(i) = Parameter(i);
end;

set(handles.ListSpecies, 'String', ListSp);
set(handles.ListParameter, 'String', ListParam);
handles.SpeciesIndex = 1;
handles.ParameterIndex = 1;

set(handles.EditSpeciesAmount, 'String', num2str(handles.SpeciesValues(handles.SpeciesIndex)));
set(handles.EditParameterValue, 'String', num2str(handles.ParameterValues(handles.ParameterIndex)));

handles.ParamArray = WriteNegativeParameterConfimationArray(handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CheckValues wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CheckValues_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get output from handles structure
varargout{1} = handles.SpeciesValues;
varargout{2} = handles.ParameterValues;

close(handles.figure1);




% --- Executes on selection change in ListSpecies.
function ListSpecies_Callback(hObject, eventdata, handles)
% hObject    handle to ListSpecies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.SpeciesIndex = get(handles.ListSpecies, 'Value');
set(handles.EditSpeciesAmount, 'String', num2str(handles.SpeciesValues(handles.SpeciesIndex)));
% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in ListParameter.
function ListParameter_Callback(hObject, eventdata, handles)
% hObject    handle to ListParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.ParameterIndex = get(handles.ListParameter, 'Value');
set(handles.EditParameterValue, 'String', num2str(handles.ParameterValues(handles.ParameterIndex)));
% Update handles structure
guidata(hObject, handles);


function EditSpeciesAmount_Callback(hObject, eventdata, handles)
% hObject    handle to EditSpeciesAmount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.SpeciesValues(handles.SpeciesIndex) = str2double(get(handles.EditSpeciesAmount, 'String'));
% Update handles structure
guidata(hObject, handles);

function EditParameterValue_Callback(hObject, eventdata, handles)
% hObject    handle to EditParameterValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.ParameterValues(handles.ParameterIndex) = str2double(get(handles.EditParameterValue, 'String'));

if (handles.ParameterValues(handles.ParameterIndex) < 0)
    handles.ParamArray(handles.ParameterIndex) = 0;
else
    handles.ParamArray(handles.ParameterIndex) = 1;
end;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in ButtonOK.
function ButtonOK_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

SpeciesOK = CheckSpeciesValues(handles);
ParametersOK = CheckParameterValues(hObject, handles);

if (SpeciesOK == 0 && ParametersOK == 0)
    
if isequal(get(handles.figure1, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.figure1);
else
    % The GUI is no longer waiting, just close it
    delete(handles.figure1);
end

end;
% --- Executes on button press in ButtonCancel.
function ButtonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% cancel any changes
handles.SpeciesValues = handles.InitialSpeciesValues;
handles.ParameterValues = handles.InitialParameterValues;

% Update handles structure
guidata(hObject, handles);

if isequal(get(handles.figure1, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.figure1);
else
    % The GUI is no longer waiting, just close it
    delete(handles.figure1);
end



%----------------------------------------------------------------------
%
%       CREATION FUNCTIONS
%
%
% --- Executes during object creation, after setting all properties.
function ListSpecies_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListSpecies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes during object creation, after setting all properties.
function EditParameterValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditParameterValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes during object creation, after setting all properties.
function ListParameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes during object creation, after setting all properties.
function EditSpeciesAmount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditSpeciesAmount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% END OF CREATION FUNCTIONS
%----------------------------------------------------------------------
function y = CheckSpeciesValues(handles)

y = 0;
% check that concentrations have been set
if (ismember(-1, handles.SpeciesValues))
    msgbox('Not all species values have been set','', 'error');
    y = 1;
    return;
end;

% check for negative concentration values
NegSpecies = 0;
i = 1;
while (i < length(handles.Species))
    if (handles.SpeciesValues(i) < 0)
        NegSpecies = i;
        NegMessage = sprintf('Species %s has negative concentration', handles.Species{i});
        break;
    end;
    i = i+1;
end;

if (NegSpecies ~= 0)
    msgbox(NegMessage,'', 'error');
    y = 1;
    return;
end;

% check that all concentrations are not 0
if (handles.SpeciesValues == 0)
    msgbox('Cannot have all species values set to zero','', 'error');
    y = 1;
    return;
end;

%----------------------------------------------------------------------

function y = CheckParameterValues(hObject, handles)

y = 0;

NoParams = length(handles.Parameter);

% find each unconfirmed value and prompt user for confirmation
for i = 1:NoParams
    if (handles.ParamArray(i) == 0)
        Message = sprintf('Value for parameter %s is %d. Is this correct?', handles.Parameter{i}, handles.ParameterValues(i));
        
        answer = questdlg(Message);
        
        if strcmp(answer, 'Yes')
            handles.ParamArray(i) = 1;
        end;
    end;
end;
   
% save the confirmed 
% Update handles structure
guidata(hObject, handles);

if (sum(handles.ParamArray) ~= NoParams)
    y = 1;
end;

function array = WriteNegativeParameterConfimationArray(handles)
NoParams = length(handles.Parameter);
% get an array showing whether values are negative
for i = 1:NoParams
    if (handles.ParameterValues(i) <= 0)
        array(i) = 0;
    else
        array(i) = 1;
    end;
end;

