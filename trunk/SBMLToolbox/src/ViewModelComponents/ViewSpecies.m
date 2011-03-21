function varargout = ViewSpecies(varargin)
% ViewSpecies takes
%                        a MATLAB_SBML Species structure
%                 and drives a GUI that illustrates the species structure fields and values 
%
%       NOTE: at present there is no output from this function but it could
%       be edited to allow creation and editing of the species

%  Filename    :   ViewSpecies.m
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



