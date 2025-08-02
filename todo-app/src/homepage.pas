unit Homepage;

interface

uses
    Types, Globals, Inputs, Utils;

procedure InputDrawHomepage;



implementation

procedure InputDrawHomepage;
var
    options: array of string;
begin

    ClearTerminal;

    SetLength(options, 3);
    options[0] := 'View Lists';
    options[1] := 'Add a List';
    options[2] := 'Exit Program';
    DrawOptions(options);
    if (Length(UserInput) <= 1) then
    begin
        case UserInput[1] of
            '1': InputShowLists;
            '2': InputAddList;
            '3': exit;
            else
            begin
                WriteLn(#27'[38;5;88m' + 'That was an invalid input.' + #27'[0m');
                DrawEmptyLines(1);
                WriteLn('Press any button to go back home...');
            end;
        end;
    end
    else
    begin
        WriteLn(#27'[38;5;88m' + 'That was an invalid input.' + #27'[0m');
        InputDrawHomepage;
    end;

end;


end.