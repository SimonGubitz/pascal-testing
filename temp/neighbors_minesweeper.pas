 
function NullfelderAufdecken(index: Integer; columns: Integer): Integer;
var 
	NeighborArray: array[0..5] of Integer;
	CurrentIteration, i: Integer;
    indexRow, searchRow: Integer
    rowCondition: Boolean;
begin
 
	NeighborArray[0] := -columns - 1;
	NeighborArray[1] := -columns;
	NeighborArray[2] := -columns + 1;
	// NeighborArray[3] := -1;
	// NeighborArray[4] := 1;
	NeighborArray[3] := columns - 1;
	NeighborArray[4] := columns;
	NeighborArray[5] := columns + 1;
 
    // do this for all of the Operation
	for i := 0 to Length(NeighborArray) - 1 do
	begin

		CurrentIteration := NeighborArray[i]

		indexRow := Floor(index / columns)
		searchRow := Floor((index + CurrentIteration) / columns)

		if (index > (index + CurrentIteration)) then
		    rowCondition := searchRow < indexRow
		else if (index < (index + CurrentIteration)) then
		    rowCondition := searchRow > indexRow

        // if it isn't < 0
        if (index + CurrentIteration >= 0) and (index + CurrentIteration <= Length(Bomben)-1) then
            if (CountBombsAround(index + CurrentIteration, columns) = 0) and rowCondition the
                NullfelderAufdecken(index + CurrentIteration, columns);


	end;
 
	// Check the immediate neighbors left and right
	// the one to the left exists and it is on the same row
	indexRow := Floor(index / columns);
	searchRow := Floor((index-1) / columns);
	if (index - 1 > 0) and (indexRow = searchRow) then
		if (Bomben[index - 1]) then
		    NullfelderAufdecken(index + CurrentIteration, columns);
    
	indexRow := Floor(index / columns);
	searchRow := Floor((index+1) / columns);
	if (index + 1 > 0) and (indexRow = searchRow) then
		if (Bomben[index + 1]) then
		    NullfelderAufdecken(index + CurrentIteration, columns);
 
	Result := UmliegendeBomben;
end