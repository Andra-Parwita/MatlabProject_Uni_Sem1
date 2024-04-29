function[] = battleRefresh(mapSize, introTrigger, playerHp, enemyHp, enemyHpOg, playerHpOg, name)
    ax = gca;
    zoom(ax, 'reset');
    set(ax, 'xlim', [0 mapSize*100]) %locks zoom apart from mouse

    hold off
    rectangle('position',[0,0,mapSize*100,mapSize*100], 'FaceColor', [1,1,1]) %map bg
    hold on
    rectangle('Position',[0,(mapSize*100)/1.5,(mapSize*100),(mapSize*100)],'FaceColor',[1,1,1],'EdgeColor',[0,0,0]) %selection border
    rectangle('Position',[(mapSize*100)/7.5,(mapSize*100)/2,(mapSize*100)/4,(mapSize*100)/11],'FaceColor',[1,1,1],'EdgeColor',[0,0,0]) %player stand
    rectangle('Position',[(mapSize*100)/1.58,(mapSize*100)/3.6,(mapSize*100)/5,(mapSize*100)/12],'FaceColor',[1,1,1],'EdgeColor',[0,0,0]) %Enemy stand 

    %intro
    if introTrigger == true
        pos = 0;
        for i = 0:0.1:0.5
            pos = pos + (((mapSize*100)/6)/6);
            enemy = rectangle('position',[(mapSize*100)/(1+i),(mapSize*100)/5,(mapSize*100)/7,(mapSize*100)/7], 'FaceColor', 'r'); %enemy box intro
            player = rectangle('position',[pos,(mapSize*100)/2.5,(mapSize*100)/6,(mapSize*100)/6], 'FaceColor', 'b'); %player box
            pause(0.1)
            delete(enemy)
            delete(player)
        end
    else
        rectangle('position',[(mapSize*100)/1.5,(mapSize*100)/5,(mapSize*100)/7,(mapSize*100)/7], 'FaceColor', 'r') %enemy box
        rectangle('position',[(mapSize*100)/6,(mapSize*100)/2.5,(mapSize*100)/6,(mapSize*100)/6], 'FaceColor', 'b') %player box
    end

    %selection boxes
    rectangle('Position',[(mapSize*100)/12,((mapSize*100)-((mapSize*100)/4.5)),(mapSize*100)/4,(mapSize*100)/9],'FaceColor',[1,1,1],'EdgeColor',[0,0,0])
    rectangle('Position',[(mapSize*100)/2.65,((mapSize*100)-((mapSize*100)/4.5)),(mapSize*100)/4,(mapSize*100)/9],'FaceColor',[1,1,1],'EdgeColor',[0,0,0])
    rectangle('Position',[(mapSize*100)/1.5,((mapSize*100)-((mapSize*100)/4.5)),(mapSize*100)/4,(mapSize*100)/9],'FaceColor',[1,1,1],'EdgeColor',[0,0,0])
    text((mapSize*100)/6.5,((mapSize*100)-((mapSize*100)/6)),'Rock', 'FontSize',18); %attack beats magic
    text((mapSize*100)/2.25,((mapSize*100)-((mapSize*100)/6)),'Paper', 'FontSize',18); %defend beats attack
    text((mapSize*100)/1.35,((mapSize*100)-((mapSize*100)/6)),'Scissors', 'FontSize',18); %magic beats defend

    %HealthBar boxes
    rectangle('Position',[0,((mapSize*100)/12),(mapSize*100)/2.5,(mapSize*100)/9],'FaceColor',[1,1,1],'EdgeColor',[0,0,0]) %enemybox
    rectangle('Position',[0,((mapSize*100)/7),(mapSize*100)/2.6,(mapSize*100)/30],'FaceColor',[1,1,1],'EdgeColor',[0,0,0]) %enemyHp box
    if enemyHp > 0
        rectangle('Position',[0,((mapSize*100)/7),((mapSize*100/2.6)*(enemyHp/enemyHpOg)),(mapSize*100)/30],'FaceColor','r') %enemyHp
    end
    text((((mapSize*100)/2.6)/2.4),(((mapSize*100)/6.3)),['HP: ' num2str(enemyHp) '/' num2str(enemyHpOg)], 'Fontsize',12) %Hptxt Enemy
    text((((mapSize*100)/2.6)/2.7),(((mapSize*100)/9)),'Enemy', 'Fontsize',18) %Enemy name

    rectangle('Position',[(mapSize*100)/1.6,((mapSize*100)/2),(mapSize*100)/2.5,(mapSize*100)/9],'FaceColor',[1,1,1],'EdgeColor',[0,0,0]) %playerbox
    rectangle('Position',[(mapSize*100)/1.55,(mapSize*100-(mapSize*100)/2.3),(mapSize*100)/2.6,(mapSize*100)/30],'FaceColor',[1,1,1],'EdgeColor',[0,0,0]) %playerHp box
    if playerHp > 0
        rectangle('Position',[((mapSize*100)/1.55),(mapSize*100-(mapSize*100)/2.3),((mapSize*100)/2.6)*(playerHp/playerHpOg),(mapSize*100)/30],'FaceColor','g') %playerHp
        
    end
    text((((mapSize*100)/1.3)),(mapSize*100-(mapSize*100)/2.1),[name], 'Fontsize',18) %player name
    text((((mapSize*100)/1.27)),(mapSize*100-(mapSize*100)/2.37),['HP: ' num2str(playerHp) '/' num2str(playerHpOg)], 'Fontsize',12) %player HpTxt
end