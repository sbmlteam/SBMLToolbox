function varargout = ViewRule(varargin)
% VIEWRULE M-file for ViewRule.fig
%
%  Filename    : ViewRule.m
%  Description : drives GUI that browses a sbml-matlab rule
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
%      VIEWRULE, by itself, creates a new VIEWRULE or raises the existing
%      singleton*.
%
%      H = VIEWRULE returns the handle to a new VIEWRULE or the handle to
%      the existing singleton*.
%
%      VIEWRULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIEWRULE.M with the given input arguments.
%
%      VIEWRULE('Property','Value',...) creates a new VIEWRULE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ViewRule_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ViewRule_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ViewRule

% Last Modified by GUIDE v2.5 30-Sep-2003 15:17:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ViewRule_OpeningFcn, ...
                   'gui_OutputFcn',  @ViewRule_OutputFcn, ...
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


% --- Executes just before ViewRule is made visible.
function ViewRule_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ViewRule (see VARARGIN)

% Choose default command line output for ViewRule
handles.output = hObject;

% get the input argument and assign to the handle
Rule = varargin{1};
handles.Rule = Rule;

% determine sbml level
if (isSBML_Rule(Rule, 1))
    Level = 1;
elseif (isSBML_Rule(Rule, 2))
    Level = 2;
else
    error('Structure supplied is not a SBML Rule');
end;


% display items common to all rules
if ((Level == 1) & (~isempty(Rule.type)))
    TypeDisplay = sprintf('%s - %s', Rule.typecode, Rule.type);
else
    TypeDisplay = Rule.typecode;
end;

set(handles.Type, 'String', TypeDisplay);
set(handles.Formula, 'String', Rule.formula);

% display items for particular rule type
% hide non-relevant items
switch Rule.typecode
    case 'SBML_ALGEBRAIC_RULE'
        set(handles.Vartext, 'Visible', 'off');
        set(handles.Speciestext, 'Visible', 'off');
        set(handles.Comptext, 'Visible', 'off');
        set(handles.Paramtext, 'Visible', 'off');
        set(handles.Nametext, 'Visible', 'off');
        set(handles.Unitstext, 'Visible', 'off');
        set(handles.VariableEdit, 'Visible', 'off');
        set(handles.SpeciesEdit, 'Visible', 'off');
        set(handles.CompartmentEdit, 'Visible', 'off');
        set(handles.NameEdit, 'Visible', 'off');
        set(handles.UnitsEdit, 'Visible', 'off');
        
    case {'SBML_ASSIGNMENT_RULE', 'SBML_RATE_RULE'}
        set(handles.Speciestext, 'Visible', 'off');
        set(handles.Comptext, 'Visible', 'off');
        set(handles.Paramtext, 'Visible', 'off');
        set(handles.Nametext, 'Visible', 'off');
        set(handles.Unitstext, 'Visible', 'off');
        set(handles.SpeciesEdit, 'Visible', 'off');
        set(handles.CompartmentEdit, 'Visible', 'off');
        set(handles.NameEdit, 'Visible', 'off');
        set(handles.UnitsEdit, 'Visible', 'off');
                
        set(handles.VariableEdit, 'String', Rule.variable);
        
    case 'SBML_SPECIES_CONCENTRATION_RULE'
        set(handles.Vartext, 'Visible', 'off');
        set(handles.Comptext, 'Visible', 'off');
        set(handles.Paramtext, 'Visible', 'off');
        set(handles.Nametext, 'Visible', 'off');
        set(handles.Unitstext, 'Visible', 'off');
        set(handles.VariableEdit, 'Visible', 'off');
        set(handles.CompartmentEdit, 'Visible', 'off');
        set(handles.NameEdit, 'Visible', 'off');
        set(handles.UnitsEdit, 'Visible', 'off');
        
        set(handles.SpeciesEdit, 'String', Rule.species);
        
    case 'SBML_COMPARTMENT_VOLUME_RULE'
        set(handles.Vartext, 'Visible', 'off');
        set(handles.Speciestext, 'Visible', 'off');
        set(handles.Paramtext, 'Visible', 'off');
        set(handles.Nametext, 'Visible', 'off');
        set(handles.Unitstext, 'Visible', 'off');
        set(handles.VariableEdit, 'Visible', 'off');
        set(handles.SpeciesEdit, 'Visible', 'off');
        set(handles.NameEdit, 'Visible', 'off');
        set(handles.UnitsEdit, 'Visible', 'off');
       
        set(handles.CompartmentEdit, 'String', Rule.compartment);
        
    case 'SBML_PARAMETER_RULE'
        set(handles.Vartext, 'Visible', 'off');
        set(handles.Speciestext, 'Visible', 'off');
        set(handles.Comptext, 'Visible', 'off');
        set(handles.VariableEdit, 'Visible', 'off');
        set(handles.SpeciesEdit, 'Visible', 'off');
        set(handles.CompartmentEdit, 'Visible', 'off');

        set(handles.NameEdit, 'String', Rule.name);
        set(handles.UnitsEdit, 'String', Rule.units);
  end;      
        

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ViewRule wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ViewRule_OutputFcn(hObject, eventdata, handles)
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

function VariableEdit_Callback(hObject, eventdata, handles)
% hObject    handle to VariableEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function SpeciesEdit_Callback(hObject, eventdata, handles)
% hObject    handle to SpeciesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function CompartmentEdit_Callback(hObject, eventdata, handles)
% hObject    handle to CompartmentEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function NameEdit_Callback(hObject, eventdata, handles)
% hObject    handle to NameEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function UnitsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to UnitsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ---------------------------------------------------------------------

% CREATION FUNCTIONS

% ---------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function VariableEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VariableEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function SpeciesEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpeciesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function CompartmentEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CompartmentEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function NameEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NameEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function UnitsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UnitsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


