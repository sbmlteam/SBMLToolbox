function varargout = SelectSpecies(varargin)
% SelectSpecies takes an SBML Model
% displays 
%           a GUI that allows the user to add/remove species from a list
% and returns 
%           an array of Species selected by the user


%
%  Filename    : SelectSpecies.m
%  Description : takes a SBMLModel and returns an array of species selected
%                   by the user
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-02-02
%  Revision    : $Id$
%  Source      : $Source $
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
%
% SELECTSPECIES M-file for SelectSpecies.fig
%      SELECTSPECIES, by itself, creates a new SELECTSPECIES or raises the existing
%      singleton*.
%
%      H = SELECTSPECIES returns the handle to a new SELECTSPECIES or the handle to
%      the existing singleton*.
%
%      SELECTSPECIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECTSPECIES.M with the given input arguments.
%
%      SELECTSPECIES('Property','Value',...) creates a new SELECTSPECIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SelectSpecies_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SelectSpecies_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SelectSpecies_OpeningFcn, ...
                   'gui_OutputFcn',  @SelectSpecies_OutputFcn, ...
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


% --- Executes just before SelectSpecies is made visible.
function SelectSpecies_OpeningFcn(hObject, eventdata, handles, varargin)
SBMLModel = varargin{1};

Species = GetSpecies(SBMLModel);
SelectedSpecies = {};

% populate listboxes
NumSpecies = length(Species);
for i = 1:NumSpecies
    ListSp(i) = Species(i);
end;

set(handles.Species_popup, 'String', ListSp);
set(handles.List_Selected, 'String', '');

% save variables needed within the handle
handles.SpeciesIndex = 1;
handles.Species = Species;
handles.SelectedSpecies = SelectedSpecies;
handles.SelectedNumber = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SelectSpecies wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SelectSpecies_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% avoids the output of species that were selected and then removed
output = {};
for i = 1:handles.SelectedNumber
    output(i) = handles.SelectedSpecies(i);
end;

% catch case when user hasnt selected any species
if (handles.SelectedNumber == 0)
    varargout{1} = '';
else
    varargout{1} = output;
end;

% close the figure
close(handles.figure1);


% --- Executes on selection change in Species_popup.
function Species_popup_Callback(hObject, eventdata, handles)
% hObject    handle to Species_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get the selected species and add it to the list of selected species
handles.SpeciesIndex = get(handles.Species_popup, 'Value');

handles.SelectedNumber = handles.SelectedNumber + 1;
handles.SelectedSpecies(handles.SelectedNumber) = handles.Species(handles.SpeciesIndex);

for i = 1:handles.SelectedNumber;
    Edit_string(i) = handles.SelectedSpecies(i);
end;
set(handles.List_Selected, 'String', Edit_string);

% Update handles structure
guidata(hObject, handles);

% --- Executes on selection change in List_Selected.
function List_Selected_Callback(hObject, eventdata, handles)
% hObject    handle to List_Selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% DO NOTHING

% --- Executes on button press in Button_Remove.
function Button_Remove_Callback(hObject, eventdata, handles)
% hObject    handle to Button_Remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get the selected species
Number = get(handles.List_Selected, 'Value');

% remove from list of selected species
handles.SelectedNumber = handles.SelectedNumber - 1;

for i = 1:Number-1
    TempSelectedSpecies(i) = handles.SelectedSpecies(i);
end;

for i = Number:handles.SelectedNumber
    TempSelectedSpecies(i) = handles.SelectedSpecies(i+1);
end;

% catch case where only slected item is being removed
if (handles.SelectedNumber == 0)
    Edit_string = '';
else
    for i = 1:handles.SelectedNumber;
        handles.SelectedSpecies(i) = TempSelectedSpecies(i);
        Edit_string(i) = handles.SelectedSpecies(i);
    end;
end;
% update the list
set(handles.List_Selected, 'Value', handles.SelectedNumber);
set(handles.List_Selected, 'String', Edit_string);

% Update handles structure
guidata(hObject, handles);




% --- Executes on button press in OK_button.
function OK_button_Callback(hObject, eventdata, handles)
% hObject    handle to OK_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(handles.figure1, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.figure1);
else
    % The GUI is no longer waiting, just close it
    delete(handles.figure1);
end


% --- Executes on button press in Cancel_Button.
function Cancel_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% cancel any changes
handles.SelectedNumber = 0;


% Update handles structure
guidata(hObject, handles);

if isequal(get(handles.figure1, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.figure1);
else
    % The GUI is no longer waiting, just close it
    delete(handles.figure1);
end

%--------------------------------------------------------------------------
%   CREATE FUNCTIONS
%
%-------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function Species_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Species_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes during object creation, after setting all properties.
function List_Selected_CreateFcn(hObject, eventdata, handles)
% hObject    handle to List_Selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




