function varargout = ViewModel(varargin)
% ViewModel(Model) raises a GUI that illustrate the SBML model 'Model'
%
% It shows the Name or Id of the model with the SBML Level and version.
%
% The structures within the Model are listed and future development will
% allow each of these to be viewed
%
% Save to SBML_Models allows the model to be saved to the MATLAB data file
% SBML_Models.dat

%  Filename    :   ViewModel.m
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
                   'gui_OpeningFcn', @ViewModel_OpeningFcn, ...
                   'gui_OutputFcn',  @ViewModel_OutputFcn, ...
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


% --- Executes just before ViewModel is made visible.
function ViewModel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ViewModel (see VARARGIN)

% Choose default command line output for ViewModel
handles.output = hObject;

% check that input argument is an SBML Model 
Model = varargin{1};
bSBML = isValidSBML_Model(Model);
if (~bSBML)
    error('Input argument is not a SBML Model');
end;

Level = Model.SBML_level;

% populate the lists of structures
if (Level == 1) 
    [x,NumReactions] = size(Model.reaction);
    for i = 1:NumReactions
        ReactList{i} = Model.reaction(i).name;
    end;
    if (NumReactions == 0)
        ReactList{1} = 'NO REACTIONS';
    end;

    [x,NumSpecies] = size(Model.species);
    for i = 1:NumSpecies
        SpeciesList{i} = Model.species(i).name;
    end;
    if (NumSpecies == 0)
        SpeciesList{1} = 'NO SPECIES';
    end;

    [x,NumUnitDefs] = size(Model.unitDefinition);
    for i = 1:NumUnitDefs
        UnitDefList{i} = Model.unitDefinition(i).name;
    end;
    if (NumUnitDefs == 0)
        UnitDefList{1} = 'NO UNIT DEFINITIONS';
    end;

    [x,NumCompartments] = size(Model.compartment);
    for i = 1:NumCompartments
        CompList{i} = Model.compartment(i).name;
    end;
    if (NumCompartments == 0)
        CompList{1} = 'NO COMPARTMENTS';
    end;

    [x,NumParameters] = size(Model.parameter);
    for i = 1:NumParameters
        ParamList{i} = Model.parameter(i).name;
    end;
    if (NumParameters == 0)
        ParamList{1} = 'NO PARAMETERS';
    end;

    [x,NumRules] = size(Model.rule);
    for i = 1:NumRules
        RuleList{i} = strcat('Rule', int2str(i));
    end;
    if (NumRules == 0)
        RuleList{1} = 'NO RULES';
    end;
    NumFunctions = 0;
    NumEvents = 0;
    EventList{1} = 'N/A';
    FuncList{1} = 'N/A';
else
    [x,NumReactions] = size(Model.reaction);
    for i = 1:NumReactions
        % use id unless is empty then use name
        if (isempty(Model.reaction(i).id))
            ReactList{i} = Model.reaction(i).name;
        else
            ReactList{i} = Model.reaction(i).id;
        end;
    end;
    if (NumReactions == 0)
        ReactList{1} = 'NO REACTIONS';
    end;

    [x,NumSpecies] = size(Model.species);
    for i = 1:NumSpecies
        % use id unless is empty then use name
        if (isempty(Model.species(i).id))
            SpeciesList{i} = Model.species(i).name;
        else
            SpeciesList{i} = Model.species(i).id;
        end;
    end;
    if (NumSpecies == 0)
        SpeciesList{1} = 'NO SPECIES';
    end;

    [x,NumUnitDefs] = size(Model.unitDefinition);
    for i = 1:NumUnitDefs
        % use id unless is empty then use name
        if (isempty(Model.unitDefinition(i).id))
            UnitDefList{i} = Model.unitDefinition(i).name;
        else
            UnitDefList{i} = Model.unitDefinition(i).id;
        end;
    end;
    if (NumUnitDefs == 0)
        UnitDefList{1} = 'NO UNIT DEFINITIONS';
    end;

    [x,NumCompartments] = size(Model.compartment);
    for i = 1:NumCompartments
        % use id unless is empty then use name
        if (isempty(Model.compartment(i).id))
            CompList{i} = Model.compartment(i).name;
        else
            CompList{i} = Model.compartment(i).id;
        end;
    end;
    if (NumCompartments == 0)
        CompList{1} = 'NO COMPARTMENTS';
    end;

    [x,NumParameters] = size(Model.parameter);
    for i = 1:NumParameters
        % use id unless is empty then use name
        if (isempty(Model.parameter(i).id))
            ParamList{i} = Model.parameter(i).name;
        else
            ParamList{i} = Model.parameter(i).id;
        end;
    end;
    if (NumParameters == 0)
        ParamList{1} = 'NO PARAMETERS';
    end;

    [x,NumRules] = size(Model.rule);
    for i = 1:NumRules
        RuleList{i} = strcat('Rule', int2str(i));
    end;
    if (NumRules == 0)
        RuleList{1} = 'NO RULES';
    end;
    
    [x,NumFunctions] = size(Model.functionDefinition);
    for i = 1:NumFunctions
        % use id unless is empty then use name
        if (isempty(Model.functionDefinition(i).id))
            FuncList{i} = Model.functionDefinition(i).name;
        else
            FuncList{i} = Model.functionDefinition(i).id;
        end;
    end;
    if (NumFunctions == 0)
        FuncList{1} = 'NO FUNCTION DEFINITIONS';
    end;
 
    [x,NumEvents] = size(Model.event);
    for i = 1:NumEvents
        % use id unless is empty then use name
        Name = Model.event(i).name;
        Id = Model.event(i).id;
        if (isempty(Name) && isempty(Id))
            EventList{i} = strcat('Event', int2str(i));
        elseif (isempty(Name))
            EventList{i} = Id;
        else
            EventList(i) = Name;
        end;
   end;
    if (NumEvents == 0)
        EventList{1} = 'NO EVENTS';
    end;

end;

% display items common to both levels
set(handles.Level, 'String', Model.SBML_level);
set(handles.Version, 'String', Model.SBML_version);
set(handles.ReactionList, 'String', ReactList);
set(handles.SpeciesList, 'String', SpeciesList);
set(handles.ListUnitDefinition, 'String', UnitDefList);
set(handles.ListCompartment, 'String', CompList);
set(handles.ListParameters, 'String', ParamList);
set(handles.ListRules, 'String', RuleList);

% dislay items for each level only
% hide display otherwise if not included within a level
if (Level == 1) 
    set(handles.ModelName, 'String', Model.name);
    set(handles.OptName, 'Visible', 'off');
    set(handles.OptionalName, 'Visible', 'off');
    set(handles.Function_text, 'Visible', 'off');
    set(handles.ListFunctions, 'Visible', 'off');
    set(handles.ViewFunction, 'Visible', 'off');
    set(handles.Event_text, 'Visible', 'off');
    set(handles.ListEvents, 'Visible', 'off');
    set(handles.ViewEvent, 'Visible', 'off');
else
    % determine whether the optional name field has a value
    if (isempty(Model.name))
        set(handles.OptName, 'Visible', 'off');
        set(handles.OptionalName, 'Visible', 'off');
    else
        set(handles.OptionalName, 'String', Model.name);
    end;
    set(handles.ModelName, 'String', Model.id);
    set(handles.ListEvents, 'String', EventList);
    set(handles.ListFunctions, 'String', FuncList);
end;
        
% disable any buttons that are not relevant 
if (NumReactions == 0)
    set(handles.ReactionList, 'Enable', 'off');
    set(handles.ViewReaction, 'Enable', 'off');
end;
if (NumSpecies == 0)
    set(handles.SpeciesList, 'Enable', 'off');
    set(handles.ViewSpecies, 'Enable', 'off');
end;
if (NumUnitDefs == 0)
    set(handles.ListUnitDefinition, 'Enable', 'off');
    set(handles.ViewUnitDef, 'Enable', 'off');
end;
if (NumCompartments == 0)
    set(handles.ListCompartment, 'Enable', 'off');
    set(handles.ViewCompartment, 'Enable', 'off');
end;
if (NumParameters == 0)
    set(handles.ListParameters, 'Enable', 'off');
    set(handles.ViewParameter, 'Enable', 'off');
end;
if (NumRules == 0)
    set(handles.ListRules, 'Enable', 'off');
    set(handles.ViewRule, 'Enable', 'off');
end;
if (NumFunctions == 0)
    set(handles.ListFunctions, 'Enable', 'off');
    set(handles.ViewFunction, 'Enable', 'off');
end;
if (NumEvents == 0)
    set(handles.ListEvents, 'Enable', 'off');
    set(handles.ViewEvent, 'Enable', 'off');
end;

% set the index values for the lists of structures
handles.ReactionIndex = 1;
handles.SpeciesIndex = 1;
handles.UnitDefIndex = 1;
handles.CompIndex = 1;
handles.ParamIndex = 1;
handles.RuleIndex = 1;
handles.FuncIndex = 1;
handles.EventIndex = 1;

handles.Model = Model;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ViewModel wait for user response (see UIRESUME)
%uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ViewModel_OutputFcn(hObject, eventdata, handles)
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
close(handles.figure1); 

% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

SaveSBMLModel(handles.Model);


% -----------------------------------------------------------

% LIST CALLBACK & VIEW FUNCTIONS

% -----------------------------------------------------------

% --- Executes on selection change in ReactionList.
function ReactionList_Callback(hObject, eventdata, handles)
% hObject    handle to ReactionList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get the index of the reaction selected
handles.ReactionIndex = get(handles.ReactionList, 'Value');
guidata(hObject, handles);


% --- Executes on button press in ViewReaction.
function ViewReaction_Callback(hObject, eventdata, handles)
% hObject    handle to ViewReaction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ViewReaction(handles.Model.reaction(handles.ReactionIndex));

% --- Executes on selection change in SpeciesList.
function SpeciesList_Callback(hObject, eventdata, handles)
% hObject    handle to SpeciesList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get the index of the reaction selected
handles.SpeciesIndex = get(handles.SpeciesList, 'Value');
guidata(hObject, handles);


% --- Executes on button press in ViewSpecies.
function ViewSpecies_Callback(hObject, eventdata, handles)
% hObject    handle to ViewSpecies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ViewSpecies(handles.Model.species(handles.SpeciesIndex));

% --- Executes on selection change in ListUnitDefinition.
function ListUnitDefinition_Callback(hObject, eventdata, handles)
% hObject    handle to ListUnitDefinition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.UnitDefIndex = get(handles.ListUnitDefinition, 'Value');
guidata(hObject, handles);


% --- Executes on button press in ViewUnitDef.
function ViewUnitDef_Callback(hObject, eventdata, handles)
% hObject    handle to ViewUnitDef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ViewUnitDefinition(handles.Model.unitDefinition(handles.UnitDefIndex));

% --- Executes on selection change in ListCompartment.
function ListCompartment_Callback(hObject, eventdata, handles)
% hObject    handle to ListCompartment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.CompIndex = get(handles.ListCompartment, 'Value');
guidata(hObject, handles);


% --- Executes on button press in ViewComp.
function ViewComp_Callback(hObject, eventdata, handles)
% hObject    handle to ViewComp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ViewCompartment(handles.Model.compartment(handles.CompIndex));

% --- Executes on selection change in ListParameters.
function ListParameters_Callback(hObject, eventdata, handles)
% hObject    handle to ListParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.ParamIndex = get(handles.ListParameters, 'Value');
guidata(hObject, handles);


% --- Executes on button press in ViewParameter.
function ViewParameter_Callback(hObject, eventdata, handles)
% hObject    handle to ViewParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ViewParameter(handles.Model.parameter(handles.ParamIndex));

% --- Executes on selection change in ListRules.
function ListRules_Callback(hObject, eventdata, handles)
% hObject    handle to ListRules (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.RuleIndex = get(handles.ListRules, 'Value');
guidata(hObject, handles);


% --- Executes on button press in ViewRule.
function ViewRule_Callback(hObject, eventdata, handles)
% hObject    handle to ViewRule (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ViewRule(handles.Model.rule(handles.RuleIndex));


% --- Executes on selection change in ListFunctions.
function ListFunctions_Callback(hObject, eventdata, handles)
% hObject    handle to ListFunctions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.FuncIndex = get(handles.ListFunctions, 'Value');
guidata(hObject, handles);


% --- Executes on button press in ViewFunction.
function ViewFunction_Callback(hObject, eventdata, handles)
% hObject    handle to ViewFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ViewFunctionDefinition(handles.Model.functionDefinition(handles.FuncIndex));

% --- Executes on selection change in ListEvents.
function ListEvents_Callback(hObject, eventdata, handles)
% hObject    handle to ListEvents (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.EventIndex = get(handles.ListEvents, 'Value');
guidata(hObject, handles);


% --- Executes on button press in ViewEvent.
function ViewEvent_Callback(hObject, eventdata, handles)
% hObject    handle to ViewEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ViewEvent(handles.Model.event(handles.EventIndex));


% ---------------------------------------------------------------------

% CREATION FUNCTIONS

% ---------------------------------------------------------------------

% --- Executes during object creation, after setting all properties.
function ReactionList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ReactionList (see GCBO)
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
function SpeciesList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpeciesList (see GCBO)
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
function ListUnitDefinition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListUnitDefinition (see GCBO)
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
function ListCompartment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListCompartment (see GCBO)
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
function ListParameters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListParameters (see GCBO)
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
function ListRules_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListRules (see GCBO)
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
function ListFunctions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListFunctions (see GCBO)
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
function ListEvents_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListEvents (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end










