clc
clear

%Map Variables
mapSize = 20;
mapRows = mapSize;
mapCols = mapSize;
mapEncounters = [];
initalPosition = [0 0 1 1];
goalPosition = [2 6 1 1];
playerPosition = initalPosition;

%Map encounter generation
for row = 1:mapRows
    mapEncounterRow = [];
    for col = 1:mapCols
        mapEncounterInstance = randi([0,2]);
        mapEncounterRow = [mapEncounterRow mapEncounterInstance];
    end
    mapEncounters = [mapEncounters;mapEncounterRow];
end

mapEncounters((goalPosition(1)+1),(goalPosition(2)+1)) = 1; %Ensure inital point is free for the player
mapEncounters(1,1) = 1; 

%Map visuals
mapData = mapEncounters;
for i = 1:mapRows
    for j = 1:mapCols
        if mapEncounters(i,j) == 0 %Wall
            mapData(i,j) = uint8(0);
        elseif mapEncounters(i,j) == 1 %Empty
            mapData(i,j) = uint8(1);
        elseif mapEncounters(i,j) == 2 %Dangerous
            mapData(i,j) = uint8(1);
        end
    end
end

%Main 
gameStart = true;
mapSizing(mapData, initalPosition, goalPosition, playerPosition) %added Map sizing Function to scale map up

while gameStart %Game loop
    waitforbuttonpress
    userInput=double(get(gcf,'CurrentCharacter'))
    switch userInput %checks which inpput
        case 29 %right (right arrow key)
            if playerPosition(1) <= mapSize-2 && mapEncounters(playerPosition(2)+1,playerPosition(1)+2) ~= 0
                playerPosition(1) = playerPosition(1) + 1;
                [playerPosition] = mapSizing(mapData, initalPosition, goalPosition, playerPosition);
            else
                fprintf("Border! \n")
                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, goalPosition, playerPosition);
                text((ePosition(1)-15),(ePosition(2)-40),'Wall!', 'Color', 'r', 'FontSize',14);
                hold off
            end
        case 28 %left (left arrow key)
            if playerPosition(1) >= 1 && mapEncounters(playerPosition(2)+1,playerPosition(1)) ~= 0
                playerPosition(1) = playerPosition(1) - 1;
                [playerPosition] = mapSizing(mapData, initalPosition, goalPosition, playerPosition);
            else
                fprintf("Border! \n")
                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, goalPosition, playerPosition);
                text((ePosition(1)-15),(ePosition(2)-40),'Wall!', 'Color', 'r', 'FontSize',14);
                hold off
            end
        case 31 %down (down arrow key)
            if playerPosition(2) <= mapSize-2 && mapEncounters(playerPosition(2)+2,playerPosition(1)+1) ~= 0
                playerPosition(2) = playerPosition(2) + 1;
                [playerPosition] = mapSizing(mapData, initalPosition, goalPosition, playerPosition);
            else
                fprintf("Border! \n")
                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, goalPosition, playerPosition);
                text((ePosition(1)-15),(ePosition(2)-40),'Wall!', 'Color', 'r', 'FontSize',14);
                hold off
            end
        case 30 %up (up arrow key)
            if playerPosition(2) >= 1 && mapEncounters(playerPosition(2),playerPosition(1)+1) ~= 0
                playerPosition(2) = playerPosition(2) - 1;
                [playerPosition] = mapSizing(mapData, initalPosition, goalPosition, playerPosition);
            else
                fprintf("Border! \n")
                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, goalPosition, playerPosition);
                text((ePosition(1)-15),(ePosition(2)-40),'Wall!', 'Color', 'r', 'FontSize',14);
                hold off
            end
        otherwise
    end
end
