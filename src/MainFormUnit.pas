unit MainFormUnit;

interface

uses
  Core,
  PWStoreModel,

  gnugettext,

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TB2Dock, TB2Toolbar, TBX, SpTBXItem, TB2ExtItems, SpTBXEditors,
  TB2Item, VirtualTrees, ImgList, PngImageList, XPMan, ActnList, TntDialogs,
  Menus, ExtCtrls, Clipbrd, JvComponentBase, JvTrayIcon, JvAppStorage, ComObj,
  JvAppRegistryStorage, ApplicationSettings, AppEvnts, JvFormPlacement,
  StdCtrls;

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
    OpenXMLDialog: TTntOpenDialog;
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
    QuickSearchEdit: TSpTBXEdit;
    QuickSearchEditItem: TTBControlItem;
    AutoLockTimer: TTimer;
    SaveXMLDialog: TTntSaveDialog;
    SpTBXItem7: TSpTBXItem;
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
    procedure QuickSearchEditChange(Sender: TObject);
    procedure AutoLockTimerTimer(Sender: TObject);
    procedure PasswordListMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StatusBarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MainToolbarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpTBXItem2Click(Sender: TObject);
    procedure SpTBXItem7Click(Sender: TObject);
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
    FLastStoreFile: string;
    procedure SetLastStoreFile(const Value: string);
    // TODO: encrypt this in memory
    property CurrentKey: string read FCurrentKey write SetCurrentKey;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMSyscommand(var Message: TWmSysCommand); message WM_SYSCOMMAND;
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
  protected
    function IsPasswordColumnVisible: Boolean;
    procedure SetPasswordColumnVisibility(Show: Boolean);
    procedure GUIUpdatePasswordList;
    procedure GUIUpdateStatusbar;
    procedure ResetClipboardClearTimer;
    procedure ResetAutoLockTimer;
    procedure ApplyFilter;
    procedure Save;
    function Load(Filename, Password: string): Boolean;
    procedure Lock(RetryShow: Boolean);
  public
    procedure LoadAppSettings;
    procedure SaveAppSettings;
    function RequestKey: Boolean;
    procedure TryToShow;
    procedure CloseStore;
  public
    property CurrentStoreFile: string read FCurrentStoreFile write SetCurrentStoreFile;
    property LastStoreFile: string read FLastStoreFile write SetLastStoreFile;
  end;

var
  MainForm: TMainForm;

const
  // The index of the password column in the list
  PasswordColumnIndex = 2;

implementation

uses
  Xdom_4_1, JclFileUtils, DateUtils,
  TaskDialog,
  AboutFormUnit, ConfigFormUnit, ItemPropertiesFormUnit, OpenStoreFormUnit,
  VistaCompat, Utilities;

{$R *.dfm}

procedure TMainForm.AboutItemClick(Sender: TObject);
begin
  with TAboutForm.Create(Self) do
  begin
    PopupParent := Self;
    ShowModal;
    Free;
  end;
end;

procedure TMainForm.AddFromCSVItemClick(Sender: TObject);
var
  XMLParser: TXmlToDomParser;
  DomImplementation: TDomImplementation;
  DomDocument: TDomDocument;
  I, C: Integer;
  Temp: string;

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
  C := 0;
  if OpenXmlDialog.Execute then
    try
      XMLParser := TXmlToDomParser.Create(nil);
      XMLParser.KeepEntityRefs := False;
      DomImplementation := TDomImplementation.Create(nil);
      XMLParser.DOMImpl := DomImplementation;
      try
        Screen.Cursor := crHourGlass;
        // open xml file
        DomDocument := XMLParser.ParseFile(OpenXmlDialog.FileName, False);
        // loop through lines
        with DomDocument.ChildNodes.Item(0) do
        begin
          // check root node
          if (ExpandedName <> RootNodeName) then
            raise Exception.Create(_('Doesn''t seem to be a valid KeePass XML export.'));
          // foreach entry
          for I := 0 to ChildNodes.Length - 1 do
            with ChildNodes.Item(I) do begin
              // check node name
              if (ExpandedName <> ItemNodeName) then Continue;
              // add item and read data
              with PWItemStore.Add do
              begin
                // at this point, we have added a new entry, so inc the counter
                Inc(C);
                // read the data of this entry
                // TODO: maybe we should not add an item when data is not
                // complete (like a title missing)
                Title := ReadString(ChildNodes, 'title');
                Username := ReadString(ChildNodes, 'username');
                Password := ReadString(ChildNodes, 'password');
                URL := ReadString(ChildNodes, 'url');
                try
                  Temp := ReadString(ChildNodes, 'creationtime');
                  CreationTime := EncodeDateTime(
                    // e.g. 2007-02-25T14:48:01
                    StrToInt(Copy(Temp,1,4)),  
                    StrToInt(Copy(Temp,6,2)),
                    StrToInt(Copy(Temp,9,2)),
                    StrToInt(Copy(Temp,12,2)),
                    StrToInt(Copy(Temp,15,2)),
                    StrToInt(Copy(Temp,18,2)),
                    0
                  );
                except
                  CreationTime := Now;
                end;
                Notes := ReadString(ChildNodes, 'notes');
              end;
            end;
        end;
      finally
        Screen.Cursor := crDefault;
        DomImplementation.Free;
        XMLParser.Free;
        GUIUpdatePasswordList;
        Save;
      end;
    except
      on E: Exception do
      begin
        with TTaskDialog.Create(Self) do begin
          DialogPosition := dpOwnerFormCenter;
          Title := _('Failed');
          Instruction := _('An error occured while trying to import the XML file.');
          if C > 0 then
            Content := Format(_('The error message was: "%s".'#13#10+
              'However, %d items were still sucessfully imported.'), [E.Message, C])
          else
            Content := Format(_('The error message was: "%s". No new items were added.'), [E.Message]);
          Icon := tiError;
          Execute;
        end;
      end;
    end;
end;

procedure TMainForm.AddItemClick(Sender: TObject);
begin
  with TItemPropertiesForm.Create(Self) do
  begin
    EditMode := False;
    PopupParent := Self;
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

procedure TMainForm.AutoLockTimerTimer(Sender: TObject);
begin
  // If the form currently is not visible, or not enabled,
  // there is nothing for us to do; reset the timer, however.
  if (not Visible) or (not IsWindowEnabled(Handle)) then begin
    AutoLockTimer.Tag := 0;
    Exit;
  end;

  // Tag property stores the number of seconds this has been running without
  // being reset.
  AutoLockTimer.Tag := AutoLockTimer.Tag + 1;

  // lock if we have not been used for a given amount of time
  if AutoLockTimer.Tag >= Settings.AutoLockAfter then
  begin
    Lock(False);
    AutoLockTimer.Tag := 0;
  end;
end;

procedure TMainForm.ClipboardClearTimerTimer(Sender: TObject);
begin
  Clipboard.Clear;
  ClipboardClearTimer.Enabled := False;
end;

procedure TMainForm.CloseStore;
begin
  PWItemStore.Close;
  CurrentKey := '';
  CurrentStoreFile := '';
  QuickSearchEdit.Text := '';
  GUIUpdatePasswordList;
end;

procedure TMainForm.ConfigurationItemClick(Sender: TObject);
begin
  with TConfigForm.Create(Self) do
  begin
    PopupParent := Self;
    if ShowModal = mrOk then
    begin

    end;
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
    TaskDialog.DialogPosition := dpOwnerFormCenter;
    TaskDialog.Title := _('Confirmation required');
    TaskDialog.Instruction := _('Are you sure you want to delete the selected items? '+
      'This operation cannot be undone.');
    TaskDialog.Icon := tiQuestion;
    if PasswordList.SelectedCount > 1 then
    begin
      TaskDialog.Footer := Format(_('%s items will be deleted.'), [IntToStr(PasswordList.SelectedCount)]);
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
    PopupParent := Self;
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

  // use font setting of os (mainly intended for new vista font)
  SetDesktopIconFonts(Self.Font);

  // localize
  TP_GlobalIgnoreClass(TJvAppStorage);
  TP_GlobalIgnoreClass(TJvFormStorage);
  TP_Ignore(OpenXMLDialog, 'DefaultExt');
  TP_Ignore(SaveXMLDialog, 'DefaultExt');
  TranslateComponent(Self);

  // initialize storage
  AppStorage.Root := 'Software\Patronus';
  FormStorage.AppStoragePath := 'MainForm';

  // init Password list
  PasswordList.NodeDataSize := SizeOf(TPasswordListNode);

  // hide password column by default
  with PasswordList.Header.Columns[PasswordColumnIndex] do
    Options := Options - [coVisible];

  // init application settings
  Settings := TPatronusSettings.Create;
  LoadAppSettings;

  // init some other stuff
  OpenXMLDialog.DefaultExt := 'xml';
  OpenXMLDialog.Filter := _(XMLFilter)+'|*.xml|'+_(AllFilesFilter)+'|*.*';
  SaveXMLDialog.DefaultExt := OpenXMLDialog.DefaultExt;
  SaveXMLDialog.Filter := OpenXMLDialog.Filter;

  // create Password Store object
  PWItemStore := TPWItemStore.Create;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  PWItemStore.Free;
  Settings.Free;
end;

procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // Note: KeyPreview = True
  
  // We are active
  ResetAutoLockTimer;
end;

procedure TMainForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  // We are active
  ResetAutoLockTimer;
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
    ItemCountLabel.Caption := Format(_('%s items in store'), [IntToStr(TotalCount)]);
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
  TempDirection: TSortDirection;
begin
  AppStorage.ReadPersistent('', Settings, False);
  // passwords column visible?
  SetPasswordColumnVisibility(
    AppStorage.ReadBoolean('PasswordsVisible', IsPasswordColumnVisible));
  // sort options
  PasswordList.Header.SortColumn := AppStorage.ReadInteger('MainForm\ListSortColumn', -1);
  TempDirection := sdAscending;
  AppStorage.ReadEnumeration('MainForm\ListSortDirection', TypeInfo(TSortDirection), TempDirection, TempDirection);
  PasswordList.Header.SortDirection := TempDirection;
  // column widths
  with PasswordList.Header do
  for I := 0 to Columns.Count - 1 do
  begin
    Columns[I].Position := AppStorage.ReadInteger('MainForm\Columns\Position'+IntToStr(I), Columns[I].Position);
    Columns[I].Width := AppStorage.ReadInteger('MainForm\Columns\Width'+IntToStr(I), Columns[I].Width);
  end;
end;

procedure TMainForm.Lock(RetryShow: Boolean);
begin
  // Never lock if there is an active modal form; second condition handles
  // windows dialogs as well.
  if (fsModal in Screen.ActiveForm.FormState) or
     (not IsWindowEnabled(Self.Handle)) then Exit;

  // Hide
  Hide;
  // Close store, remove passwords etc. from memory
  CloseStore;

  // Determine what to do next - either query for key, or move to tray
  if RetryShow then
    TryToShow
  else
    TrayIcon.Active := True;
end;

procedure TMainForm.MainToolbarMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  // We are active
  ResetAutoLockTimer;
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
      else
        SortDirection := sdAscending;
      end;
    end;
  end;
end;

procedure TMainForm.PasswordListMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  // We are active
  ResetAutoLockTimer;
end;

procedure TMainForm.QuickSearchEditChange(Sender: TObject);
begin
  // Filter nodes in tree
  ApplyFilter;

  // We are active
  ResetAutoLockTimer;
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
  OpenStoreForm := TOpenStoreForm.Create(Self, osmLoad);
  with OpenStoreForm do
  begin
    // if there is a default store, use it
    CurrentDefaultFile := Settings.DefaultStore;
    // we we already have a store open, pre-select that one instead of the default
    if LastStoreFile <> '' then
      SelectedStoreFile := LastStoreFile;

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
      PopupParent := Self;
      if ShowModal = mrOk then
      begin
        if Mode = osmLoad then
        begin
          CanBreak := Load(SelectedStoreFile, Key);
          if not CanBreak then
          begin
            Inc(FailedCount);
            with TTaskDialog.Create(OpenStoreForm) do begin
              DialogPosition := dpScreenCenter;
              Title := _('Failed');
              Instruction := _('Failed to open database. Most likely, the key '+
                'you entered was incorrect.');
              Content := _('It is also possible, however, that '+
                'the file you tried to open is not a correct Patronus Store '+
                'file, or the chosen store is damaged.');
              ExpandedText := Format(_('Error message was: "%s"'), [LastLoadErrorMsg]);
              Icon := tiError;
              Execute;
            end;
          end;
        end
        // Mode = osmCreate/osmCreateConfirm
        else begin
          PWItemStore.Clear;
          PWItemStore.SaveToFile(SelectedStoreFile, Key);  // create initial empty store
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
          ApplyFilter;

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

procedure TMainForm.ResetAutoLockTimer;
begin
  AutoLockTimer.Tag := 0;
end;

procedure TMainForm.ResetClipboardClearTimer;
begin
  ClipboardClearTimer.Enabled := False;
  ClipboardClearTimer.Enabled := True;  
end;

procedure TMainForm.Save;
begin
  try
    PWItemStore.SaveToFile(CurrentStoreFile, CurrentKey);
  except
    on E: Exception do
      with TTaskDialog.Create(Self) do begin
        DialogPosition := dpOwnerFormCenter;
        Title := _('Error');
        Instruction := _('An error occured while trying to save the password store.');
          Content := _('This is not good at all. Your last change likely has not been '+
          'written to disk.'#13#10#13#10'If you''re afraid of losing data, you probably should '+
          'exit Patronus now and fix the problem before you continue using the current store.');
        ExpandedText := Format(_('Error message was: "%s"'), [E.Message]);
        Icon := tiError;
        Execute;
      end;
  end;
end;

procedure TMainForm.SaveAppSettings;
var
  I: Integer;
  TempDirection: TSortDirection;
begin
  AppStorage.WritePersistent('', Settings, False);
  // passwords column visible?
  AppStorage.WriteBoolean('PasswordsVisible', IsPasswordColumnVisible);
  // sort options
  AppStorage.WriteInteger('MainForm\ListSortColumn', PasswordList.Header.SortColumn);
  TempDirection := PasswordList.Header.SortDirection;
  AppStorage.WriteEnumeration('MainForm\ListSortDirection', TypeInfo(TSortDirection), TempDirection);
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
var
  CaptionFilename: string;
const
  DefaultExt = '.patronus';
begin
  // Always remember the previous value
  if Value <> FCurrentStoreFile then
  begin
    LastStoreFile := FCurrentStoreFile;
    FCurrentStoreFile := Value;
    QuickSearchEdit.Text := '';
  end;
  // Update form caption;  show filename of current store, and
  // exclude the file extension if it's the default one.
  CaptionFilename := ExtractFileName(Value);
  if ExtractFileExt(CaptionFilename) = DefaultExt then
    CaptionFilename := PathRemoveExtension(CaptionFilename);
  Caption := AppShortName + ' ['+CaptionFilename+']';
end;

procedure TMainForm.SetLastStoreFile(const Value: string);
begin
  FLastStoreFile := Value;
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

procedure TMainForm.SpTBXItem2Click(Sender: TObject);
var
  OutStream: TFileStream;
  Temp1, Temp2: string;
  I: Integer;
  XMLWriter: TDomToXmlParser;
  DomImplementation: TDomImplementation;
  Document: TDomDocument;
  NewElem: TDomElement;

  function GenerateUUID: string;
  var
    I: Integer;
  begin
    Result := Lowercase(CreateClassID);
    for I := Length(Result) downto 1 do
      if not (Result[I] in ['a'..'z','0'..'9']) then
        Delete(Result, I, 1);
  end;

  function AddNode(Parent: TDomElement; TagName, Value: WideString): TDomElement;
  begin
    Result := TDomElement.Create(Document, TagName);
    Parent.AppendChild(Result);
    // add text node
    Result.AppendChild(TDomText.Create(Document));
    Result.ChildNodes.Item(0).NodeValue := Value;
  end;

begin
  if SaveXMLDialog.Execute then
  begin
    OutStream := TFileStream.Create(SaveXMLDialog.FileName, fmCreate);
    XMLWriter := TDomToXmlParser.Create(nil);
    DomImplementation := TDomImplementation.Create(nil);
    XMLWriter.DOMImpl := DomImplementation;
    Document := TDomDocument.Create(DomImplementation);
    Screen.Cursor := crHourGlass;
    try
      NewElem := TDomElement.Create(Document, 'pwlist');
      Document.AppendChild(NewElem);
      for I := 0 to PWItemStore.Count - 1 do
      begin
        NewElem := TDomElement.Create(Document, 'pwentry');
        Document.FindFirstChildElement.AppendChild(NewElem);

        AddNode(NewElem, 'group', 'Patronus');
        AddNode(NewElem, 'title', PWItemStore.Items[I].Title);
        AddNode(NewElem, 'username', PWItemStore.Items[I].Username);
        AddNode(NewElem, 'password', PWItemStore.Items[I].Password);
        AddNode(NewElem, 'url', PWItemStore.Items[I].URL);
        AddNode(NewElem, 'notes', PWItemStore.Items[I].Notes);
        DateTimeToString(Temp1, 'yyyy-mm-dd', PWItemStore.Items[I].CreationTime);
        DateTimeToString(Temp2, 'hh:nn:ss', PWItemStore.Items[I].CreationTime);
        AddNode(NewElem, 'creationtime', Temp1+'T'+Temp2);
        AddNode(NewElem, 'uuid', GenerateUUID);
      end;

      // write
      XMLWriter.WriteToStream(Document, 'UTF-8', OutStream);
    finally
      Screen.Cursor := crDefault;
      OutStream.Free;
      Document.Free;
      XMLWriter.Free;
      DomImplementation.Free;
    end;
  end;
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
  Lock(True);
end;

procedure TMainForm.SpTBXItem7Click(Sender: TObject);
begin
  // ask the user to open a store file / enter a key
  OpenStoreForm := TOpenStoreForm.Create(Self, osmChangeKey);
  with OpenStoreForm do
  begin
    try
      // Init dialog
      SelectedStoreFile := CurrentStoreFile;
      Mode := osmChangeKey;

      // show
      if ShowModal = mrOk then begin
        CurrentKey := Key;
        Save;
      end;
    finally          
      Free;
    end;
  end;
end;

procedure TMainForm.StatusBarMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  // We are active
  ResetAutoLockTimer;
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
      // only activate form storage the first time we successfully show the
      // form, or in some cases null values will be written.
      FormStorage.Active := True;
      
      Show;
    end;
end;

procedure TMainForm.WMActivate(var Message: TWMActivate);
begin
  // Vista secret window fix
  if (Message.Active = WA_ACTIVE) and not IsWindowEnabled(Handle) then
  begin
    SetActiveWindow(Application.Handle);
    Message.Result := 0;
  end else
    inherited;
end;

procedure TMainForm.WMSyscommand(var Message: TWmSysCommand);
begin
  case (Message.CmdType and $FFF0) of
    SC_MINIMIZE:
    begin
      Lock(False);
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
