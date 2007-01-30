unit MainFormUnit;

interface

uses
  PWStoreModel,

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TB2Dock, TB2Toolbar, TBX, SpTBXItem, TB2ExtItems, SpTBXEditors,
  TB2Item, VirtualTrees, ImgList, PngImageList, XPMan, ActnList, TntDialogs,
  Menus;

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
  private
    PWItemStore: TPWItemStore;
  protected
    function IsPasswordColumnVisible: Boolean;
    procedure GUIUpdatePasswordList;
    procedure GUIUpdateStatusbar;
    procedure ApplyFilter;
  end;

var
  MainForm: TMainForm;

const
  // The index of the password column in the list
  PasswordColumnIndex = 2;

implementation

uses
  TaskDialog,
  ItemPropertiesFormUnit,
  CSVParser;

{$R *.dfm}

procedure TMainForm.AddFromCSVItemClick(Sender: TObject);
var
  CSVFile: TCSVParser;
  I: Integer;
begin
  if OpenCSVDialog.Execute then
    try
      CSVFile := TCSVParser.Create;
      CSVFile.RequireFields := 5;
      try
        // open csv file
        CSVFile.LoadAndParseFile(OpenCSVDialog.FileName);
        // loop through lines
        for I := 0 to CSVFile.ItemCount - 1 do
          with PWItemStore.Add do
          begin
            Title := CSVFile.Items[I].Fields[0];
            Username := CSVFile.Items[I].Fields[1];
            Password := CSVFile.Items[I].Fields[2];
            URL := CSVFile.Items[I].Fields[3];
            Notes := CSVFile.Items[I].Fields[4];
          end;
      finally
        CSVFile.Free;
        GUIUpdatePasswordList;
      end;
    except
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
      end;
    Free;
  end;
end;

procedure TMainForm.ApplyFilter;
var
  LookFor: string;
  CurNode: PVirtualNode;
begin
  LookFor := WideLowerCase(QuickSearchEdit.Text);
  PasswordList.BeginUpdate;
  try
    CurNode:= PasswordList.RootNode.FirstChild;
    while (CurNode <> nil) do
    begin
      with PWItemStore.Items[CurNode.Index] do
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
    GUIUpdatePasswordList;
  end;
end;

procedure TMainForm.DeleteItemActionExecute(Sender: TObject);
var
  TaskDialog: TTaskDialog;
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
    if TaskDialog.Execute = 6 then begin
      PasswordList.DeleteSelectedNodes;
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
begin
  with TItemPropertiesForm.Create(Self) do
  begin
    EditMode := True;
    if ShowModal = mrOk then
      with PWItemStore.Add do begin
        Title := TitleEdit.Text;
        Username := UsernameEdit.Text;
        Password := PasswordEdit.Text;
        Notes := NotesMemo.Text;
        URL := URLEdit.Text;
        GUIUpdatePasswordList;
      end;
    Free;
  end;  
end;

procedure TMainForm.EditPropertiesActionUpdate(Sender: TObject);
begin
  EditPropertiesAction.Enabled := PasswordList.SelectedCount > 0;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  PasswordList.NodeDataSize := SizeOf(TPasswordListNode);
  PWItemStore := TPWItemStore.Create;
  GUIUpdatePasswordList;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  PWItemStore.Free;
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
          SortColumn := NoColumn;
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

procedure TMainForm.ShowPasswordsToggleActionExecute(Sender: TObject);
begin
  with PasswordList.Header.Columns[PasswordColumnIndex] do
    if ShowPasswordsToggleAction.Checked then
      Options := Options - [coVisible]
    else
      Options := Options + [coVisible];
  ApplyFilter;
end;

procedure TMainForm.ShowPasswordsToggleActionUpdate(Sender: TObject);
begin
  ShowPasswordsToggleAction.Checked := IsPasswordColumnVisible;
end;

end.
