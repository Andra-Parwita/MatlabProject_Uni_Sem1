clc
clear

%Map Variables
mapSize = menu();
mapRows = mapSize;
mapCols = mapSize;
mapEncounters = [];
initalPosition = [0 0 1 1]; %play starting pos
restorePosition = [1 1 1 1]; 
playerPosition = initalPosition;
coins = 0;
wallBreaks = 5;

%player Variables
playerHp = 10;
playerDmg = [1,2];

%sound 
[y,Fs] = audioread('bump.wav'); %(from https://sfxr.me)
bump = audioplayer(y,Fs);
[y,Fs] = audioread('boom.wav'); %(from https://sfxr.me)
boom = audioplayer(y,Fs);
[y,Fs] = audioread('BattleIn.wav'); %(from Beep box)
batIn = audioplayer(y,Fs);
[y,Fs] = audioread('step.wav'); %(from https://sfxr.me)
step = audioplayer(y,Fs);
[y,Fs] = audioread('select.wav'); %(from https://sfxr.me)
select = audioplayer(y,Fs);
[y,Fs] = audioread('coin.wav'); %(from https://sfxr.me)
coin = audioplayer(y,Fs);




%Map encounter generation
for row = 1:mapRows
    mapEncounterRow = [];
    for col = 1:mapCols
        mapEncounterInstance = randi([0,2]);
        mapEncounterRow = [mapEncounterRow mapEncounterInstance];
    end
    mapEncounters = [mapEncounters;mapEncounterRow];
end

mapEncounters((restorePosition(1)+1),(restorePosition(2)+1)) = 1; %Ensure inital point is free
mapEncounters(1,1) = 1;

%coin generation
coinLocations = []; %random coin locations generation
for p = 1:5
    coinLocationsCol = [];
    for k = 1:2
        CoinR = randi([2,mapSize-1]);
        coinLocationsCol = [coinLocationsCol CoinR];
    end
    coinLocations = [coinLocations; coinLocationsCol];
end

for c = 1:size(coinLocations,1) %adding locations to encounters
    mapEncounters(coinLocations(c,2)+1,coinLocations(c,1)+1) = 3;
end

mapEncounters

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
        else
        end
    end
end


%Main 
gameStart = true;
mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters)
enemyClear = false;

while gameStart %Game loop
    if mapEncounters(playerPosition(2)+1,playerPosition(1)+1) == 2
        opponentChance = randi([1,(10-coins)]); %gets harder with more coins (higher chance)
        if opponentChance == 1
            play(batIn);
            [gameOver, enemyClear] = battle(playerHp, playerDmg, mapSize, enemyClear,coins);
            if gameOver == true %game over
                text((mapSize*100/2),(mapSize*100/2),'Game Over!', 'Color', 'r', 'FontSize',40);
                for i = 0:(mapSize*100/10):(mapSize*100) %animation falling
                    player = rectangle('position',[(mapSize*100)/6,i,(mapSize*100)/6,(mapSize*100)/6], 'FaceColor', 'b'); %player box
                    pause(0.1)
                    delete(player)
                    if i == mapSize*100
                        play(bump)
                    end
                end
                gameStart = false;
                pause(5)
                close all
                break
            elseif enemyClear == true %checking to remove defeated enemy from map
                mapEncounters(playerPosition(2)+1,playerPosition(1)+1) = 1;
                wallBreaks = wallBreaks + 2;
                playerHp = playerHp +1;
                enemyClear = false; %reset 
                [playerPosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
            end
        end
    elseif mapEncounters(playerPosition(2)+1,playerPosition(1)+1) == 3 %checking if at a coin
        coins = coins +1
        play(coin)
        mapEncounters(playerPosition(2)+1,playerPosition(1)+1) = 1;
        [playerPosition, ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
    elseif playerPosition == restorePosition %if at the restore point
        if wallBreaks < 5
            [playerPosition, ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
            text((ePosition(1)-230),(ePosition(2)-40),'Restored Wallbreaks!', 'Color', 'g', 'FontSize',14);
            wallBreaks = 5;
            hold off
        end
    end
    if coins == 5 %game win (add win ani)
        break
    end
    waitforbuttonpress
    userInput=double(get(gcf,'CurrentCharacter'));
    switch userInput %checks which inpput
        case 27 %esc
            close all
            break
        case 29 %right (right arrow key)
            if playerPosition(1) <= mapSize-2 && mapEncounters(playerPosition(2)+1,playerPosition(1)+2) ~= 0
                playerPosition(1) = playerPosition(1) + 1;
                play(step);
                [playerPosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
            else
                fprintf("Border! \n")
                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                hold off
                text((ePosition(1)-15),(ePosition(2)-40),'Wall!', 'Color', 'r', 'FontSize',14);
                play(bump);
                hold off
            end
        case 28 %left (left arrow key)
            if playerPosition(1) >= 1 && mapEncounters(playerPosition(2)+1,playerPosition(1)) ~= 0
                playerPosition(1) = playerPosition(1) - 1;
                play(step);
                [playerPosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
            else
                fprintf("Border! \n")
                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                hold off
                text((ePosition(1)-15),(ePosition(2)-40),'Wall!', 'Color', 'r', 'FontSize',14);
                play(bump);
                hold off
            end
        case 31 %down (down arrow key)
            if playerPosition(2) <= mapSize-2 && mapEncounters(playerPosition(2)+2,playerPosition(1)+1) ~= 0
                playerPosition(2) = playerPosition(2) + 1;
                play(step);
                [playerPosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
            else
                fprintf("Border! \n")
                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                hold off
                text((ePosition(1)-15),(ePosition(2)-40),'Wall!', 'Color', 'r', 'FontSize',14);
                play(bump);
                hold off
            end
        case 30 %up (up arrow key)
            if playerPosition(2) >= 1 && mapEncounters(playerPosition(2),playerPosition(1)+1) ~= 0
                playerPosition(2) = playerPosition(2) - 1;
                play(step);
                [playerPosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
            else
                fprintf("Border! \n")
                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                hold off
                text((ePosition(1)-15),(ePosition(2)-40),'Wall!', 'Color', 'r', 'FontSize',14);
                play(bump);
                hold off
            end
        case 32 %wall breaking (space)
            if wallBreaks > 0;
                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                text((ePosition(1)-80),(ePosition(2)-40),'Wall Break', 'Color', 'r', 'FontSize',14);
                waitforbuttonpress
                userInput=double(get(gcf,'CurrentCharacter'));
                hold off
                play(select)
                switch userInput %checks which inpput
                    case 29 %Break right wall
                        text(ePosition(1),ePosition(2)+30,'\rightarrow', 'Color', 'r', 'FontSize',24);
                        hold off
                        waitforbuttonpress
                        userInput=double(get(gcf,'CurrentCharacter'));
                        if userInput == 29 && playerPosition(1) ~= 19 
                            if mapEncounters(playerPosition(2)+1,playerPosition(1)+2) == 0 %confirmation of wall break
                                mapEncounters(playerPosition(2)+1,playerPosition(1)+2) = 1;
                                mapData = mapEncounters;
                                play(boom);
                                wallBreaks = wallBreaks -1;
                                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                            else  %if no wall in inputed direction
                                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                                text((ePosition(1)-60),(ePosition(2)-40),'No Wall!', 'Color', 'r', 'FontSize',14);
                                hold off
                            end
                        else  %if no wall in inputed direction
                            [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                            text((ePosition(1)-60),(ePosition(2)-40),'No Wall!', 'Color', 'r', 'FontSize',14);
                            hold off
                        end
                    case 28 %Break left wall
                        text(ePosition(1),ePosition(2)+30,'\leftarrow', 'Color', 'r', 'FontSize',24);
                        hold off
                        waitforbuttonpress
                        userInput=double(get(gcf,'CurrentCharacter'));
                        if userInput == 28 && playerPosition(1) ~= 0
                            if mapEncounters(playerPosition(2)+1,playerPosition(1)) == 0 %confirmation of wall break
                                mapEncounters(playerPosition(2)+1,playerPosition(1)) = 1;
                                mapData = mapEncounters;
                                play(boom);
                                wallBreaks = wallBreaks -1;
                                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                            else  %if no wall in inputed direction
                                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                                text((ePosition(1)-60),(ePosition(2)-40),'No Wall!', 'Color', 'r', 'FontSize',14);
                                hold off
                            end
                        else
                            [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                            text((ePosition(1)-60),(ePosition(2)-40),'No Wall!', 'Color', 'r', 'FontSize',14);
                            hold off
                        end
                    case 31 %Break bottom wall
                        text(ePosition(1)+30,ePosition(2)+30,'\downarrow', 'Color', 'r', 'FontSize',24);
                        hold off
                        waitforbuttonpress
                        userInput=double(get(gcf,'CurrentCharacter'));
                        if userInput == 31 && playerPosition(2) ~= 19
                            if mapEncounters(playerPosition(2)+2,playerPosition(1)+1) == 0 %confirmation of wall break
                                mapEncounters(playerPosition(2)+2,playerPosition(1)+1) = 1;
                                mapData = mapEncounters;
                                play(boom);
                                wallBreaks = wallBreaks -1;
                                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                            else  %if no wall in inputed direction
                                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                                text((ePosition(1)-60),(ePosition(2)-40),'No Wall!', 'Color', 'r', 'FontSize',14);
                                hold off
                            end
                        else
                            [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                            text((ePosition(1)-60),(ePosition(2)-40),'No Wall!', 'Color', 'r', 'FontSize',14);
                            hold off
                        end
                    case 30 %Break top wall
                        text(ePosition(1)+30,ePosition(2)+30,'\uparrow', 'Color', 'r', 'FontSize',24);
                        hold off
                        waitforbuttonpress
                        userInput=double(get(gcf,'CurrentCharacter'));
                        if userInput == 30 && playerPosition(2) ~= 0
                            if mapEncounters(playerPosition(2),playerPosition(1)+1) == 0
                                mapEncounters(playerPosition(2),playerPosition(1)+1) = 1;
                                play(boom);
                                wallBreaks = wallBreaks -1;
                                mapData = mapEncounters;
                                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                            else  %if no wall in inputed direction
                                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                                text((ePosition(1)-60),(ePosition(2)-40),'No Wall!', 'Color', 'r', 'FontSize',14);
                                hold off
                            end
                        else
                            [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                            text((ePosition(1)-60),(ePosition(2)-40),'No Wall!', 'Color', 'r', 'FontSize',14);
                            hold off
                        end
                    otherwise
                end
            else
                play(bump)
                [playerPosition,ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters);
                text((ePosition(1)-200),(ePosition(2)-40),'No Wall Breaks left!', 'Color', 'r', 'FontSize',14);
            end
        otherwise
    end
end
