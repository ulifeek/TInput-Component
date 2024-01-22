{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit RIEvent;

{$warn 5023 off : no warning about unused units}
interface

uses
  ReadDevInput, ReadDevInput_ContourShuttlePro, ReadDevInput_GamepadSNES, 
  ReadDevInput_VecPedal, ReadDevInputComp_Mouse, ReadDevInputComp_Keyboard, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ReadDevInput', @ReadDevInput.Register);
  RegisterUnit('ReadDevInput_ContourShuttlePro', 
    @ReadDevInput_ContourShuttlePro.Register);
  RegisterUnit('ReadDevInput_GamepadSNES', @ReadDevInput_GamepadSNES.Register);
  RegisterUnit('ReadDevInput_VecPedal', @ReadDevInput_VecPedal.Register);
  RegisterUnit('ReadDevInputComp_Mouse', @ReadDevInputComp_Mouse.Register);
  RegisterUnit('ReadDevInputComp_Keyboard', @ReadDevInputComp_Keyboard.Register
    );
end;

initialization
  RegisterPackage('RIEvent', @Register);
end.
