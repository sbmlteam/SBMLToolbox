function varargout = ViewReaction(varargin)
% VIEWREACTION M-file for ViewReaction.fig
%
%  Filename    : ViewReaction.m
%  Description : drives GUI that browses a sbml-matlab reaction
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
%      VIEWREACTION, by itself, creates a new VIEWREACTION or raises the existing
%      singleton*.
%
%      H = VIEWREACTION returns the handle to a new VIEWREACTION or the handle to
%      the existing singleton*.
%
%      VIEWREACTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIEWREACTION.M with the given input arguments.
%
%      VIEWREACTION('Property','Value',...) creates a new VIEWREACTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ViewReaction_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ViewReaction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ViewReaction

% Last Modified by GUIDE v2.5 30-Sep-2003 15:53:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ViewReaction_OpeningFcn, ...
                   'gui_OutputFcn',  @ViewReaction_OutputFcn, ...
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


% --- Executes just before ViewReaction is made visible.
function ViewReaction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ViewReaction (see VARARGIN)

% Choose default command line output for ViewReaction
handles.output = hObject;

% get the input argument and assign to the handle
Reaction = varargin{1};
handles.Reaction = Reaction;


% determine sbml level
if (isSBML_Reaction(Reaction, 1))
    Level = 1;
elseif (isSBML_Reaction(Reaction, 2))
    Level = 2;
else
    error('Structure supplied is not a SBML Reaction');
end;
handles.Level = Level;

% write the reaction
strReaction = WriteReaction(Reaction, Level);
% write list of reactants
[x,NumReacts] = size(Reaction.reactant);
for i = 1:NumReacts
    ListReacts{i} = Reaction.reactant(i).species;
end;
if (NumReacts == 0)
    ListReacts{1} = 'NO REACTANTS';
end;
% read list products
[x,NumProds] = size(Reaction.product);
for i = 1:NumProds
    ListProds{i} = Reaction.product(i).species;
end;
if(NumProds == 0)
    ListProds{i} = 'NO PRODUCTS';
end;
% read list of modifiers
if (Level == 2)
    [x, NumMods] = size(Reaction.modifier);
    for i = 1:NumMods
        ListMods{i} = Reaction.modifier(i).species;
    end;
    if(NumMods == 0)
        ListMods{1} = 'NO MODIFIERS';
    end;
end;

% display items common to both levels
set(handles.ReactForm, 'String', strReaction);
set(handles.ListReactants, 'String', ListReacts);
set(handles.ListProducts, 'String', ListProds);
handles.ProdIndex = 1;
handles.ReactIndex = 1;
set(handles.Reversible, 'Value', Reaction.reversible);
set(handles.Fast, 'Value', Reaction.fast);

% dislay items for each level only
% hide display otherwise if not included within a level
if (Level == 1) 
    set(handles.Name, 'String', Reaction.name);
    set(handles.ListModifiers, 'Visible', 'off');
    set(handles.Modifier_text, 'Visible', 'off');
    set(handles.OptName, 'Visible', 'off');
    set(handles.OptionalName, 'Visible', 'off');
else
    set(handles.Name, 'String', Reaction.id);
    % determine whether the optional name field has a value
    if (isempty(Reaction.name))
        set(handles.OptName, 'Visible', 'off');
        set(handles.OptionalName, 'Visible', 'off');
    else
        set(handles.OptionalName, 'String', Reaction.name);
    end;
    set(handles.ListModifiers, 'String', ListMods);
    handles.ModIndex = 1;
end;

% disable view kinetic law if necessary
if (isempty(Reaction.kineticLaw))
    set(handles.ViewKineticLaw, 'Enable', 'off');
end;

% disable all editable boxes at present
set(handles.Reversible, 'Enable', 'off');
set(handles.Fast, 'Enable', 'off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ViewReaction wait for user response (see UIRESUME)
uiwait(handles.figure1);
  



% --- Outputs from this function are returned to the command line.
function varargout = ViewReaction_OutputFcn(hObject, eventdata, handles)
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

% -------------------------------------------------------------

% CALLBACK FUNCTIONS

% -------------------------------------------------------------

function ListReactants_Callback(hObject, eventdata, handles)
% hObject    handle to ListReactants (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.ReactIndex = get(handles.ListReactants, 'Value');
guidata(hObject, handles);

function ListProducts_Callback(hObject, eventdata, handles)
% hObject    handle to ListProducts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.ProdIndex = get(handles.ListProducts, 'Value');
guidata(hObject, handles);

function ListModifiers_Callback(hObject, eventdata, handles)
% hObject    handle to ListModifiers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.ModIndex = get(handles.ListModifiers, 'Value');
guidata(hObject, handles);

function ViewReactant_Callback(hObject, eventdata, handles)
% hObject    handle to ViewReactant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ViewSpeciesReference(handles.Reaction.reactant(handles.ReactIndex));

function ViewProduct_Callback(hObject, eventdata, handles)
% hObject    handle to ViewProduct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ViewSpeciesReference(handles.Reaction.product(handles.ProdIndex));

function ViewKineticLaw_Callback(hObject, eventdata, handles)
% hObject    handle to ViewKineticLaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ViewKineticLaw(handles.Reaction.kineticLaw);

function Reversible_Callback(hObject, eventdata, handles)
% hObject    handle to Reversible (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function Fast_Callback(hObject, eventdata, handles)
% hObject    handle to Fast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ---------------------------------------------------------------------

% CREATION FUNCTIONS

% ---------------------------------------------------------------------

% --- Executes during object creation, after setting all properties.
function ListReactants_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListReactants (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function ListProducts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListProducts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function ListModifiers_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListModifiers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% ----------------------------------------------------------------

% OTHER FUNCTIONS

% -----------------------------------------------------------------

function strReaction = WriteReaction(Reaction, Level)
% produces a string version of the reaction
strReaction = '';
% read reactants
[x,NumReacts] = size(Reaction.reactant);
for i = 1:NumReacts
    R = Reaction.reactant(i);
    % determine stoichiometry
    Stoch = double(R.stoichiometry)/double(R.denominator);
    if (Level == 1)
        if (Stoch ~= 1)
            strReaction = strcat(strReaction, num2str(Stoch));
        end;
    else
        if (isempty(R.stoichiometryMath))
            if (Stoch ~= 1)
                strReaction = strcat(strReaction, num2str(Stoch));
            end;
        else
            strReaction = strcat(strReaction, R.stoichiometryMath);
        end;
    end;
    strReaction = strcat(strReaction, R.species);
    if (i ~= NumReacts)
        strReaction = strcat(strReaction, ' + ');
    end;   
end;

% check for reversibility
if (Reaction.reversible == 1)
    strReaction = strcat(strReaction, ' <-> ');
else
    strReaction = strcat(strReaction, ' -> ');
end;

% read products
[x,NumProds] = size(Reaction.product);
for i = 1:NumProds
    P = Reaction.product(i);
    % determine stoichiometry
    Stoch = double(P.stoichiometry)/double(P.denominator);
    if (Level == 1)
        if (Stoch ~= 1)
            strReaction = strcat(strReaction, num2str(Stoch));
        end;
    else
        if (isempty(P.stoichiometryMath))
            if (Stoch ~= 1)
                strReaction = strcat(strReaction, num2str(Stoch));
            end;
        else
            strReaction = strcat(strReaction, P.stoichiometryMath);
        end;
    end;
    strReaction = strcat(strReaction, P.species);
    if (i ~= NumProds)
        strReaction = strcat(strReaction, ' + ');
    end;   
end;

