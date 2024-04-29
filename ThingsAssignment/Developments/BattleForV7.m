function [gameOver, enemyClear] = Battle(playerHp, playerDmg, mapSize, enemyClear)
    enemyHpTable = [2 4 5 6];
    enemyHp = enemyHpTable(randi([1,4]));
    gameOver = false;

    [y,Fs] = audioread('select.wav'); %(from https://sfxr.me)
    select = audioplayer(y,Fs);

    optionTable = [1 2 3];
    optionSelection = false;
    hold off
    hold on
    %transition "animation"
    for i = 1:mapSize/8:mapSize %transition "animation"
        pause(0.1)
        rectangle('position',[0,0,mapSize*100,i*100], 'FaceColor', [0,0,0])
    end
    pause(0.1)
    rectangle('position',[0,0,mapSize*100,mapSize*100], 'FaceColor', [0,0,0])
    for i = 1:mapSize/8:mapSize %transition "animation"
        pause(0.1)
        rectangle('position',[0,0,mapSize*100,i*100], 'FaceColor', [1,1,1])
    end
    hold off
    rectangle('position',[0,0,mapSize*100,mapSize*100], 'FaceColor', [1,1,1])
    pause(0.2)


    %while enemyHp > 0 || playerHp > 0
        battleRefresh(mapSize)
        optionChoice = 1; %sets choice to the middle
        while optionSelection == false %selection menu
            switch optionTable(optionChoice)
                case 1
                    battleRefresh(mapSize)
                    play(select)
                    rectangle('Position',[(mapSize*100)/12,((mapSize*100)-((mapSize*100)/4.5)),(mapSize*100)/4,(mapSize*100)/9],'FaceColor',[1,1,1],'EdgeColor','b')
                    text((mapSize*100)/6.5,((mapSize*100)-((mapSize*100)/6)),'Attack', 'FontSize',18,'Color','b'); %attack beats magic
                case 2
                    battleRefresh(mapSize)
                    play(select)
                    rectangle('Position',[(mapSize*100)/2.65,((mapSize*100)-((mapSize*100)/4.5)),(mapSize*100)/4,(mapSize*100)/9],'FaceColor',[1,1,1],'EdgeColor','b')
                    text((mapSize*100)/2.25,((mapSize*100)-((mapSize*100)/6)),'Defend', 'FontSize',18,'Color','b'); %defend beats attack
                case 3
                    battleRefresh(mapSize)
                    play(select)
                    rectangle('Position',[(mapSize*100)/1.5,((mapSize*100)-((mapSize*100)/4.5)),(mapSize*100)/4,(mapSize*100)/9],'FaceColor',[1,1,1],'EdgeColor','b')
                    text((mapSize*100)/1.35,((mapSize*100)-((mapSize*100)/6)),'Magic', 'FontSize',18, 'Color','b'); %magic beats defend
            end
            waitforbuttonpress
            userInput=double(get(gcf,'CurrentCharacter'))
            switch userInput
                case 29 %right
                    if optionChoice ~= optionTable(length(optionTable))
                        optionChoice = optionChoice + 1
                    end
                case 28 %left
                    if optionChoice ~= optionTable(1)
                        optionChoice = optionChoice - 1
                    end
                case {13,32} %space or enter
                    finalChoice = optionTable(optionChoice)
                    optionSelection = true;%confirms selected choice
            end
        end
        switch finalChoice
            case 1 %attack
                text((mapSize*100)/5.5,(mapSize*100)/2.8,'Attack', 'FontSize',22, 'Color','b')
            case 2 %defend
                text((mapSize*100)/5.5,(mapSize*100)/2.8,'Defend', 'FontSize',22, 'Color','b')
            case 3 %magic
                text((mapSize*100)/5.5,(mapSize*100)/2.8,'Magic', 'FontSize',22, 'Color','b')
        end

        pause(0.5)
        enemyChoice = randi([1,3]);
        switch enemyChoice
            case 1 %attack
                text((mapSize*100)/1.48,(mapSize*100)/6,'Attack', 'FontSize',20, 'Color','r')
            case 2 %defend
                text((mapSize*100)/1.48,(mapSize*100)/6,'Defend', 'FontSize',20, 'Color','r')
            case 3 %magic
                text((mapSize*100)/1.48,(mapSize*100)/6,'Magic', 'FontSize',20, 'Color','r')
        end
    %end

    %checking whether to end or clear (move into while loop to end battle
    if playerHp <= 0
        gameOver = true;
    else
        enemyClear = true;
    end
end