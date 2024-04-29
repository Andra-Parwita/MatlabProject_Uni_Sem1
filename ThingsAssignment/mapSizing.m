function [playerPosition, ePosition] = mapSizing(mapData, initalPosition, restorePosition, playerPosition, mapEncounters, name) %added in V2

    %displaying map correctly
    map = imresize(mapData,100,'nearest');
    ePosition = initalPosition;
    eGoalPosition = restorePosition;
    for i = 1:4
        ePosition(i) = playerPosition(i)*100;
        eGoalPosition(i) = restorePosition(i)*100;
    end
    imshow(map)
    rectangle('Position',[ePosition],'FaceColor','b','EdgeColor','b');
    rectangle('Position',[eGoalPosition],'FaceColor','g');
    for j = 1:size(mapEncounters,1)
        for k = 1:size(mapEncounters,2)
            if mapEncounters(j,k) == 3
                rectangle('Position',[(k*100)-100,(j*100)-100,100,100],'FaceColor','y');
            end
        end
    end
    hold on;
end