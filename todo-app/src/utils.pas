unit Utils;

interface
uses
    SysUtils;

procedure ClearTerminal();
procedure DrawEmptyLines(AmountLines: Integer);
procedure InvalidInput(goBackHome: Boolean = true);
function ValidateUserInput(UserInput: string; NumberOfOptions: Integer = 1): Boolean;
function Atoi(InputString: string): Integer;
function CustomDateInput(): TDateTime;


implementation

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

procedure InvalidInput(goBackHome: Boolean = true);
begin
    ClearTerminal;
    WriteLn(#27'[38;5;88m' + 'That was an invalid input.' + #27'[0m');
    DrawEmptyLines(1);
    if (goBackHome) then
        WriteLn('Press any button to go back home...')
    else
        WriteLn('Press any button...');
    ReadLn;
end;

// checks if there are only numbers
function ValidateUserInput(UserInput: string; NumberOfOptions: Integer = 1): Boolean;
begin

    if Length(UserInput) = 0 then
    begin
        InvalidInput();
        Result := false;
    end;


    (*for i := 0 to Length(UserInput) - 1 do
    begin*) // uncomment if there is a case with multiple digits
    if (UserInput[1] >= '0') and (UserInput[1] <= '9') then
    begin
        Result := true;
    end
    else
    begin
        Result := false;
    end;
end;

// Returns -1 if a non-number character is found
function Atoi(InputString: string): Integer;
var
    i: Integer;
    res: Integer;
    digit: Integer;
begin

    res := 0;

    // 1-index strings
    for i := 1 to Length(InputString) do
    begin
        if not((InputString[i] >= '0') and (InputString[i] <= '9')) then
        begin
            Result := -1;
            Exit;
        end;


        digit := Ord(InputString[i]) - Ord('0');

        res := res * 10;
        res := res + digit;


    end;

    Result := res;

end;

function CustomDateInput(): TDateTime;
var
    yearString, monthString, dayString: string;
    yearInt, monthInt, dayInt, monthlyMaxDays: Integer;
begin

    ClearTerminal;




    Write('Please enter a 4 digit Year: ');
    ReadLn(yearString);

    if Length(yearString) <> 4 then
    begin
        InvalidInput(false);
        Exit(CustomDateInput());
    end
    else
    begin
        yearInt := Atoi(yearString);
        if yearInt = -1 then
        begin
            InvalidInput(false);
            Exit(CustomDateInput());
        end;
    end;




    Write('Please enter a max 2 digit month: ');
    ReadLn(monthString);

    if (Length(monthString) > 2) or (Length(monthString) < 1) then
    begin
        InvalidInput(false);
        Exit(CustomDateInput());
    end
    else
    begin
        monthInt := Atoi(monthString);
        if (monthInt < 1) or (monthInt > 12) then
        begin
            InvalidInput(false);
            Exit(CustomDateInput());
        end;
    end;

    case monthInt of
        1, 3, 5, 7, 8, 10, 12:
            monthlyMaxDays := 31;
        4, 6, 9, 11:
            monthlyMaxDays := 30;
        2:
            if ((yearInt mod 4 = 0) and (yearInt mod 100 <> 0)) or (yearInt mod 400 = 0) then
                monthlyMaxDays := 29 // Leap year
            else
                monthlyMaxDays := 28;
        else
            InvalidInput(false);
            Exit(CustomDateInput());
    end;




    Write('Please enter a max 2 digit day (for ', LongMonthNames[monthInt] , ' maximum: ', monthlyMaxDays, '): ');
    ReadLn(dayString);

    if (Length(dayString) > 2) or (Length(dayString) < 1) then
    begin
        InvalidInput(false);
        Exit(CustomDateInput());
    end
    else
    begin
        dayInt := Atoi(dayString);
        if (dayInt < 1) or (dayInt > monthlyMaxDays) then
        begin
            InvalidInput(false);
            Exit(CustomDateInput());
        end;
    end;

    Result := EncodeDate(yearInt, monthInt, dayInt);

end;

end.