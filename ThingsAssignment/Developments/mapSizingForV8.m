function [playerPosition, ePosition] = mapSizing(mapData, initalPosition, goalPosition, playerPosition, coinLocations) %added in V2
    map = imresize(mapData,100,'nearest');
    ePosition = [initalPosition];
    eGoalPosition = [goalPosition];
    for i = 1:4
        ePosition(i) = playerPosition(i)*100;
        eGoalPosition(i) = goalPosition(i)*100;
    end
    imshow(map)
    rectangle('Position',[ePosition],'FaceColor','b','EdgeColor','b');
    rectangle('Position',[eGoalPosition],'FaceColor','g');
    for j = 1:size(coinLocations,1)
        rectangle('Position',[coinLocations(j,1)*100,coinLocations(j,2)*100,100,100],'FaceColor','y');
    end
    hold on;
end