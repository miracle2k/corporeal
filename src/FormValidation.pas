unit FormValidation;

// Currently supports these controls (and descendents):
//   * TCustomEdit
//
// To add support for new controls, search for {NEW-CONTROL-SUPPORT-MODIFY}
// in this file to find the places where stuff has to be added.

interface

uses
  Classes, Controls, SysUtils, StdCtrls, Graphics;

type
  // Identifiers for a number of common, frequently used validations.
  TValidationRuleType = (
    dvrCustom,            // custom rule check via callback
    dvrNotEmpty,          // field not empty
    dvrNotEmptyTrim,      // field still not empty after it was been trimmed
    dvrInteger
  );

const
  // Default error messages for common validation rules (can be replaced
  // by custom once anytime, of course)
  DefaultValidationTypesMessages: array[TValidationRuleType] of string =
  (
     '',
     'Please enter a value',
     'Please enter a non-whitepace value',
     'Please enter a number'
  );


type
  // Callback to define your own rules
  TCustomRuleProc = function(Value: string): Boolean of object;

  // A couple of classes we need to escalate visibility of some
  // properties of some controls, so we can support their descendents as well,
  // e.g. TCustomEdit.Color is not public, while TEdit.Color is. Because we
  // want to support TMyOwnCustomEditDescendent as well, we can't use a
  // TEdit typecast to access the color.
  TCustomEditAccessHack = class(TCustomEdit)
  public
    property Color;
    property Font;
  end;

  // Represents a single rule we have to check
  TValidationRule = class
  private
    FValidationProc: TCustomRuleProc;
    FType: TValidationRuleType;
    FControl: TControl;
    FEnabled: Boolean;
    FMessage: string;
    function GetMessage: string;
    procedure SetMessage(const Value: string);
    procedure SetEnabled(const Value: Boolean);
    procedure SetControl(const Value: TControl);
    procedure SetType(const Value: TValidationRuleType);
    procedure SetValidationProc(const Value: TCustomRuleProc);
  private
    // try to memorize the old style of a control before we make our changes,
    // so we can reset at any time
    FOldBgColor: TColor;
    FOldFgColor: TColor;
  protected
    procedure UpdateControlStyle(Error: Boolean); virtual;
  protected
    // Default validation callbacks
    function ValidationProcNotEmpty(Value: string): Boolean;
    function ValidationProcNotEmptyTrim(Value: string): Boolean;    
  public
    constructor Create; virtual;
  public
    function Validate: Boolean; virtual;
  public
    property &Type: TValidationRuleType read FType write SetType;
    property ValidationProc: TCustomRuleProc read FValidationProc write SetValidationProc;
    property Control: TControl read FControl write SetControl;
    property Message: string read GetMessage write SetMessage;
    property Enabled: Boolean read FEnabled write SetEnabled;
  end;

  // Forward declaration for use in events
  TFormValidator = class;

  // Called whenever a rule has been validated
  TValidationResultEvent = procedure(Sender: TFormValidator;
    Rule: TValidationRule; Result: Boolean) of object;

  // Main validator class
  TFormValidator = class
  private
    FRules: TList;
    FErrorBgColor: TColor;
    FErrorFgColor: TColor;
    FOnValidationResult: TValidationResultEvent;
    FFirstFailedRule: TValidationRule;
    procedure SetFirstFailedRule(const Value: TValidationRule);
    procedure SetOnValidationResult(const Value: TValidationResultEvent);
    procedure SetErrorBgColor(const Value: TColor);
    procedure SetErrorFgColor(const Value: TColor);
    function GetRuleCount: Integer;
    function GetRules(Index: Integer): TValidationRule;
    procedure SetRules(Index: Integer; const Value: TValidationRule);
  protected
    procedure CheckControlSupport(AControl: TControl); virtual;
    function ControlSupportsFocus(AControl: TControl): Boolean; virtual;
    function AttemptToSetFocus(AControl: TControl): Boolean; virtual;
    function AddNewRuleObject(AControl: TControl; Msg: string): TValidationRule; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  public
    procedure Clear;
    function AddRule(AControl: TControl; Rule: TValidationRuleType;
      Msg: string = ''): TValidationRule; overload;
    function AddRule(AControl: TControl; RuleProc: TCustomRuleProc;
      Msg: string = ''): TValidationRule; overload;
    function ValidateAll: Boolean;
  public
    property Rules[Index: Integer]: TValidationRule read GetRules write SetRules;
    property RuleCount: Integer read GetRuleCount;
    property FirstFailedRule: TValidationRule read FFirstFailedRule write SetFirstFailedRule;
    property ErrorBgColor: TColor read FErrorBgColor write SetErrorBgColor;
    property ErrorFgColor: TColor read FErrorFgColor write SetErrorFgColor;
    property OnValidationResult: TValidationResultEvent read FOnValidationResult write SetOnValidationResult;
  end;

implementation

{ TFormValidator }

function TFormValidator.AddRule(AControl: TControl;
  Rule: TValidationRuleType; Msg: string): TValidationRule;
begin
  CheckControlSupport(AControl);
  Result := AddNewRuleObject(AControl, Msg);
  Result.&Type := Rule;
end;

function TFormValidator.AddRule(AControl: TControl;
  RuleProc: TCustomRuleProc; Msg: string): TValidationRule;
begin
  CheckControlSupport(AControl);
  Result := AddNewRuleObject(AControl, Msg);
  Result.&Type := dvrCustom;
  Result.ValidationProc := RuleProc;
end;

function TFormValidator.AttemptToSetFocus(AControl: TControl): Boolean;
begin
  Result := False;
  if AControl is TWinControl then
  begin
    TWinControl(AControl).SetFocus;
    Result := True;
  end;
end;

procedure TFormValidator.CheckControlSupport(AControl: TControl);
var
  Supported: Boolean;
begin
  // {NEW-CONTROL-SUPPORT-MODIFY}
  Supported := (AControl is TCustomEdit) or (AControl is TCustomMemo);
  if not Supported then
    raise Exception.Create(AControl.ClassName+' is not supported by the Form Validator');
end;

procedure TFormValidator.Clear;
var
  I: Integer;
begin
  for I := 0 to FRules.Count - 1 do
    TValidationRule(FRules[I]).Free;
  FRules.Clear;
end;

function TFormValidator.ControlSupportsFocus(AControl: TControl): Boolean;
begin
  Result := AControl is TWinControl;
end;

constructor TFormValidator.Create;
begin
  FRules := TList.Create;
  FFirstFailedRule := nil;
  // default style
  ErrorBgColor := clRed;
  ErrorFgColor := clWhite;
end;

function TFormValidator.AddNewRuleObject(AControl: TControl; Msg: string): TValidationRule;
begin
  Result := TValidationRule.Create;
  Result.Control := AControl;
  Result.Message := Msg;
  FRules.Add(Result);
end;

destructor TFormValidator.Destroy;
begin
  Clear;
  FRules.Free;
  inherited;
end;

function TFormValidator.GetRuleCount: Integer;
begin
  Result := FRules.Count;
end;

function TFormValidator.GetRules(Index: Integer): TValidationRule;
begin
  Result := FRules[Index];
end;

procedure TFormValidator.SetErrorBgColor(const Value: TColor);
begin
  FErrorBgColor := Value;
end;

procedure TFormValidator.SetErrorFgColor(const Value: TColor);
begin
  FErrorFgColor := Value;
end;

procedure TFormValidator.SetFirstFailedRule(const Value: TValidationRule);
begin
  FFirstFailedRule := Value;
end;

procedure TFormValidator.SetOnValidationResult(
  const Value: TValidationResultEvent);
begin
  FOnValidationResult := Value;
end;

procedure TFormValidator.SetRules(Index: Integer; const Value: TValidationRule);
begin
  FRules[Index] := Value;
end;

function TFormValidator.ValidateAll: Boolean;
var
  I: Integer;
  FocusControl: TControl;
  ValidationResult: Boolean;
begin
  Result := True;
  FirstFailedRule := nil;
  FocusControl := nil;
  for I := 0 to RuleCount - 1 do
  begin
    ValidationResult := Rules[I].Validate;

    if Assigned(OnValidationResult) then
      FOnValidationResult(Self, Rules[I], ValidationResult);
      
    if not ValidationResult then begin
      Result := False;
      Rules[I].UpdateControlStyle(True);
      // if this is the first error, we will try to focus that control, if possible
      if (FocusControl = nil) and ControlSupportsFocus(Rules[I].Control) then
        FocusControl := Rules[I].Control;
      // if this is the first error, memorize it, so user can later access it
      if FirstFailedRule = nil then FirstFailedRule := Rules[I];      
    end
    else
      Rules[I].UpdateControlStyle(False);
  end;
  // update focus
  if FocusControl <> nil then
    AttemptToSetFocus(FocusControl);
end;

{ TValidationRule }

constructor TValidationRule.Create;
begin
  FType := dvrCustom;
  FValidationProc := nil;
  FEnabled := True;
end;

function TValidationRule.GetMessage: string;
begin
  if (FMessage = '') then
     Result := DefaultValidationTypesMessages[&Type]
  else
    Result := FMessage;
end;

procedure TValidationRule.SetControl(const Value: TControl);
begin
  FControl := Value;
  // try to read the current style of the control
  // {NEW-CONTROL-SUPPORT-MODIFY}
  if FControl is TCustomEdit then
  begin
    FOldBgColor := TCustomEditAccessHack(Value).Color;
    FOldFgColor := TCustomEditAccessHack(Value).Font.Color;
  end
  // default fallback
  else begin
    FOldBgColor := clWindow;
    FOldFgColor := clWindowText;
  end;
end;

procedure TValidationRule.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TValidationRule.SetMessage(const Value: string);
begin
  FMessage := Value;
end;

procedure TValidationRule.SetType(const Value: TValidationRuleType);
begin
  FType := Value;
end;

procedure TValidationRule.SetValidationProc(const Value: TCustomRuleProc);
begin
  FValidationProc := Value;
end;

procedure TValidationRule.UpdateControlStyle(Error: Boolean);
begin
  // {NEW-CONTROL-SUPPORT-MODIFY}
  if Control is TCustomEdit then
  begin
    if Error then begin
      TCustomEditAccessHack(Control).Color := clRed;
      TCustomEditAccessHack(Control).Font.Color := clWhite;
    end else begin
      TCustomEditAccessHack(Control).Color := FOldBgColor;
      TCustomEditAccessHack(Control).Font.Color := FOldFgColor;
    end;
  end;
end;

function TValidationRule.Validate: Boolean;
var
  ValProcToUse: TCustomRuleProc;
  CheckValStr: string;
begin
  // if rule is dislabed, always return true
  if not Enabled then Result := True
  else begin
    // decide which validation procedure to call
    case &Type of
      dvrCustom: ValProcToUse := ValidationProc;
      dvrNotEmpty: ValProcToUse := ValidationProcNotEmpty;
      dvrNotEmptyTrim: ValProcToUse := ValidationProcNotEmptyTrim;
      else ValProcToUse := nil;
    end;
    // decide which value to check
    // {NEW-CONTROL-SUPPORT-MODIFY}
    CheckValStr := '';
    if Control is TCustomEdit then CheckValStr := TCustomEdit(Control).Text;
    // validate and return
    if @ValProcToUse <> nil then
      Result := ValProcToUse(CheckValStr)
    else
      Result := True;
  end;
end;

function TValidationRule.ValidationProcNotEmpty(Value: string): Boolean;
begin
  Result := Value <> '';
end;

function TValidationRule.ValidationProcNotEmptyTrim(Value: string): Boolean;
begin
  Result := Trim(Value) <> '';
end;

end.
