program TodoApp;

uses
    SysUtils;

type TListEntity = record
    EntityTicked: boolean;
    EntityText: string;
    EntityDate: Date;
end;

type TList = record
    ListName: string;
    ListDescription: string;
    ListEntities: array of TListEntity;
end;

var userInput: string;
var lists: array of TList;

procedure ClearTerminal()
begin
    ClearScreen; // System.SysUtils.ClearScreen
end;

procedure ValidateUserInput(numberOfOptions: Integer): boolean
begin

    (*for i := 0 to Length(userInput) - 1 do
    begin*) // uncomment if there is a case with multiple digits
    if(userInput[i] >= '0' and userInput[i] <= '9') then
    begin
        if ()
        return true;
    end
    else
    begin
        return false;
    end;
    (*end;*)
end;

// Writes into Global "userInput"
procedure DrawOptions(options: array of string)
var i: Integer
begin
    WriteLn('\e[34m', 'Options:', '/e[0m');
    for i := 0 to Length(options) -1 do
    begin
        WriteLn('#', i, '     ', options[i]);
    end;
    WriteLn('Enter your selection: ');
    ReadLn(userInput);
end;

procedure ShowLists()
var
    i: Integer;
    options: array of string;
begin

    clearTerminal();

    WriteLn('These are your Lists:');

    for i := 0 to Length(lists) - 1 do
    begin
        WriteLn('#', i, '   ', lists[i].ListName)
    end;
    
    SetLength(options, 3);
    options[0] := 'View List';
    options[1] := 'second';
    options[2] := 'third';
    if (ValidateUserInput(DrawOption(options))) then
    begin
        case userInput of
        case '1':
        begin
        end
    end;


end;

procedure AddList()
var
    listName: string;
    listDescription: string;
    newList: TList;
begin

    ClearTerminal();

    WriteLn('What should be the name of the list?')
    ReadLn(listName);

    WriteLn('What should be the description of the list?')
    ReadLn(listDescription);

    newList.ListName := listName;
    newList.ListDescription := listDescription;

    SetLength(lists, Length(lists));
    lists[Length(lists)-1] := newList;

    ShowLists();
end;


procedure AddTaskToList(var list TList; listText string)
begin
    SetLength(List, Length(List))

end;

procedure DrawHomepage()
var options: array of string;
begin

    SetLength(options, 3)
    options[0] := 'View Lists';
    options[1] := 'Add a List';
    options[2] := 'Exit Program';
    DrawOptions(options)
    ReadLn(userInput);
    if (Length(userInput) <= 1) then
    begin
        case userInput of
            case 1:
            begin
                ShowLists();
            end
            case 2:
            begin
                AddList();
            end
            case 3:
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