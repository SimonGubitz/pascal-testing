program TodoApp;

uses
    SysUtils, Crt;

type TListEntity = record
    EntityTicked: boolean;
    EntityText: string;
    EntityDate: TDateTime;
end;

type TList = record
    ListName: string;
    ListDescription: string;
    ListEntities: array of TListEntity;
end;

var userInput: string;
var lists: array of TList;

// procedure ClearTerminal();
// begin
//     ClearScreen; // System.SysUtils.ClearScreen
// end;

function ValidateUserInput(numberOfOptions: Integer): boolean;
begin

    (*for i := 0 to Length(userInput) - 1 do
    begin*) // uncomment if there is a case with multiple digits
    if (userInput[1] >= '0') and (userInput[1] <= '9') then
    begin
        Result := true;
    end
    else
    begin
        Result := false;
    end;
end;

// Writes into Global "userInput"
procedure DrawOptions(options: array of string);
var
    i: Integer;
begin
    WriteLn('\e[34m', 'Options:', '/e[0m');
    for i := 0 to Length(options) -1 do
    begin
        WriteLn('#', i, '     ', options[i]);
    end;
    WriteLn('Enter your selection: ');
    ReadLn(userInput);
end;

procedure ShowLists();
var
    i: Integer;
    options: array of string;
begin
    // clearTerminal();

    WriteLn('These are your Lists:');

    for i := 0 to Length(lists) - 1 do
    begin
        WriteLn('#', i, '   ', lists[i].ListName)
    end;

    SetLength(options, 3);
    options[0] := 'View List';
    options[1] := 'second';
    options[2] := 'third';

    DrawOptions(options);
    if ValidateUserInput(Length(options)-1) then
    begin
        case userInput[1] of
            '1':
            begin
                // do something here
                WriteLn('case 1 selected');
            end;
        end;
    end;
end;

procedure AddList();
var
    listName: string;
    listDescription: string;
    newList: TList;
begin

    // ClearTerminal();

    WriteLn('What should be the name of the list?');
    ReadLn(listName);

    WriteLn('What should be the description of the list?');
    ReadLn(listDescription);

    newList.ListName := listName;
    newList.ListDescription := listDescription;

    SetLength(lists, Length(lists));
    lists[Length(lists)-1] := newList;

    ShowLists();
end;


procedure AddTaskToList(var list: TList; listText: string);
begin
    // List is not an array
    SetLength(list.ListEntities, Length(List.ListEntities));
end;

procedure DrawHomepage();
var
    options: array of string;
begin

    SetLength(options, 3);
    options[0] := 'View Lists';
    options[1] := 'Add a List';
    options[2] := 'Exit Program';
    DrawOptions(options);
    ReadLn(userInput);
    if (Length(userInput) <= 1) then
    begin
        case userInput[1] of
            '1':
            begin
                ShowLists();
            end;
            '2':
            begin
                AddList();
            end;
            '3':
            begin
                exit;
            end;
            else
                WriteLn('Input outside the scope of selection possibilities.');
            end;
    end
    else
    begin
        WriteLn('Invalid Input');
        DrawHomepage();
    end;

end;



begin

    DrawHomepage();

end.