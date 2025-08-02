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



procedure InputDrawHomepage; forward;

procedure ClearTerminal();
begin
    Write(#27 + '[2J' + #27 + '[H');
end;

procedure DrawEmptyLines(AmountLines: Integer);
var
    i: Integer;
begin
    for i := 0 to AmountLines -1 do
    begin
        WriteLn('');
    end;
end;

function ValidateUserInput(NumberOfOptions: Integer): Boolean;
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
procedure DrawOptions(Options: array of string);
var
    i: Integer;
begin
    WriteLn(#27 + '[34m', 'Options:' +  #27'[0m');
    for i := 0 to Length(options) -1 do
    begin
        WriteLn('# ', i +1, '     ', options[i]);
    end;
    Write('Enter your selection: ');
    ReadLn(userInput);
end;

procedure ShowLists;
var
    i: Integer;
begin

    WriteLn('These are your Lists:');

    if Length(lists) >= 1 then
    begin
        for i := 0 to Length(lists) - 1 do
        begin
            WriteLn('# ', i + 1, '   ', lists[i].ListName, '    ', lists[i].ListDescription);
        end;
    end
    else
    begin
        WriteLn(#27'[38;5;88m' + 'You currently have no lists.' + #27'[0m');
    end;
end;

procedure InputShowList;
begin

    ClearTerminal;
    ShowLists;

    Write('Which List do you want to view? Enter index: ');
    ReadLn(userInput);

    if (userInput >= '0') and (userInput <= '9') then
    begin
    end
    else
    begin
        ClearTerminal;
        WriteLn(#27'[38;5;88m' + 'That was an invalid input.' + #27'[0m');
        DrawEmptyLines(1);
        WriteLn('Press any button to go back home...');
        ReadLn;
        InputDrawHomepage;
    end;

    ClearTerminal;

end;

procedure InputShowLists;
var
    options: array of string;
begin

    ClearTerminal;

    ShowLists;

    SetLength(options, 2);
    options[0] := 'View List';
    options[1] := 'Go back Home';

    DrawEmptyLines(2);

    DrawOptions(options);
    if ValidateUserInput(Length(options)-1) then
    begin
        case userInput[1] of
            '1': InputShowList;
            '2': InputDrawHomepage;
            else
            begin
                ClearTerminal;
                WriteLn(#27'[38;5;88m' + 'That was an invalid input.' + #27'[0m');
                DrawEmptyLines(1);
                WriteLn('Press any button to go back home...');
                ReadLn;
                InputDrawHomepage;
            end;
        end;
    end;
end;

procedure AddList(newList: TList);
begin
    SetLength(lists, Length(lists) + 1);
    lists[Length(lists)-1] := newList;
end;

procedure InputAddList;
var
    listName: string;
    listDescription: string;
    newList: TList;
    options: array of string;
begin

    ClearTerminal;

    WriteLn('What should be the name of the list?');
    ReadLn(listName);

    WriteLn('What should be the description of the list?');
    ReadLn(listDescription);

    newList.ListName := listName;
    newList.ListDescription := listDescription;

    ClearTerminal;

    WriteLn('You Created list with name: ', newList.ListName);
    AddList(newList);

    ShowLists;

    DrawEmptyLines(2);



    SetLength(options, 2);
    options[0] := 'Add another List';
    options[1] := 'Go back Home';
    DrawOptions(options);

    if Length(userInput) >= 1 then
    begin
        if (userInput[1] >= '0') and (userInput[1] <= '9') then
        begin
            case userInput[1] of
                '1': InputAddList;
                '2': InputDrawHomepage;
                else
                begin
                    WriteLn(#27'[38;5;88m' + 'That was an invalid input.' + #27'[0m');
                    DrawEmptyLines(1);
                    WriteLn('Press any button to go back home...');
                    ReadLn;
                    InputDrawHomepage;
                end;
            end;
        end;
    end;

end;


procedure AddTaskToList(var list: TList; listText: string);
begin
    // List is not an array
    SetLength(list.ListEntities, Length(List.ListEntities) + 1);
end;

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
    if (Length(userInput) <= 1) then
    begin
        case userInput[1] of
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



begin

    InputDrawHomepage;

end.