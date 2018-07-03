function varargout = testes(varargin)
% TESTES MATLAB code for testes.fig
%      TESTES, by itself, creates a new TESTES or raises the existing
%      singleton*.
%
%      H = TESTES returns the handle to a new TESTES or the handle to
%      the existing singleton*.
%
%      TESTES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTES.M with the given input arguments.
%
%      TESTES('Property','Value',...) creates a new TESTES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testes

% Last Modified by GUIDE v2.5 14-May-2018 18:02:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testes_OpeningFcn, ...
                   'gui_OutputFcn',  @testes_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
%nao sei fazer isto lol
function r = getGlobalcl
global cl
r = cl;

function setGlobalcl(val)
global cl
cl = val;

function r = getGlobalvis
global vis
r = vis;

function setGlobalvis(val)
global vis
vis = val;

function r = getGlobaldimen
global dimen
r = dimen;

function setGlobaldimen(val)
global dimen
dimen = val;

function r = getGlobalsel
global sel
r = sel;

function setGlobalsel(val)
global sel
sel = val;

function r = getGlobalred
global red
r = red;

function setGlobalred(val)
global red
red = val;

function r = getGlobalclass
global class
r = class;

function setGlobalclass(val)
global class
class = val;

function r = getGlobalroc
global roc
r = roc;

function setGlobalroc(val)
global roc
roc = val;

function r = getGlobalval
global val
r = val;

function setGlobalval(val1)
global val
val = val1;


% --- Executes just before testes is made visible.
function testes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testes (see VARARGIN)

% Choose default command line output for testes
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testes wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testes_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalsam(string(contents{1})); % returns value of selected item from dropdown
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalsam(string(contents{1})); % returns value of selected item from dropdown
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalsel(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalsel(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalred(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalred(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalclass(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalclass(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalpost(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalpost(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalval(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalval(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalvis(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalvis(contents{get(hObject,'Value')}); % returns value of selected item from dropdown


% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','red');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    %handles.result=project();
    %handles.vis
    set(handles.text10, 'String','RUNNING PLEASE WAIT ............');
set(handles.pushbutton1,'Enable','off') 
    set(handles.pushbutton1,'Enable','off')
    drawnow;
    res = project(str2num(getGlobalcl),getGlobalsel,getGlobalred,getGlobaldimen,getGlobalclass,getGlobalval,getGlobalvis,getGlobalroc,0);
    printable="";
    for row = 1:length(res(1,:))
        printable = strcat(printable, res{1,row});
        printable=printable + " ";
        printable = strcat(printable, num2str(res{2,row}));
        printable = printable +newline;
    end
    set(handles.text10, 'String',string(printable));
set(handles.pushbutton1,'Enable','on') 
    set(handles.pushbutton1,'Enable','on') 
    drawnow;
    
function text10_CreateFcn(hObject, eventdata, handles)
    


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalcl(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalcl(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on selection change in popupmenu11.
function popupmenu11_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobaldimen(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu11


% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobaldimen(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu12.
function popupmenu12_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalroc(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu12


% --- Executes during object creation, after setting all properties.
function popupmenu12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
contents = cellstr(get(hObject,'String')); % returns contents as cell array
setGlobalroc(contents{get(hObject,'Value')}); % returns value of selected item from dropdown
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function popupmenu12_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton2.
function pushbutton2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text10, 'String','RUNNING PLEASE WAIT ............');
    set(handles.pushbutton1,'Enable','off') 

    drawnow;
    res = project(str2num(getGlobalcl),getGlobalsel,getGlobalred,getGlobaldimen,getGlobalclass,getGlobalval,getGlobalvis,getGlobalroc,1);
    printable="";
    for row = 1:length(res(1,:))
        %if isnumeric(res(2,row))  %solucao rapida para dar
            printable = strcat(printable, res{1,row});
            printable=printable + " ";
            printable = strcat(printable, num2str(res{2,row}));
            printable = printable +newline;
        %end
    end
    set(handles.text10, 'String',string(printable));
    set(handles.pushbutton1,'Enable','on') 
    drawnow;
