function [gameOver, enemyClear] = battle(playerHp, playerDmg, mapSize, enemyClear)
    playerHpOg = playerHp;
    enemyHpTable = [2 4 5 6];
    enemyHp = enemyHpTable(randi([1,4]));
    enemyHpOg = enemyHp;
    gameOver = false;
    introTrigger = true;

    %battle audio
    [y,Fs] = audioread('select.wav'); %(from https://sfxr.me)
    select = audioplayer(y,Fs);
    [y,Fs] = audioread('selectDouble.wav'); %(from https://sfxr.me)
    selectDouble = audioplayer(y,Fs);
    [y,Fs] = audioread('hurt.wav'); %(from https://sfxr.me)
    hurt = audioplayer(y,Fs);
    [y,Fs] = audioread('enemyHurt.wav'); %(from https://sfxr.me)
    enemyHurt = audioplayer(y,Fs);
    [y,Fs] = audioread('glorb.wav'); %(from https://sfxr.me)
    glorb = audioplayer(y,Fs);
    [y,Fs] = audioread('bewp.wav'); %(from https://sfxr.me)
    bewp = audioplayer(y,Fs);
    [y,Fs] = audioread('slorb.wav'); %(from https://sfxr.me)
    slorb = audioplayer(y,Fs);
    [y,Fs] = audioread('battleWin.wav'); %(from https://sfxr.me)
    batWin = audioplayer(y,Fs);
    
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

    battleRefresh(mapSize, introTrigger, playerHp, enemyHp, enemyHpOg, playerHpOg)
    introTrigger = false;
    optionChoice = 2; %sets choice to the middle

    %main
    while enemyHp > 0 && playerHp > 0
        battleRefresh(mapSize, introTrigger, playerHp, enemyHp, enemyHpOg, playerHpOg)
        optionSelection = false;
        %player turn
        while optionSelection == false %selection menu
            switch optionTable(optionChoice)
                case 1
                    battleRefresh(mapSize, introTrigger, playerHp, enemyHp, enemyHpOg, playerHpOg)
                    play(select)
                    rectangle('Position',[(mapSize*100)/12,((mapSize*100)-((mapSize*100)/4.5)),(mapSize*100)/4,(mapSize*100)/9],'FaceColor',[1,1,1],'EdgeColor','b')
                    text((mapSize*100)/6.5,((mapSize*100)-((mapSize*100)/6)),'Rock', 'FontSize',18,'Color','b'); %rock
                case 2
                    battleRefresh(mapSize, introTrigger, playerHp, enemyHp, enemyHpOg, playerHpOg)
                    play(select)
                    rectangle('Position',[(mapSize*100)/2.65,((mapSize*100)-((mapSize*100)/4.5)),(mapSize*100)/4,(mapSize*100)/9],'FaceColor',[1,1,1],'EdgeColor','b')
                    text((mapSize*100)/2.25,((mapSize*100)-((mapSize*100)/6)),'Paper', 'FontSize',18,'Color','b'); %paper
                case 3
                    battleRefresh(mapSize, introTrigger, playerHp, enemyHp, enemyHpOg, playerHpOg)
                    play(select)
                    rectangle('Position',[(mapSize*100)/1.5,((mapSize*100)-((mapSize*100)/4.5)),(mapSize*100)/4,(mapSize*100)/9],'FaceColor',[1,1,1],'EdgeColor','b')
                    text((mapSize*100)/1.35,((mapSize*100)-((mapSize*100)/6)),'Scissors', 'FontSize',18, 'Color','b'); %scissors
            end
            waitforbuttonpress
            userInput=double(get(gcf,'CurrentCharacter'));
            switch userInput
                case 29 %right
                    if optionChoice ~= optionTable(length(optionTable))
                        optionChoice = optionChoice + 1;
                    end
                case 28 %left
                    if optionChoice ~= optionTable(1)
                        optionChoice = optionChoice - 1;
                    end
                case {13,32} %space or enter
                    finalChoice = optionTable(optionChoice);
                    play(selectDouble)
                    optionSelection = true;%confirms selected choice
            end
        end
        switch finalChoice %checks what choice made
            case 1 %attack
                text((mapSize*100)/5.5,(mapSize*100)/2.8,'Rock', 'FontSize',22, 'Color','b')
            case 2 %defend
                text((mapSize*100)/5.5,(mapSize*100)/2.8,'Paper', 'FontSize',22, 'Color','b')
            case 3 %magic
                text((mapSize*100)/5.5,(mapSize*100)/2.8,'Scissors', 'FontSize',22, 'Color','b')
        end

        %enemy turn
        pause(0.5)
        enemyChoice = randi([1,3]);
        switch enemyChoice
            case 1 %attack
                text((mapSize*100)/1.48,(mapSize*100)/6,'Rock', 'FontSize',20, 'Color','r')
                play(glorb)
            case 2 %defend
                text((mapSize*100)/1.48,(mapSize*100)/6,'Paper', 'FontSize',20, 'Color','r')
                play(slorb)
            case 3 %magic
                text((mapSize*100)/1.48,(mapSize*100)/6,'Scissors', 'FontSize',20, 'Color','r')
                play(bewp)
        end
        pause(1)

        %checking who wins the turn
        if (enemyChoice == 1 && finalChoice == 3) || (enemyChoice == 2 && finalChoice == 1) || (enemyChoice == 3 && finalChoice == 2)
            playerHp = playerHp - 1;
            play(hurt)
        elseif (finalChoice == 1 && enemyChoice == 3) ||(finalChoice == 2 && enemyChoice == 1) ||(finalChoice == 3 && enemyChoice == 2)
            enemyHp = enemyHp - randi([playerDmg]);
            play(enemyHurt)
        elseif enemyChoice == finalChoice
            tieBreak = randi([1,2]);
            switch tieBreak
                case 1
                    enemyHp = enemyHp - randi([playerDmg]);
                    playerHp = playerHp - 1;
                    play(hurt)
                    play(enemyHurt)
                case 2
                    %nothing in the tie
            end
        end
        battleRefresh(mapSize, introTrigger, playerHp, enemyHp, enemyHpOg, playerHpOg)

    end

    %transition "animation"
    play(batWin)
    pause(0.5)
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

    %checking whether to end game or clear
    if playerHp <= 0
        gameOver = true;
    else
        enemyClear = true;
    end
end