unit MainFormUnit;

interface

uses
  PWStoreModel,

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TB2Dock, TB2Toolbar, TBX, SpTBXItem, TB2ExtItems, SpTBXEditors,
  TB2Item, VirtualTrees, ImgList, PngImageList, XPMan, ActnList, TntDialogs,
  Menus, ExtCtrls, Clipbrd, JvComponentBase, JvTrayIcon, JvAppStorage,
  JvAppRegistryStorage, ApplicationSettings, AppEvnts, JvFormPlacement;

type
  TPasswordListNode = record
    PWItem: TPWItem;
  end;
  PPasswordListNode = ^TPasswordListNode;

  TMainForm = class(TForm)
    TopDock: TSpTBXDock;
    MainToolbar: TSpTBXToolbar;
    PasswordList: TVirtualStringTree;
    StatusBar: TSpTBXStatusBar;
    LargeImages: TPngImageList;
    SmallImages: TPngImageList;
    XPManifest: TXPManifest;
    ShowPasswordsItem: TSpTBXItem;
    ActionList: TActionList;
    ShowPasswordsToggleAction: TAction;
    QuickSearchEdit: TSpTBXEditItem;
    MainToolbarRightAlignSpacerItem: TSpTBXRightAlignSpacerItem;
    AddItem: TSpTBXItem;
    DeleteItem: TSpTBXItem;
    SearchLabelItem: TSpTBXLabelItem;
    SeparaterItem: TSpTBXSeparatorItem;
    ControlSubmenuItem: TSpTBXSubmenuItem;
    SyncItem: TSpTBXItem;
    ConfigurationItem: TSpTBXItem;
    AboutItem: TSpTBXItem;
    SeparaterItem2: TSpTBXSeparatorItem;
    SeparaterItem3: TSpTBXSeparatorItem;
    DeleteItemAction: TAction;
    ItemCountLabel: TSpTBXLabelItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    AddFromCSVItem: TSpTBXItem;
    SpTBXItem2: TSpTBXItem;
    OpenCSVDialog: TTntOpenDialog;
    SpTBXSubmenuItem1: TSpTBXSubmenuItem;
    PasswordListPopup: TSpTBXPopupMenu;
    SpTBXItem1: TSpTBXItem;
    EditPropertiesAction: TAction;
    SpTBXItem3: TSpTBXItem;
    SpTBXItem4: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    SpTBXItem5: TSpTBXItem;
    ClipboardClearTimer: TTimer;
    TrayIcon: TJvTrayIcon;
    AppStorage: TJvAppRegistryStorage;
    SpTBXSeparatorItem3: TSpTBXSeparatorItem;
    SpTBXItem6: TSpTBXItem;
    FormStorage: TJvFormStorage;
    procedure PasswordListCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure ConfigurationItemClick(Sender: TObject);
    procedure AboutItemClick(Sender: TObject);
    procedure EditPropertiesActionUpdate(Sender: TObject);
    procedure PasswordListDblClick(Sender: TObject);
    procedure EditPropertiesActionExecute(Sender: TObject);
    procedure DeleteItemActionExecute(Sender: TObject);
    procedure PasswordListHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure AddFromCSVItemClick(Sender: TObject);
    procedure AddItemClick(Sender: TObject);
    procedure DeleteItemActionUpdate(Sender: TObject);
    procedure QuickSearchEditChange(Sender: TObject; const Text: WideString);
    procedure ShowPasswordsToggleActionExecute(Sender: TObject);
    procedure ShowPasswordsToggleActionUpdate(Sender: TObject);
    procedure PasswordListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClipboardClearTimerTimer(Sender: TObject);
    procedure SpTBXItem5Click(Sender: TObject);
    procedure SpTBXItem6Click(Sender: TObject);
    procedure TrayIconClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FCurrentKey: string;
    FCurrentStoreFile: string;    
    procedure SetCurrentKey(const Value: string);
    procedure SetCurrentStoreFile(const Value: string);    
  private
    PWItemStore: TPWItemStore;
    Settings: TPatronusSettings;
    LastLoadErrorMsg: string;
  private
    // TODO: encrypt this in memory
    property CurrentKey: string read FCurrentKey write SetCurrentKey;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMSyscommand(var Message: TWmSysCommand); message WM_SYSCOMMAND;
  protected
    function IsPasswordColumnVisible: Boolean;
    procedure SetPasswordColumnVisibility(Show: Boolean);
    procedure GUIUpdatePasswordList;
    procedure GUIUpdateStatusbar;
    procedure ResetClipboardClearTimer;
    procedure ApplyFilter;
    procedure Save;
    function Load(Filename, Password: string): Boolean;
  public
    procedure LoadAppSettings;
    procedure SaveAppSettings;
    function RequestKey: Boolean;
    procedure TryToShow;
    procedure CloseStore;
  public
    property CurrentStoreFile: string read FCurrentStoreFile write SetCurrentStoreFile;
  end;

var
  MainForm: TMainForm;

const
  // The index of the password column in the list
  PasswordColumnIndex = 2;

implementation

uses
  Xdom_4_1,
  Utilities,
  TaskDialog,
  AboutFormUnit, ConfigFormUnit, ItemPropertiesFormUnit, OpenStoreFormUnit;

{$R *.dfm}

procedure TMainForm.AboutItemClick(Sender: TObject);
begin
  with TAboutForm.Create(Self) do
    ShowModal;
end;

procedure TMainForm.AddFromCSVItemClick(Sender: TObject);
var
  XMLParser: TXmlToDomParser;
  DomImplementation: TDomImplementation;
  DomDocument: TDomDocument;
  I: Integer;

  function ReadString(Nodes: TDomNodeList; Name: string): string;
  var
    I: Integer;
  begin
    Result := '';
    try
      for I := 0 to Nodes.Length - 1 do
        if Nodes.Item(I).ExpandedName = Name then
        begin
          Result := Nodes.Item(I).ChildNodes.Item(0).NodeValue;
          Exit;
        end;
    except
      // ignore all errors
    end;
  end;

const
  RootNodeName = 'pwlist';
  ItemNodeName = 'pwentry';
begin
  if OpenCSVDialog.Execute then
    try
      XMLParser := TXmlToDomParser.Create(nil);
      XMLParser.KeepEntityRefs := False;
      DomImplementation := TDomImplementation.Create(nil);
      XMLParser.DOMImpl := DomImplementation;
      try
        // open csv file
        DomDocument := XMLParser.ParseFile(OpenCSVDialog.FileName, False);
        // loop through lines
        with DomDocument.ChildNodes.Item(0) do
        begin
          // check root node
          if (ExpandedName <> RootNodeName) then
            raise Exception.Create('Doesn''t seem to be a valid KeePass XML export.');
          // foreach entry
          for I := 0 to ChildNodes.Length - 1 do
            with ChildNodes.Item(I) do begin
              // check node name
              if (ExpandedName <> ItemNodeName) then Continue;
              // add item and read data
              with PWItemStore.Add do
              begin
                Title := ReadString(ChildNodes, 'title');
                Username := ReadString(ChildNodes, 'username');
                Password := ReadString(ChildNodes, 'password');
                URL := ReadString(ChildNodes, 'url');
                Notes := ReadString(ChildNodes, 'notes');
              end;
            end;
        end;
      finally
        DomImplementation.Free;
        XMLParser.Free;
        GUIUpdatePasswordList;
        Save;
      end;
    except
      on E: Exception do
      begin
        // TODO: show how many very actually imported
        ShowMessage(E.Message);
      end;
    end;
end;

procedure TMainForm.AddItemClick(Sender: TObject);
begin
  with TItemPropertiesForm.Create(Self) do
  begin
    EditMode := False;
    if ShowModal = mrOk then
      with PWItemStore.Add do begin
        Title := TitleEdit.Text;
        Username := UsernameEdit.Text;
        Password := PasswordEdit.Text;
        Notes := NotesMemo.Text;
        URL := URLEdit.Text;
        GUIUpdatePasswordList;
        Save;
      end;
    Free;
  end;
end;

procedure TMainForm.ApplyFilter;
var
  LookFor: string;
  CurNode: PVirtualNode;
  NodeData: PPasswordListNode;
begin
  LookFor := WideLowerCase(QuickSearchEdit.Text);
  PasswordList.BeginUpdate;
  try
    CurNode:= PasswordList.RootNode.FirstChild;
    while (CurNode <> nil) do
    begin
      NodeData := PasswordList.GetNodeData(CurNode);
      with NodeData.PWItem do
        PasswordList.IsVisible[CurNode] :=
          (LookFor = '') or  // no filter, show everything
          (Pos(LookFor, WideLowerCase(Title))>0) or
          (Pos(LookFor, WideLowerCase(Username))>0) or
          (Pos(LookFor, WideLowerCase(URL))>0) or
          (Pos(LookFor, WideLowerCase(Notes))>0) or
          ((Pos(LookFor, WideLowerCase(Password))>0) and IsPasswordColumnVisible);
      CurNode := PasswordList.GetNext(CurNode);
    end;
  finally
    PasswordList.EndUpdate;
    GUIUpdateStatusbar;
  end;
end;

procedure TMainForm.ClipboardClearTimerTimer(Sender: TObject);
begin
  Clipboard.Clear;
  ClipboardClearTimer.Enabled := False;
end;

procedure TMainForm.CloseStore;
begin
  PWItemStore.Clear;
  CurrentKey := '';
  CurrentStoreFile := '';
  GUIUpdatePasswordList;
end;

procedure TMainForm.ConfigurationItemClick(Sender: TObject);
begin
  with TConfigForm.Create(Self) do
    if ShowModal = mrOk then
    begin
    
    end;
end;

procedure TMainForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  // Vista "secret window" fixes  
  Params.ExStyle := Params.ExStyle and not WS_EX_TOOLWINDOW or
    WS_EX_APPWINDOW;
end;

procedure TMainForm.DeleteItemActionExecute(Sender: TObject);
var
  TaskDialog: TTaskDialog;
  I: Integer;
  SelectedNodes: TNodeArray;
  NodeData: PPasswordListNode;
begin
  TaskDialog := TTaskDialog.Create(Self);
  try
    TaskDialog.Title := 'Confirmation required';
    TaskDialog.Instruction := 'Are you sure you want to delete the selected items? '+
      'This operation cannot be undone.';
    TaskDialog.Icon := tiQuestion;
    if PasswordList.SelectedCount > 1 then
    begin
      TaskDialog.Footer := IntToStr(PasswordList.SelectedCount)+' items will be deleted.';
      TaskDialog.FooterIcon := tfiWarning;
    end;
    TaskDialog.CommonButtons := [cbYes, cbNo];
    if TaskDialog.Execute = ID_YES then
    begin
      PasswordList.BeginUpdate;
      try
        SelectedNodes := PasswordList.GetSortedSelection(True);
        for I := 0 to High(SelectedNodes) do
        begin
          NodeData := PasswordList.GetNodeData(SelectedNodes[I]);
          PWItemStore.Remove(NodeData^.PWItem);
          PasswordList.DeleteNode(SelectedNodes[I]);
        end;
      finally
        PasswordList.EndUpdate;
        GUIUpdateStatusbar;      
        Save;
      end;
    end;
  finally
    TaskDialog.Free;
  end;
end;

procedure TMainForm.DeleteItemActionUpdate(Sender: TObject);
begin
  DeleteItemAction.Enabled := PasswordList.SelectedCount > 0;
end;

procedure TMainForm.EditPropertiesActionExecute(Sender: TObject);
var
  PWItemToEdit: TPWItem;
  SelectedNodes: TNodeArray;
  NodeToEdit: PVirtualNode;
begin
  with TItemPropertiesForm.Create(Self) do
  begin
    EditMode := True;   
    with PasswordList do begin
      if (FocusedNode <> nil) and (IsVisible[FocusedNode]) then NodeToEdit := FocusedNode
      else begin
        SelectedNodes := GetSortedSelection(True);
        NodeToEdit := SelectedNodes[0];
      end;
      if NodeToEdit = nil then Exit;      
      PWItemToEdit := PPasswordListNode(GetNodeData(NodeToEdit)).PWItem;
    end;
    ApplyFromItem(PWItemToEdit);
    if ShowModal = mrOk then
    begin
      ApplyToItem(PWItemToEdit);
      Save;
    end;
    Free;
  end;  
end;

procedure TMainForm.EditPropertiesActionUpdate(Sender: TObject);
begin
  EditPropertiesAction.Enabled := (PasswordList.FocusedNode <> nil) or
    (PasswordList.SelectedCount > 0);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 SaveAppSettings;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Vista "Secret window" fixes
  ShowWindow(Application.Handle, SW_HIDE);
  SetWindowLong(Application.Handle, GWL_EXSTYLE,
    GetWindowLong(Application.Handle, GWL_EXSTYLE) and not WS_EX_APPWINDOW
      or WS_EX_TOOLWINDOW);
  ShowWindow(Application.Handle, SW_SHOW);

  // init Password list
  PasswordList.NodeDataSize := SizeOf(TPasswordListNode);

  // hide password column by default
  with PasswordList.Header.Columns[PasswordColumnIndex] do
    Options := Options - [coVisible];

  // init application settings
  Settings := TPatronusSettings.Create;
  LoadAppSettings;

  // create Password Store object
  PWItemStore := TPWItemStore.Create;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  PWItemStore.Free;
  Settings.Free;
end;

procedure TMainForm.GUIUpdatePasswordList;
var
  I: Integer;
  NewNode: PVirtualNode;
  NodeData: PPasswordListNode;
begin
  PasswordList.BeginUpdate;
  try
    PasswordList.Clear;
    for I := 0 to PWItemStore.Count - 1 do
    begin
      NewNode := PasswordList.AddChild(nil);
      NodeData := PasswordList.GetNodeData(NewNode);
      NodeData^.PWItem := PWItemStore.Items[I];
    end;
  finally
    PasswordList.EndUpdate;
  end;
  // most likely, we'll need to update the statusbar text too
  GUIUpdateStatusbar;
end;

procedure TMainForm.GUIUpdateStatusbar;
var
  TotalCount, VisibleCount: Integer;
begin
  // Update item count info
  TotalCount := PasswordList.RootNodeCount;
  VisibleCount := PasswordList.VisibleCount;
  if (VisibleCount < TotalCount) then
    ItemCountLabel.Caption := 'Filter active: '+IntToStr(VisibleCount)+' of '+IntToStr(TotalCount)+' items in store visible'
  else
    ItemCountLabel.Caption := IntToStr(TotalCount)+' items in store';
end;

function TMainForm.IsPasswordColumnVisible: Boolean;
begin
  Result := (coVisible in PasswordList.Header.Columns[PasswordColumnIndex].Options);
end;

function TMainForm.Load(Filename, Password: string): Boolean;
begin
  Result := True;
  try
    PWItemStore.LoadFromFile(Filename, Password);
  except
    on E: Exception do begin
      Result := False;
      LastLoadErrorMsg := E.Message;
    end;
  end;
end;

procedure TMainForm.LoadAppSettings;
var
  I: Integer;
begin
  AppStorage.ReadPersistent('', Settings, False);
  // passwords column visible?
  SetPasswordColumnVisibility(
    AppStorage.ReadBoolean('PasswordsVisible', IsPasswordColumnVisible));
  // column widths
  with PasswordList.Header do
  for I := 0 to Columns.Count - 1 do
  begin
    Columns[I].Position := AppStorage.ReadInteger('MainForm\Columns\Position'+IntToStr(I), Columns[I].Position);
    Columns[I].Width := AppStorage.ReadInteger('MainForm\Columns\Width'+IntToStr(I), Columns[I].Width);
  end;
end;

procedure TMainForm.PasswordListCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data1, Data2: PPasswordListNode;
begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  case Column of
    0: Result := CompareText(Data1.PWItem.Title, Data2.PWItem.Title);
    1: Result := CompareText(Data1.PWItem.Username, Data2.PWItem.Username);
    2: Result := 0;
    3: Result := CompareText(Data1.PWItem.URL, Data2.PWItem.URL);
  else
    Result := 0;
  end;
end;

procedure TMainForm.PasswordListDblClick(Sender: TObject);
begin
  if PasswordList.SelectedCount > 0 then
    EditPropertiesAction.Execute;
end;

procedure TMainForm.PasswordListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  NodeData: PPasswordListNode;
begin
  NodeData := PasswordList.GetNodeData(Node);
  case Column of
    0: CellText := NodeData.PWItem.Title;
    1: CellText := NodeData.PWItem.Username;
    2: begin
         if Sender.Selected[Node] then
           CellText := NodeData.PWItem.Password
         else
           CellText := '*****';
       end;
    3: CellText := NodeData.PWItem.URL;
  end;
end;

procedure TMainForm.PasswordListHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if Button = mbLeft then
  begin
    with Sender do
    begin
      // Never sort the password column
      if Column = PasswordColumnIndex then Exit;
      
      if SortColumn <> Column then
      begin
        SortColumn := Column;
        SortDirection := sdAscending;
      end
      else
      case SortDirection of
        sdAscending:
          SortDirection := sdDescending;
        sdDescending:
          SortDirection := sdAscending;
      end;
    end;
  end;
end;

procedure TMainForm.QuickSearchEditChange(Sender: TObject;
  const Text: WideString);
begin
  // Update edit text, so that filter won't get lost if focus changes
  // (which is the default behavious of the toolbar edit control)
  QuickSearchEdit.Text := Text;
  // Filter nodes in tree
  ApplyFilter;
end;

function TMainForm.RequestKey: Boolean;
var
  CanBreak: Boolean;
  FailedCount: Integer;
const
  MaxFailures = 3;
begin
  Result := False;

  // ask the user to open a store file / enter a key
  with TOpenStoreForm.Create(Self) do
  begin
    // if there is a default store, use it
    CurrentDefaultFile := Settings.DefaultStore;

    FailedCount := 0;
    repeat
      Key := '';
      // After three failures, user has to choose a new databaes file
      if FailedCount >= MaxFailures then
      begin
        Reset;
        FailedCount := 0;
      end;

      SetForegroundWindow(Application.Handle);
      if ShowModal = mrOk then
      begin
        if Mode = osmLoad then
        begin
          CanBreak := Load(SelectedStoreFile, Key);
          if not CanBreak then
          begin
            Inc(FailedCount);
            with TTaskDialog.Create(Self) do begin
              Title := 'Failed';
              Instruction := 'Failed to open database. Most likely, the key '+
                'you entered was incorrect.';
              Content := 'It is also possible, however, that '+
                'the file you tried to open is not a correct Patronus Store '+
                'file, or the choosen store is damaged.';
              ExpandedText := 'Error message was: "'+LastLoadErrorMsg+'"';
              Icon := tiError;
              Execute;
            end;
          end;
        end
        else begin
          PWItemStore.Clear;
          CanBreak := True;
        end;

        if CanBreak then
        begin
          // Store choosen store settings
          CurrentKey := Key;
          CurrentStoreFile := SelectedStoreFile;

          // If "make default" was checked, do so
          if MakeDefault then begin
            Settings.DefaultStore := SelectedStoreFile;
            SaveAppSettings;
          end;

          // Update GUI
          GUIUpdatePasswordList;

          // Show Form and leave loop
          Result := True;
          Break;
        end;
      end
      // User clicked exit/cancel
      else begin
        Result := False;
        Application.Terminate;  // force exit, just to make sure
        Break;
      end;
    until False;
    // Free form
    Free;
  end;
end;

procedure TMainForm.ResetClipboardClearTimer;
begin
  ClipboardClearTimer.Enabled := False;
  ClipboardClearTimer.Enabled := True;  
end;

procedure TMainForm.Save;
begin
  PWItemStore.SaveToFile(CurrentStoreFile, CurrentKey);
  // TODO: handle error
end;

procedure TMainForm.SaveAppSettings;
var
  I: Integer;
begin
  AppStorage.WritePersistent('', Settings, False);
  // passwords column visible?
  AppStorage.WriteBoolean('PasswordsVisible', IsPasswordColumnVisible);
  // column widths
  with PasswordList.Header do
  for I := 0 to Columns.Count - 1 do
  begin
    AppStorage.WriteInteger('MainForm\Columns\Width'+IntToStr(I), Columns[I].Width);
    AppStorage.WriteInteger('MainForm\Columns\Position'+IntToStr(I), Columns[I].Position);    
  end;
end;

procedure TMainForm.SetCurrentKey(const Value: string);
begin
  FCurrentKey := Value;
end;

procedure TMainForm.SetCurrentStoreFile(const Value: string);
begin
  FCurrentStoreFile := Value;
end;

procedure TMainForm.SetPasswordColumnVisibility(Show: Boolean);
begin
  with PasswordList.Header.Columns[PasswordColumnIndex] do
    if not Show then
      Options := Options - [coVisible]
    else
      Options := Options + [coVisible];
end;

procedure TMainForm.ShowPasswordsToggleActionExecute(Sender: TObject);
begin
  SetPasswordColumnVisibility(not ShowPasswordsToggleAction.Checked);
  // filter searches passwords, so update
  ApplyFilter;
end;

procedure TMainForm.ShowPasswordsToggleActionUpdate(Sender: TObject);
begin
  ShowPasswordsToggleAction.Checked := IsPasswordColumnVisible;
end;

procedure TMainForm.SpTBXItem5Click(Sender: TObject);
var
  NodeData: PPasswordListNode;
begin
  with PasswordList do
  begin
    if FocusedNode = nil then Exit;
    NodeData := GetNodeData(FocusedNode);
    Clipboard.AsText := NodeData.PWItem.Password;
    ResetClipboardClearTimer;
  end;
end;

procedure TMainForm.SpTBXItem6Click(Sender: TObject);
begin
  CloseStore;
  Hide;
  TryToShow;
end;

procedure TMainForm.TrayIconClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  TrayIcon.Active := False;
  TryToShow;
end;

procedure TMainForm.TryToShow;
begin
  if CurrentStoreFile = '' then
    if not RequestKey then
      Application.Terminate
    else begin
      Show;
      // only activate form storage the first time we successfully show the
      // form, or in some cases null values will be written.
      FormStorage.Active := True;
    end;
end;

procedure TMainForm.WMSyscommand(var Message: TWmSysCommand);
begin
  case (Message.CmdType and $FFF0) of
    SC_MINIMIZE:
    begin
      Hide; 
      CloseStore;
      TrayIcon.Active := True;
      Message.Result := 0;
    end;
    SC_RESTORE:
    begin
      ShowWindow(Handle, SW_RESTORE);
      Message.Result := 0;
    end;
  else
    inherited;
  end;
end;

end.
