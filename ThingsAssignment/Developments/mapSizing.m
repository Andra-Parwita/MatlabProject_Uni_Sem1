function [playerPosition, ePosition] = mapSizing(mapData, initalPosition, goalPosition, playerPosition) %added in V2
    map = imresize(mapData,100,'nearest');
    ePosition = [initalPosition];
    eGoalPosition = [goalPosition];
    for i = 1:4
        ePosition(i) = playerPosition(i)*100;
        eGoalPosition(i) = goalPosition(i)*100;
    end
    imshow(map)
    rectangle('Position',[ePosition],'FaceColor','b','EdgeColor','b');
    rectangle('Position',[eGoalPosition],'FaceColor','y');
    hold on;
end