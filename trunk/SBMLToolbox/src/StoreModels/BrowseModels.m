function varargout = BrowseModels(varargin)
% varargout = BrowseModels(number) raises a GUI that browses the data file
% SBML_Models.dat
%
% number is the the number of output arguments
%   number = 0 - no output expected (ie no model to be loaded)
%   number = 1 - output expected (ie return model)
%
% This GUI should be called using BrowseSBML_Models.m

%  Filename    :   BrowseModels.m
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


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BrowseModels_OpeningFcn, ...
                   'gui_OutputFcn',  @BrowseModels_OutputFcn, ...
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

% --- Executes just before BrowseModels is made visible.
function BrowseModels_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BrowseModels (see VARARGIN)

% Choose default command line output for BrowseModels
handles.output = hObject;
handles.nargout = varargin{1};
handles.Model_l1_Index = 1;
handles.Model_l2_Index = 1;
handles.Model_l2v2_Index = 1;
handles.Model_l2v3_Index = 1;

% read in the file
load 'SBML_Models';
if (~exist('Models_l1'))
   n_level1 = 0;
   handles.Models_l1 = 0;
else
   [m, n_level1] = size(Models_l1);
   handles.Models_l1 = Models_l1;
end;

if (~exist('Models_l2'))
   n_level2 = 0;
   handles.Models_l2 = 0;
else
   [m, n_level2] = size(Models_l2);
   handles.Models_l2 = Models_l2;
end;

if (~exist('Models_l2v2'))
   n_level2v2 = 0;
   handles.Models_l2v2 = 0;
else
   [m, n_level2v2] = size(Models_l2v2);
   handles.Models_l2v2 = Models_l2v2;
end;

if (~exist('Models_l2v3'))
   n_level2v3 = 0;
   handles.Models_l2v3 = 0;
else
   [m, n_level2v3] = size(Models_l2v3);
   handles.Models_l2v3 = Models_l2v3;
end;

% save in data 
handles.n_level1 = n_level1;
handles.n_level2 = n_level2;
handles.n_level2v2 = n_level2v2;
handles.n_level2v3 = n_level2v3;

handles.Level = 2;
handles.Version = 3;

for nNumber = 1:n_level1
    ListNames_l1{nNumber} = Models_l1(nNumber).name;
end;
if (n_level1 == 0)
    ListNames_l1 = 'None saved';
end;
for nNumber = 1:n_level2
    Name = Models_l2(nNumber).id;
    k = isempty(Name);
    if (k == 1)
        Name = Models_l2(nNumber).name;
    end;
    ListNames_l2{nNumber} = Name;
end;
if (n_level2 == 0)
    ListNames_l2 = 'None saved';
end;
for nNumber = 1:n_level2v2
    Name = Models_l2v2(nNumber).id;
    ListNames_l2v2{nNumber} = Name;
end;
if (n_level2v2 == 0)
    ListNames_l2v2 = 'None saved';
end;
for nNumber = 1:n_level2v3
    Name = Models_l2v3(nNumber).id;
    ListNames_l2v3{nNumber} = Name;
end;
if (n_level2v3 == 0)
    ListNames_l2v3 = 'None saved';
end;


ListLevels{1} = '1';
ListLevels{2} = '2';

ListVersions{1} = '1';
ListVersions{2} = '2';

ListL2Versions{1} = '1';
ListL2Versions{2} = '2';
ListL2Versions{3} = '3';

set(handles.ListModels, 'String', ListNames_l2v3);
if (exist('Models_l2v3') == 0) 
    set(handles.SelModel, 'String', 'None');
else
    set(handles.SelModel, 'String', Models_l2v3(handles.Model_l2v3_Index).id);
end;
set(handles.LevelListbox, 'String', ListLevels);
set(handles.LevelListbox, 'Value', handles.Level);
set(handles.popupversion, 'String', ListL2Versions);
set(handles.popupversion, 'Value', handles.Version);


handles.ListNames_l1 = ListNames_l1;
handles.ListNames_l2 = ListNames_l2;
handles.ListNames_l2v2 = ListNames_l2v2;
handles.ListNames_l2v3 = ListNames_l2v3;
handles.ListVersions = ListVersions;
handles.ListL2Versions = ListL2Versions;

% Update handles structure
guidata(hObject, handles);

set(handles.ViewModel, 'Enable', 'off');

% UIWAIT makes BrowseModels wait for user response (see UIRESUME)
if (handles.nargout > 0)
    set(handles.Close, 'Enable', 'off');
else
    set(handles.LoadModel, 'Enable', 'off');
end;
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = BrowseModels_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
    close(handles.figure1);


% --- Executes on button press in ViewModel.
function ViewModel_Callback(hObject, eventdata, handles)
% hObject    handle to ViewModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (handles.Level == 1)
    ViewModel(handles.Models_l1(handles.Model_l1_Index));
else
    if (handles.Version == 1)
        ViewModel(handles.Models_l2(handles.Model_l2_Index));
    else
        ViewModel(handles.Models_l2v2(handles.Model_l2v2_Index));
    end;
end;


% --- Executes on button press in LoadModel.
function LoadModel_Callback(hObject, eventdata, handles)
% hObject    handle to LoadModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (handles.Level == 1)
    handles.output = LoadSBMLModel(handles.Model_l1_Index, 1);
else
    if (handles.Version == 1)
        handles.output = LoadSBMLModel(handles.Model_l2_Index, 2);
    elseif (handles.Version == 2)
        handles.output = LoadSBMLModel(handles.Model_l2v2_Index, 2, 2);
    elseif (handles.Version == 3)
        handles.output = LoadSBMLModel(handles.Model_l2v3_Index, 2, 3);
    end;
end;
set(handles.Close, 'Enable', 'on');
set(handles.LoadModel, 'Enable', 'off');

guidata(hObject, handles);

%uiresume;

% --- Executes on button press in DeleteModel.
function DeleteModel_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (handles.Level == 1)
    DeleteSBMLModel(handles.Model_l1_Index, 1);
else
    if (handles.Version == 1)
        DeleteSBMLModel(handles.Model_l2_Index, 2);
    elseif (handles.Version == 2)
        DeleteSBMLModel(handles.Model_l2v2_Index, 2, 2);
    elseif (handles.Version == 3)
        DeleteSBMLModel(handles.Model_l2v3_Index, 2, 3);
    end;
end;

load 'SBML_Models';
if (~exist('Models_l1'))
   n_level1 = 0;
   handles.Models_l1 = 0;
else
   [m, n_level1] = size(Models_l1);
   handles.Models_l1 = Models_l1;
end;

if (~exist('Models_l2'))
   n_level2 = 0;
   handles.Models_l2 = 0;
else
   [m, n_level2] = size(Models_l2);
   handles.Models_l2 = Models_l2;
end;

if (~exist('Models_l2v2'))
   n_level2v2 = 0;
   handles.Models_l2v2 = 0;
else
   [m, n_level2v2] = size(Models_l2v2);
   handles.Models_l2v2 = Models_l2v2;
end;

if (~exist('Models_l2v3'))
   n_level2v3 = 0;
   handles.Models_l2v3 = 0;
else
   [m, n_level2v3] = size(Models_l2v3);
   handles.Models_l2v3 = Models_l2v3;
end;


% save in data 
handles.n_level1 = n_level1;
handles.n_level2 = n_level2;
handles.n_level2v2 = n_level2v2;
handles.n_level2v3 = n_level2v3;

for nNumber = 1:n_level1
    ListNames_l1{nNumber} = Models_l1(nNumber).name;
end;
if (n_level1 == 0)
    ListNames_l1 = 'None saved';
end;
for nNumber = 1:n_level2
    Name = Models_l2(nNumber).id;
    k = isempty(Name);
    if (k == 1)
        Name = Models_l2(nNumber).name;
    end;
    ListNames_l2{nNumber} = Name;
end;
if (n_level2 == 0)
    ListNames_l2 = 'None saved';
end;
for nNumber = 1:n_level2v2
    Name = Models_l2v2(nNumber).id;
    ListNames_l2v2{nNumber} = Name;
end;
if (n_level2v2 == 0)
    ListNames_l2v2 = 'None saved';
end;
for nNumber = 1:n_level2v3
    Name = Models_l2v3(nNumber).id;
    ListNames_l2v3{nNumber} = Name;
end;
if (n_level2v3 == 0)
    ListNames_l2v3 = 'None saved';
end;


handles.ListNames_l1 = ListNames_l1;
handles.ListNames_l2 = ListNames_l2;
handles.ListNames_l2v2 = ListNames_l2v2;
handles.ListNames_l2v3 = ListNames_l2v3;

if (handles.Level == 1)
    if (handles.Model_l1_Index > n_level1)
        if (n_level1 == 0)
            handles.Model_l1_Index = 1;
           set(handles.ListModels, 'Value', handles.Model_l1_Index);
           set(handles.ListModels, 'String', ListNames_l1);
           set(handles.SelModel, 'String', 'None');
        else
            handles.Model_l1_Index = n_level1;
           set(handles.ListModels, 'Value', handles.Model_l1_Index);
           set(handles.ListModels, 'String', ListNames_l1);
           set(handles.SelModel, 'String', handles.ListNames_l1(handles.Model_l1_Index));
        end;
   end;
else
    if (handles.Version == 1)
        if (handles.Model_l2_Index > n_level2)
            if (n_level2 == 0)
                handles.Model_l2_Index = 1;
               set(handles.ListModels, 'Value', handles.Model_l2_Index);
               set(handles.ListModels, 'String', ListNames_l2);
               set(handles.SelModel, 'String', 'None');
            else
                handles.Model_l2_Index = n_level2;
               set(handles.ListModels, 'Value', handles.Model_l2_Index);
               set(handles.ListModels, 'String', ListNames_l2);
               set(handles.SelModel, 'String', handles.ListNames_l2(handles.Model_l2_Index));
            end;
        end;
    elseif (handles.Version == 2)
        if (handles.Model_l2v2_Index > n_level2v2)
            if (n_level2v2 == 0)
                handles.Model_l2v2_Index = 1;
               set(handles.ListModels, 'Value', handles.Model_l2v2_Index);
               set(handles.ListModels, 'String', ListNames_l2v2);
               set(handles.SelModel, 'String', 'None');
            else
                handles.Model_l2v2_Index = n_level2v2;
               set(handles.ListModels, 'Value', handles.Model_l2v2_Index);
               set(handles.ListModels, 'String', ListNames_l2v2);
               set(handles.SelModel, 'String', handles.ListNames_l2v2(handles.Model_l2v2_Index));
            end;
        end;
    elseif (handles.Version == 3)
        if (handles.Model_l2v3_Index > n_level2v3)
            if (n_level2v3 == 0)
                handles.Model_l2v3_Index = 1;
               set(handles.ListModels, 'Value', handles.Model_l2v3_Index);
               set(handles.ListModels, 'String', ListNames_l2v3);
               set(handles.SelModel, 'String', 'None');
            else
                handles.Model_l2v3_Index = n_level2v3;
               set(handles.ListModels, 'Value', handles.Model_l2v3_Index);
               set(handles.ListModels, 'String', ListNames_l2v3);
               set(handles.SelModel, 'String', handles.ListNames_l2v3(handles.Model_l2v3_Index));
            end;
        end;
    end;
end;
%set(handles.ListModels, 'Value', handles.ModelIndex);
%set(handles.ListModels, 'String', ListNames);
%set(handles.SelModel, 'String', handles.Models(handles.ModelIndex).Name);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(get(handles.figure1, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.figure1);
else
    % The GUI is no longer waiting, just close it
    delete(handles.figure1);
end


% --- Executes during object creation, after setting all properties.
function ListModels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListModels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in ListModels.
function ListModels_Callback(hObject, eventdata, handles)
% hObject    handle to ListModels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (handles.Level == 1)
    handles.Model_l1_Index = get(handles.ListModels, 'Value');
   set(handles.SelModel, 'String', handles.ListNames_l1(handles.Model_l1_Index));
else
    if (handles.Version == 1)
       handles.Model_l2_Index = get(handles.ListModels, 'Value');
       set(handles.SelModel, 'String', handles.ListNames_l2(handles.Model_l2_Index));
    elseif (handles.Version == 2)
       handles.Model_l2v2_Index = get(handles.ListModels, 'Value');
       set(handles.SelModel, 'String', handles.ListNames_l2v2(handles.Model_l2v2_Index));
    elseif (handles.Version == 3)
       handles.Model_l2v3_Index = get(handles.ListModels, 'Value');
       set(handles.SelModel, 'String', handles.ListNames_l2v3(handles.Model_l2v3_Index));
    end;
end;   
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function LevelListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LevelListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in LevelListbox.
function LevelListbox_Callback(hObject, eventdata, handles)
% hObject    handle to LevelListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns LevelListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LevelListbox

handles.Level = get(handles.LevelListbox, 'Value');
handles.Model_l1_Index = 1;
handles.Model_l2_Index = 1;
handles.Model_l2v2_Index = 1;
handles.Model_l2v3_Index = 1;

if (handles.Level == 1)
    set(handles.popupversion, 'String', handles.ListVersions);
    if (handles.Version == 3)
        handles.Version = 2;
    end;
    set(handles.popupversion, 'Value', handles.Version);
    set(handles.ListModels, 'String', handles.ListNames_l1);
    if (handles.n_level1 == 0)
        set(handles.SelModel, 'String', 'None');
    else
        set(handles.SelModel, 'String', handles.Models_l1(handles.Model_l1_Index).name);
    end;
    set(handles.ListModels, 'Value', handles.Model_l1_Index);
else
    set(handles.popupversion, 'String', handles.ListL2Versions);
    set(handles.popupversion, 'Value', handles.Version);
    if (handles.Version == 1)
        set(handles.ListModels, 'String', handles.ListNames_l2);
        if (handles.n_level2 == 0)
            set(handles.SelModel, 'String', 'None');
        else
            set(handles.SelModel, 'String', handles.ListNames_l2(handles.Model_l2_Index));
        end;
        set(handles.ListModels, 'Value', handles.Model_l2_Index);
    else
        set(handles.ListModels, 'String', handles.ListNames_l2v2);
        if (handles.n_level2v2 == 0)
            set(handles.SelModel, 'String', 'None');
        else
            set(handles.SelModel, 'String', handles.ListNames_l2v2(handles.Model_l2v2_Index));
        end;
        set(handles.ListModels, 'Value', handles.Model_l2v2_Index);
    end;
end;guidata(hObject, handles);






% --- Executes on selection change in popupversion.
function popupversion_Callback(hObject, eventdata, handles)
% hObject    handle to popupversion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupversion contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupversion
handles.Version = get(handles.popupversion, 'Value');
handles.Model_l1_Index = 1;
handles.Model_l2_Index = 1;
handles.Model_l2v2_Index = 1;
handles.Model_l2v3_Index = 1;

if (handles.Level == 1)
    set(handles.ListModels, 'String', handles.ListNames_l1);
    if (handles.n_level1 == 0)
        set(handles.SelModel, 'String', 'None');
    else
        set(handles.SelModel, 'String', handles.Models_l1(handles.Model_l1_Index).name);
    end;
    set(handles.ListModels, 'Value', handles.Model_l1_Index);
else
    if (handles.Version == 1)
        set(handles.ListModels, 'String', handles.ListNames_l2);
        if (handles.n_level2 == 0)
            set(handles.SelModel, 'String', 'None');
        else
            set(handles.SelModel, 'String', handles.ListNames_l2(handles.Model_l2_Index));
        end;
        set(handles.ListModels, 'Value', handles.Model_l2_Index);
    elseif (handles.Version == 2)
        set(handles.ListModels, 'String', handles.ListNames_l2v2);
        if (handles.n_level2v2 == 0)
            set(handles.SelModel, 'String', 'None');
        else
            set(handles.SelModel, 'String', handles.ListNames_l2v2(handles.Model_l2v2_Index));
        end;
        set(handles.ListModels, 'Value', handles.Model_l2v2_Index);
    elseif (handles.Version == 3)
        set(handles.ListModels, 'String', handles.ListNames_l2v3);
        if (handles.n_level2v3 == 0)
            set(handles.SelModel, 'String', 'None');
        else
            set(handles.SelModel, 'String', handles.ListNames_l2v3(handles.Model_l2v3_Index));
        end;
        set(handles.ListModels, 'Value', handles.Model_l2v3_Index);
    end;
end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupversion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupversion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


