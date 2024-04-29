function[] = battleRefresh(mapSize)
    hold off
    rectangle('position',[0,0,mapSize*100,mapSize*100], 'FaceColor', [1,1,1]) %map bg
    hold on
    rectangle('Position',[0,(mapSize*100)/1.5,(mapSize*100),(mapSize*100)],'FaceColor',[1,1,1],'EdgeColor',[0,0,0]) %selection border

    rectangle('Position',[(mapSize*100)/7.5,(mapSize*100)/2,(mapSize*100)/4,(mapSize*100)/11],'FaceColor',[1,1,1],'EdgeColor',[0,0,0]) %player stand
    rectangle('position',[(mapSize*100)/6,(mapSize*100)/2.5,(mapSize*100)/6,(mapSize*100)/6], 'FaceColor', 'b') %player box

    rectangle('Position',[(mapSize*100)/1.58,(mapSize*100)/3.6,(mapSize*100)/5,(mapSize*100)/12],'FaceColor',[1,1,1],'EdgeColor',[0,0,0]) %Enemy stand
    rectangle('position',[(mapSize*100)/1.5,(mapSize*100)/5,(mapSize*100)/7,(mapSize*100)/7], 'FaceColor', 'r') %enemy box

    %selection boxes
    rectangle('Position',[(mapSize*100)/12,((mapSize*100)-((mapSize*100)/4.5)),(mapSize*100)/4,(mapSize*100)/9],'FaceColor',[1,1,1],'EdgeColor',[0,0,0])
    rectangle('Position',[(mapSize*100)/2.65,((mapSize*100)-((mapSize*100)/4.5)),(mapSize*100)/4,(mapSize*100)/9],'FaceColor',[1,1,1],'EdgeColor',[0,0,0])
    rectangle('Position',[(mapSize*100)/1.5,((mapSize*100)-((mapSize*100)/4.5)),(mapSize*100)/4,(mapSize*100)/9],'FaceColor',[1,1,1],'EdgeColor',[0,0,0])
    text((mapSize*100)/6.5,((mapSize*100)-((mapSize*100)/6)),'Attack', 'FontSize',18); %attack beats magic
    text((mapSize*100)/2.25,((mapSize*100)-((mapSize*100)/6)),'Defend', 'FontSize',18); %defend beats attack
    text((mapSize*100)/1.35,((mapSize*100)-((mapSize*100)/6)),'Magic', 'FontSize',18); %magic beats defend
end