function varargout = ViewSpecies(varargin)
% VIEWSPECIES M-file for ViewSpecies.fig
%
%  Filename    : ViewSpecies.m
%  Description : drives GUI that browses a sbml-matlab species
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
%      VIEWSPECIES, by itself, creates a new VIEWSPECIES or raises the existing
%      singleton*.
%
%      H = VIEWSPECIES returns the handle to a new VIEWSPECIES or the handle to
%      the existing singleton*.
%
%      VIEWSPECIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIEWSPECIES.M with the given input arguments.
%
%      VIEWSPECIES('Property','Value',...) creates a new VIEWSPECIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ViewSpecies_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ViewSpecies_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ViewSpecies

% Last Modified by GUIDE v2.5 30-Sep-2003 15:01:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ViewSpecies_OpeningFcn, ...
                   'gui_OutputFcn',  @ViewSpecies_OutputFcn, ...
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


% --- Executes just before ViewSpecies is made visible.
function ViewSpecies_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ViewSpecies (see VARARGIN)

% Choose default command line output for ViewSpecies
handles.output = hObject;

% get the input argument and assign to the handle
Species = varargin{1};
handles.Species = Species;

% determine sbml level
if (isSBML_Species(Species, 1))
    Level = 1;
elseif (isSBML_Species(Species, 2))
    Level = 2;
else
    error('Structure supplied is not a SBML Species');
end;

% display items common to both levels
set(handles.Compartment, 'String', Species.compartment);
Boundary = double(Species.boundaryCondition);
set(handles.BoundaryCheck, 'Value', Boundary);
if (Species.isSetCharge == 1)
    Charge = double(Species.charge);
    set(handles.Charge, 'String', num2str(Charge));
else
    set(handles.Charge, 'String', '');
end;

% dislay items for each level only
% hide display otherwise if not included within a level
if (Level == 1) 
    set(handles.SpeciesName, 'String', Species.name);
    set(handles.Sub_Units_text, 'String', 'Units');
    if (Species.isSetInitialAmount == 1)
        set(handles.InitialValue, 'String', num2str(Species.initialAmount));
    else
        set(handles.InitialValue, 'String', 'Not set');
    end;
    set(handles.Sub_Units, 'String', Species.units);
    set(handles.Spatial_Units, 'Visible', 'off')
    set(handles.Spatial_Units_text, 'Visible', 'off')
    set(handles.OptName, 'Visible', 'off');
    set(handles.OptionalName, 'Visible', 'off');
    set(handles.ConstantCheck, 'Visible', 'off');
else
    set(handles.SpeciesName, 'String', Species.id);
    % determine whether the optional name field has a value
    if (isempty(Species.name))
        set(handles.OptName, 'Visible', 'off');
        set(handles.OptionalName, 'Visible', 'off');
    else
        set(handles.OptionalName, 'String', Species.name);
    end;
    if (Species.isSetInitialAmount == 1)
        set(handles.InitialValue, 'String', num2str(Species.initialAmount));
        set(handles.Sub_Units_text, 'String', 'Units');
        set(handles.Sub_Units, 'String', Species.substanceUnits);
        set(handles.Spatial_Units, 'Visible', 'off')
        set(handles.Spatial_Units_text, 'Visible', 'off')
    elseif (Species.isSetInitialConcentration == 1)
        set(handles.Initial_text, 'String', 'Initial concentration');
        set(handles.InitialValue, 'String', num2str(Species.initialConcentration));
        set(handles.Sub_Units, 'String', Species.substanceUnits);
        if (Species.hasOnlySubstanceUnits == 1)
            set(handles.Spatial_Units, 'Visible', 'off')
            set(handles.Spatial_Units_text, 'Visible', 'off')
        else
            set(handles.Spatial_Units, 'String', Species.spatialSizeUnits)
        end;
    else
        set(handles.InitialValue, 'String', 'Not set');
        set(handles.Sub_Units, 'String', '');
        set(handles.Spatial_Units, 'String', '')
    end;
    set(handles.ConstantCheck, 'Value', Species.constant);
end;

 % disable all editable boxes at present
set(handles.InitialValue, 'Enable', 'off');
set(handles.Sub_Units, 'Enable', 'off');
set(handles.Charge, 'Enable', 'off');
set(handles.Spatial_Units, 'Enable', 'off');
set(handles.BoundaryCheck, 'Enable', 'off');
set(handles.ConstantCheck, 'Enable', 'off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ViewSpecies wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ViewSpecies_OutputFcn(hObject, eventdata, handles)
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

function InitialValue_Callback(hObject, eventdata, handles)
% hObject    handle to InitialValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function BoundaryCheck_Callback(hObject, eventdata, handles)
% hObject    handle to BoundaryCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function Sub_Units_Callback(hObject, eventdata, handles)
% hObject    handle to Spatial_Units_sub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Spatial_Units_Callback(hObject, eventdata, handles)
% hObject    handle to Spatial_Units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function Charge_Callback(hObject, eventdata, handles)
% hObject    handle to Charge (see GCBO)
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

function Charge_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Charge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function Spatial_Units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Spatial_Units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function Sub_Units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Spatial_Units_sub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



